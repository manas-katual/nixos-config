import {Astal, Gtk} from "astal/gtk4"
import {bind, Variable} from "astal"
import Hyprland from "gi://AstalHyprland"
import {execAsync} from "astal/process"
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../common/RevealerRow";
import {hideAllWindows} from "../utils/windows";
import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import OkButton, {OkButtonSize} from "../common/OkButton";

export const ScreenshareWindowName = "screenshareWindow"

let response: (response: any) => void = () => {}

export function updateResponse(res: (response: any) => void) {
    response = res
}

const screenShareWindows = Variable<Program[]>([])

type ScreenShareWindow = {
    windowId: string;
    windowProgram: string;
    instanceTitle: string;
};

type Program = {
    name: string;
    windows: ScreenShareWindow[];
};

function parseScreenShareString(input: string): ScreenShareWindow[] {
    // Remove the "screenshare" prefix
    const content = input.replace(/^screenshare/, "");

    // Split the string into parts based on "[HC>]"
    const parts = content.split("[HE>]").filter(part => part.trim() !== "");

    // Map each part to an object
    return parts.filter((part) => {
        return part.includes("[HC>]") && part.includes("[HT>]")
    }).map(part => {
        const [hc, htAndHe] = part.split("[HC>]");
        const [ht, he] = htAndHe.split("[HT>]");

        return {
            windowId: hc.trim(),
            windowProgram: ht?.trim() || "",
            instanceTitle: he?.trim() || "",
        };
    });
}

function groupByWindowProgram(windows: ScreenShareWindow[]): Program[] {
    const grouped: Program[] = [];

    windows.forEach(window => {
        // Find an existing group for this windowProgram
        let group = grouped.find(g => g.name === window.windowProgram);

        // If no group exists, create one
        if (!group) {
            group = { name: window.windowProgram, windows: [] };
            grouped.push(group);
        }

        // Add the window to the group
        group.windows.push(window);
    });

    return grouped;
}

export function updateWindows(input: string) {
    screenShareWindows.set(groupByWindowProgram(parseScreenShareString(input)))
}

function Monitors() {
    const hyprland = Hyprland.get_default()

    return <RevealerRow
        icon={"󰍹"}
        iconOffset={0}
        windowName={ScreenshareWindowName}
        content={
            <label
                hexpand={true}
                label="Monitors"
                halign={Gtk.Align.START}
                cssClasses={["labelLargeBold"]}/>
        }
        revealedContent={
            <box
                marginTop={8}
                marginBottom={8}
                vertical={true}
                spacing={12}>
                {bind(hyprland, "monitors").as((monitors) => {
                    return monitors.map((monitor) => {
                            return <OkButton
                                size={OkButtonSize.MEDIUM}
                                bold={true}
                                hexpand={true}
                                primary={true}
                                labelHalign={Gtk.Align.START}
                                label={monitor.name}
                                onClicked={() => {
                                    response(`[SELECTION]/screen:${monitor.name}`)
                                    hideAllWindows()
                                }}/>
                        }
                    )
                })}
            </box>
        }
    />
}

function Windows() {
    return <RevealerRow
        icon={""}
        iconOffset={0}
        windowName={ScreenshareWindowName}
        content={
            <label
                hexpand={true}
                label="Windows"
                halign={Gtk.Align.START}
                cssClasses={["labelLargeBold"]}/>
        }
        revealedContent={
            <box
                marginTop={8}
                marginBottom={8}
                vertical={true}
                spacing={12}>
                {screenShareWindows((programs) => {
                    return programs
                        .sort((a, b) => {
                            if (a.name > b.name) {
                                return 1
                            } else {
                                return -1
                            }
                        })
                        .map((program) => {
                            return <box
                                vertical={true}
                                spacing={6}>
                                <label
                                    halign={Gtk.Align.CENTER}
                                    cssClasses={["labelLargeBold"]}
                                    label={program.name}/>
                                {program.windows
                                    .sort((a, b) => {
                                        if (a.instanceTitle > b.instanceTitle) {
                                            return 1
                                        } else {
                                            return -1
                                        }
                                    })
                                    .map((instance) => {
                                        return <OkButton
                                            size={OkButtonSize.MEDIUM}
                                            bold={true}
                                            primary={true}
                                            hexpand={true}
                                            labelHalign={Gtk.Align.START}
                                            label={`${instance.instanceTitle}`}
                                            ellipsize={Pango.EllipsizeMode.END}
                                            onClicked={() => {
                                                response(`[SELECTION]/window:${instance.windowId}`)
                                                hideAllWindows()
                                            }}/>
                                    })
                                }
                            </box>
                        })
                })}
            </box>
        }
    />
}

function Region() {
    return <RevealerRow
        icon={""}
        iconOffset={0}
        windowName={ScreenshareWindowName}
        content={
            <label
                hexpand={true}
                label="Other"
                halign={Gtk.Align.START}
                cssClasses={["labelLargeBold"]}/>
        }
        revealedContent={
            <box
                marginTop={8}
                marginBottom={8}>
                <OkButton
                    size={OkButtonSize.MEDIUM}
                    bold={true}
                    primary={true}
                    hexpand={true}
                    labelHalign={Gtk.Align.START}
                    label="Region"
                    onClicked={() => {
                        execAsync("slurp -f \"%o %x %y %w %h\"")
                            .catch((error) => {
                                console.error(error)
                                response(`[SELECTION]/region:`)
                            })
                            .then((value) => {
                                if (typeof value === "string") {
                                    const [name, x, y, w, h] = value.split(" ")
                                    response(`[SELECTION]/region:${name}@${x},${y},${w},${h}`)
                                } else {
                                    response(`[SELECTION]/region:`)
                                }
                            })
                            .finally(() => {
                                hideAllWindows()
                            })
                    }}/>
            </box>
        }
    />
}

export default function () {
    return <ScrimScrollWindow
        namespace={"okpanel-screenshare"}
        monitor={variableConfig.mainMonitor()}
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        windowName={ScreenshareWindowName}
        topExpand={true}
        bottomExpand={true}
        leftExpand={false}
        rightExpand={false}
        contentWidth={560}
        content={
            <box
                vertical={true}
                marginStart={10}
                marginBottom={10}
                marginTop={20}
                marginEnd={10}
                spacing={8}>
                <Monitors/>
                <Windows/>
                <Region/>
            </box>
        }/>
}