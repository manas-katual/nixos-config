import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import {Bar, selectedBar} from "../../config/bar";
import {bind, Variable} from "astal";
import {execAsync} from "astal/process";
import {App, Gtk} from "astal/gtk4";
import {hideAllWindows} from "../utils/windows";
import Divider from "../common/Divider";
import {BarWidget} from "../../config/schema/definitions/barWidgets";
import OkButton, {OkButtonHorizontalPadding} from "../common/OkButton";
import AsyncClipboardPicture from "./AsyncClipboardPicture";
import AsyncClipboardLabel from "./AsyncClipboardLabel";

import {projectDir} from "../../app";

export const ClipboardManagerWindowName = "clipboardManagerWindow"
let cliphistStarted = false

type Entry = {
    number: number;
    value: string;
};

const clipboardEntries = Variable<Entry[]>([])

function getImageType(entry: Entry): string | null {
    const pattern = /^\[\[ binary data (\d+(?:\.\d+)?) ([A-Za-z]+) ([a-z0-9]+) (\d+)x(\d+) \]\]$/;

    const match = entry.value.match(pattern);

    if (match) {
        return match[3].toLowerCase()
    } else {
        return null
    }
}

// starts cliphist.  Defaults are from the ~/.config/cliphist/config file which is
// created by the okpanel run command.
export function startCliphist() {
    if (cliphistStarted) {
        return
    }
    cliphistStarted = true
    console.log("Starting cliphist...")

    // text
    execAsync(`${projectDir}/shellScripts/cliphistStore.sh`)
        .catch((error) => {
            console.error(error)
        })

    // images
    execAsync(["bash", "-c", `wl-paste --type image --watch cliphist store`])
        .catch((error) => {
            console.error(error)
        })
}

function updateClipboardEntries() {
    execAsync(["bash", "-c", `cliphist list`])
        .catch((error) => {
            console.error(error)
        }).then((value) => {
            if (typeof value !== "string") {
                return
            }

            if (value.trim() === "") {
                clipboardEntries.set([])
                return
            }

            const entries: Entry[] = value
                .split("\n")
                .map(line => {
                    const [numStr, ...textParts] = line.split("\t");
                    return {
                        number: parseInt(numStr, 10),
                        value: textParts.join("\t").trim()
                    };
                });

            clipboardEntries.set(entries)
    })
}

function copyEntry(entry: Entry) {
    const imageType = getImageType(entry)
    if (imageType !== null) {
        execAsync(["bash", "-c", `cliphist decode ${entry.number} | wl-copy --type image/${imageType}`])
            .catch((error) => {
                console.error(error)
            })
    } else {
        execAsync(["bash", "-c", `cliphist decode ${entry.number} | wl-copy`])
            .catch((error) => {
                console.error(error)
            })
    }
}

function deleteEntry(entry: Entry) {
    execAsync(`cliphist delete-query ${entry.value}`)
        .catch((error) => {
            console.error(error)
        }).finally(() => {
            updateClipboardEntries()
        })
}

function wipeHistory() {
    execAsync(`cliphist wipe`)
        .catch((error) => {
            console.error(error)
        }).finally(() => {
        updateClipboardEntries()
    })
}

export function ClipboardManagerContent() {
    return <box
        vertical={true}>
        {clipboardEntries((entries) => {
            return <box
                vertical={true}>
                {entries.length === 0 &&
                    <label
                        hexpand={true}
                        halign={Gtk.Align.CENTER}
                        label="Empty"
                        cssClasses={["labelMedium"]}/>
                }
                {entries.length > 0 &&
                    <box
                        marginBottom={16}>
                        <OkButton
                            hexpand={true}
                            label="Delete all"
                            primary={true}
                            onClicked={() => {
                                wipeHistory()
                            }}/>
                    </box>
                }
                {entries.map((entry) => {
                    const imageType = getImageType(entry)
                    const isImage = imageType !== null

                    let content

                    if (isImage) {
                        content = <AsyncClipboardPicture
                            cliphistId={entry.number}/>
                    } else {
                        content = <AsyncClipboardLabel
                            cliphistId={entry.number}/>
                    }

                    return <box
                        vertical={true}>
                        <box
                            vertical={false}>
                            {content}
                            <box
                                vertical={false}
                                vexpand={false}>
                                <OkButton
                                    hpadding={OkButtonHorizontalPadding.THIN}
                                    valign={Gtk.Align.START}
                                    label=""
                                    onClicked={() => {
                                        copyEntry(entry)
                                        hideAllWindows()
                                    }}/>
                                <OkButton
                                    hpadding={OkButtonHorizontalPadding.THIN}
                                    valign={Gtk.Align.START}
                                    label=""
                                    onClicked={() => {
                                        deleteEntry(entry)
                                    }}/>
                            </box>
                        </box>
                        <box marginTop={10}/>
                        {entries[entries.length - 1] !== entry && <Divider marginBottom={10}/>}
                    </box>
                })}
            </box>
        })}
    </box>
}

export default function () {
    updateClipboardEntries()

    setTimeout(() => {
        bind(App.get_window(ClipboardManagerWindowName)!, "visible").subscribe((visible) => {
            if (visible) {
                updateClipboardEntries()
            }
        })
    }, 1_000)

    const topExpand = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.centerWidgets,
        variableConfig.verticalBar.bottomWidgets,
    ], (bar, center, bottom) => {
        switch (bar) {
            case Bar.BOTTOM:
                return true
            case Bar.LEFT:
            case Bar.RIGHT:
                return center.includes(BarWidget.CLIPBOARD_MANAGER)
                    || bottom.includes(BarWidget.CLIPBOARD_MANAGER)
            default: return false
        }
    })

    const bottomExpand = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.centerWidgets,
        variableConfig.verticalBar.topWidgets,
    ], (bar, center, top) => {
        switch (bar) {
            case Bar.TOP:
                return true
            case Bar.LEFT:
            case Bar.RIGHT:
                return center.includes(BarWidget.CLIPBOARD_MANAGER)
                    || top.includes(BarWidget.CLIPBOARD_MANAGER)
            default: return false
        }
    })

    const leftExpand = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.centerWidgets,
        variableConfig.horizontalBar.rightWidgets,
    ], (bar, center, right) => {
        switch (bar) {
            case Bar.RIGHT:
                return true
            case Bar.TOP:
            case Bar.BOTTOM:
                return center.includes(BarWidget.CLIPBOARD_MANAGER)
                    || right.includes(BarWidget.CLIPBOARD_MANAGER)
            default: return false
        }
    })

    const rightExpand = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.centerWidgets,
        variableConfig.horizontalBar.leftWidgets,
    ], (bar, center, left) => {
        switch (bar) {
            case Bar.LEFT:
                return true
            case Bar.TOP:
            case Bar.BOTTOM:
                return center.includes(BarWidget.CLIPBOARD_MANAGER)
                    || left.includes(BarWidget.CLIPBOARD_MANAGER)
            default: return false
        }
    })

    return <ScrimScrollWindow
        namespace={"okpanel-clipboard-manager"}
        monitor={variableConfig.mainMonitor()}
        windowName={ClipboardManagerWindowName}
        topExpand={topExpand()}
        bottomExpand={bottomExpand()}
        leftExpand={leftExpand()}
        rightExpand={rightExpand()}
        contentWidth={400}
        width={variableConfig.horizontalBar.minimumWidth()}
        height={variableConfig.verticalBar.minimumHeight()}
        content={
            <box
                cssClasses={["clipboardBox"]}
                vertical={true}>
                <label
                    marginBottom={16}
                    cssClasses={["labelMedium"]}
                    label="Clipboard History"/>
                <ClipboardManagerContent/>
            </box>
        }/>
}