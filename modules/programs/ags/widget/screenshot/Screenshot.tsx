import {App, Astal, Gdk, Gtk} from "astal/gtk4"
import {execAsync} from "astal/process"
import {bind, Variable, GLib} from "astal"
import Divider from "../common/Divider";
import Pango from "gi://Pango?version=1.0";
import {playCameraShutter} from "../utils/audio";
import RevealerRow from "../common/RevealerRow";
import {hideAllWindows} from "../utils/windows";
import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import OkButton from "../common/OkButton";

import {projectDir} from "../../app";

export const isRecording = Variable(false)

export const ScreenshotWindowName = "screenshotWindow"

type AudioSource = {
    name: string;
    description: string;
    isMonitor: boolean;
};

type Codec = {
    display: string;
    lib: string;
}

enum SaveType {
    BOTH = 0,
    CLIPBOARD = 1,
    FILE = 2,
}

const saveTypeValues = (Object.values(SaveType) as SaveType[]).filter((v): v is SaveType => typeof v === "number")

const audioOptions = Variable<AudioSource[]>([])
const codecs: Codec[] = [
    {
        display: "H264",
        lib: "libx264"
    },
    {
        display: "H265",
        lib: "libx265"
    },
]
const h264EncodingPresets = [
    "ultrafast",
    "superfast",
    "veryfast",
    "faster",
    "fast",
    "medium",
    "slow",
    "slower",
    "veryslow"
]
const crfQualityValues = [
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26
]

const delayOptions = [
    0,
    1,
    2,
    3,
    5,
    10
]

let screenshotDir = ""
let screenRecordingDir = ""

function getEncodingPresetIcon(value: string) {
    if (value.includes("fast")) {
        return "󰓅"
    } else if (value.includes("medium")) {
        return "󰾅"
    } else {
        return "󰾆"
    }
}

function getCrfQualityIcon(value: number) {
    if (value > 23) {
        return "󰨌"
    } else if (value > 20) {
        return "󰨍"
    } else {
        return "󰐵"
    }
}

function getSaveTypeLabel(value: SaveType) {
    switch (value) {
        case SaveType.BOTH:
            return "Save to file and clipboard"
        case SaveType.CLIPBOARD:
            return "Save to clipboard"
        case SaveType.FILE:
            return "Save to file"
    }
}

function getSaveTypeIcon(value: SaveType) {
    switch (value) {
        case SaveType.BOTH:
            return ""
        case SaveType.CLIPBOARD:
            return "󱉨"
        case SaveType.FILE:
            return ""
    }
}

function setDirectories() {
    execAsync([
        "bash",
        "-c",
        `
    mkdir -p $(xdg-user-dir PICTURES)/Screenshots
    echo $(xdg-user-dir PICTURES)/Screenshots
    `
    ]).then((value) => {
        screenshotDir = value
    })

    execAsync([
        "bash",
        "-c",
        `
        mkdir -p $(xdg-user-dir VIDEOS)/ScreenRecordings
        echo $(xdg-user-dir VIDEOS)/ScreenRecordings
        `
    ]).then((value) => {
        screenRecordingDir = value
    })
}

function updateAudioOptions() {
    execAsync([
        "bash",
        "-c",
        `pactl list sources | grep -E "Name:|Description"`
    ]).catch((error) => {
        console.error(error)
    }).then((value) => {
        if (typeof value !== "string") {
            return
        }

        // Split the input into lines
        const lines = value.split('\n');

        // Initialize an empty array to hold the result
        const result: AudioSource[] = [];

        // Iterate through the lines in pairs (Name, Description)
        for (let i = 0; i < lines.length; i += 2) {
            // Ensure the line is not empty and follows the expected format
            const nameLine = lines[i].trim();
            const descriptionLine = lines[i + 1]?.trim();

            // Match the "Name" prefix
            if (nameLine.startsWith("Name: ") && descriptionLine?.startsWith("Description: ")) {
                // Extract the name and description values
                const name = nameLine.replace("Name: ", "");
                const description = descriptionLine.replace("Description: ", "");
                const isMonitor = nameLine.includes("monitor")

                // Add to the result array
                result.push({ name, description, isMonitor });
            }
        }

        audioOptions.set(result)
    })
}

function showScreenshotNotification(filePath: string, saveType: SaveType) {
    const appName = "Screenshot"
    switch (saveType) {
        case SaveType.FILE:
            showSavedNotification(filePath, appName)
            break
        case SaveType.CLIPBOARD:
            showCopiedNotification(appName)
            break
        case SaveType.BOTH:
            showSavedAndCopiedNotification(filePath, appName)
            break
    }

}

function showScreenRecordingNotification(filePath: string) {
    showSavedNotification(filePath, "Screen Recording")
}

function showSavedNotification(
    filePath: string,
    appName: string
) {
    execAsync([
        "bash",
        "-c",
        `
        ACTION_VIEW="viewScreenshot"
        ACTION_OPEN_DIR="openDir"
        # Send a notification with an action to view the file
        notify-send "File saved at ${filePath}" \
            --app-name="${appName}" \
            --action=$ACTION_VIEW="View" \
            --action=$ACTION_OPEN_DIR="Show in Files" |
        while read -r action; do
            if [[ "$action" == $ACTION_OPEN_DIR ]]; then
                xdg-open "$(dirname "${filePath}")"
            fi
            if [[ "$action" == $ACTION_VIEW ]]; then
                xdg-open ${filePath}
            fi
        done
    `
    ]).catch((error) => {
        console.error(error)
    }).then((value) => {
        console.log(value)
    })
}

function showSavedAndCopiedNotification(
    filePath: string,
    appName: string
) {
    execAsync([
        "bash",
        "-c",
        `
        ACTION_VIEW="viewScreenshot"
        ACTION_OPEN_DIR="openDir"
        # Send a notification with an action to view the file
        notify-send "Image copied to clipboard and file saved at ${filePath}" \
            --app-name="${appName}" \
            --action=$ACTION_VIEW="View" \
            --action=$ACTION_OPEN_DIR="Show in Files" |
        while read -r action; do
            if [[ "$action" == $ACTION_OPEN_DIR ]]; then
                xdg-open "$(dirname "${filePath}")"
            fi
            if [[ "$action" == $ACTION_VIEW ]]; then
                xdg-open ${filePath}
            fi
        done
    `
    ]).catch((error) => {
        console.error(error)
    }).then((value) => {
        console.log(value)
    })
}

function showCopiedNotification(
    appName: string
) {
    execAsync([
        "bash",
        "-c",
        `
        ACTION_VIEW="viewScreenshot"
        ACTION_OPEN_DIR="openDir"
        # Send a notification with an action to view the file
        notify-send "Image copied to clipboard" \
            --app-name="${appName}"
    `
    ]).catch((error) => {
        console.error(error)
    }).then((value) => {
        console.log(value)
    })
}

function generateFileName(): string {
    const time = GLib.DateTime.new_now_local().format("%Y_%m_%d_%H_%M_%S")!
    return `${time}_screenshot.png`
}

function ScreenshotButton(
    {
        icon,
        label,
        onClicked
    } : {
        icon: string,
        label: string,
        onClicked: () => void
    }
) {
    return <button
        widthRequest={115}
        cssClasses={["screenshotButton"]}
        marginStart={8}
        marginEnd={8}
        onClicked={onClicked}>
        <box
            vertical={true}>
            <label
                cssClasses={["screenShotLabel"]}
                label={icon}/>
            <label
                label={label}/>
        </box>
    </button>
}

function ScreenShots() {
    const delay = Variable(0)
    const saveType = Variable(SaveType.BOTH)
    let delayRevealed: Variable<boolean> | null = null
    let saveTypeRevealed: Variable<boolean> | null = null

    return <box
        vertical={true}>
        <label
            cssClasses={["labelLargeBold"]}
            marginBottom={8}
            label="Screenshot"/>
        <RevealerRow
            icon={"󰔛"}
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                delayRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={delay().as((value) => {
                        if (value === 1) {
                            return `Delay: ${value} second`
                        }
                        return `Delay: ${value} seconds`
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    {delayOptions.map((value) => {
                        return <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={`󰔛  ${value} seconds`}
                            onClicked={() => {
                                delay.set(value)
                                delayRevealed?.set(false)
                            }}/>
                    })}
                </box>
            }/>
        <RevealerRow
            icon={saveType().as((value) => {
                return getSaveTypeIcon(value)
            })}
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                saveTypeRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={saveType().as((value) => {
                        return getSaveTypeLabel(value)
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    {saveTypeValues.map((value) => {
                        let label = `${getSaveTypeIcon(value)}  ${getSaveTypeLabel(value)}`
                        return <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={label}
                            onClicked={() => {
                                saveType.set(value)
                                saveTypeRevealed?.set(false)
                            }}/>
                    })}
                </box>
            }/>
        <box
            marginTop={8}
            vertical={false}>
            <ScreenshotButton
                icon={""}
                label={"All"}
                onClicked={() => {
                    hideAllWindows()
                    const dir = screenshotDir
                    const fileName = generateFileName()
                    const path = `${dir}/${fileName}`
                    const allDelay = Math.max(1, delay.get())
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                                    ${projectDir}/shellScripts/hyprshot -m all -o ${dir} -f ${fileName} -D ${allDelay} --save-type ${saveType.get()}
                            `
                        ]
                    ).catch((error) => {
                        console.error(error)
                    }).finally(() => {
                        playCameraShutter()
                        showScreenshotNotification(path, saveType.get())
                    })
                }}/>
            <ScreenshotButton
                icon={"󰹑"}
                label={"Monitor"}
                onClicked={() => {
                    hideAllWindows()
                    const dir = screenshotDir
                    const fileName = generateFileName()
                    const path = `${dir}/${fileName}`
                    let canceled = false
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                                    ${projectDir}/shellScripts/hyprshot -m output -o ${dir} -f ${fileName} -D ${delay.get()} --save-type ${saveType.get().valueOf()}
                            `
                        ]
                    ).catch((error) => {
                        const message = typeof error === "string" ? error : error?.toString?.() ?? "";
                        if (message.includes("selection cancelled")) {
                            canceled = true;
                        }
                        console.error(error)
                    }).finally(() => {
                        if (!canceled) {
                            playCameraShutter()
                            showScreenshotNotification(path, saveType.get())
                        }
                    })
                }}/>
            <ScreenshotButton
                icon={""}
                label={"Window"}
                onClicked={() => {
                    hideAllWindows()
                    const dir = screenshotDir
                    const fileName = generateFileName()
                    const path = `${dir}/${fileName}`
                    let canceled = false
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                                    ${projectDir}/shellScripts/hyprshot -m window -o ${dir} -f ${fileName} -D ${delay.get()} --save-type ${saveType.get().valueOf()}
                            `
                        ]
                    ).catch((error) => {
                        const message = typeof error === "string" ? error : error?.toString?.() ?? "";
                        if (message.includes("selection cancelled")) {
                            canceled = true;
                        }
                        console.error(error)
                    }).finally(() => {
                        if (!canceled) {
                            playCameraShutter()
                            showScreenshotNotification(path, saveType.get())
                        }
                    })
                }}/>
            <ScreenshotButton
                icon={""}
                label={"Area"}
                onClicked={() => {
                    hideAllWindows()
                    const dir = screenshotDir
                    const fileName = generateFileName()
                    const path = `${dir}/${fileName}`
                    let canceled = false
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                                    ${projectDir}/shellScripts/hyprshot -m region -o ${dir} -f ${fileName} -D ${delay.get()} --save-type ${saveType.get().valueOf()}
                            `
                        ]
                    ).catch((error) => {
                        const message = typeof error === "string" ? error : error?.toString?.() ?? "";
                        if (message.includes("selection cancelled")) {
                            canceled = true;
                        }
                        console.error(error)
                    }).finally(() => {
                        if (!canceled) {
                            playCameraShutter()
                            showScreenshotNotification(path, saveType.get())
                        }
                    })
                }}/>
        </box>
    </box>
}

function ScreenRecording() {
    const selectedAudio = Variable<AudioSource | null>(null)
    const selectedCodec = Variable(codecs[0])
    const selectedEncodingPreset = Variable("medium")
    const selectedCrfQuality = Variable(20)

    let audioRevealed: Variable<boolean> | null = null
    let codecRevealed: Variable<boolean> | null = null
    let encodingRevealed: Variable<boolean> | null = null
    let crfRevealed: Variable<boolean> | null = null

    setTimeout(() => {
        bind(App.get_window(ScreenshotWindowName)!, "visible").subscribe((visible) => {
            if (!visible) {
                selectedAudio.set(null)
                selectedCodec.set(codecs[0])
                selectedEncodingPreset.set("medium")
                selectedCrfQuality.set(20)
            } else {
                updateAudioOptions()
            }
        })
    }, 1_000)


    return <box
        vertical={true}>
        <label
            cssClasses={["labelLargeBold"]}
            marginBottom={8}
            label="Screen Record"/>
        <RevealerRow
            icon={selectedAudio().as((value) => {
                if (value === null) {
                    return "󰝟"
                } else {
                    return value.isMonitor ? "󰕾" : ""
                }
            })}
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                audioRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={selectedAudio().as((value) => {
                        if (value === null) {
                            return "No Audio"
                        } else {
                            return value.description
                        }
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    <OkButton
                        hexpand={true}
                        labelHalign={Gtk.Align.START}
                        ellipsize={Pango.EllipsizeMode.END}
                        label={`󰝟  No Audio`}
                        onClicked={() => {
                            selectedAudio.set(null)
                            audioRevealed?.set(false)
                        }}/>
                    {audioOptions().as((options) => {
                        return options.map((option) => {
                            return <OkButton
                                hexpand={true}
                                labelHalign={Gtk.Align.START}
                                ellipsize={Pango.EllipsizeMode.END}
                                label={`${option.isMonitor ? "󰕾" : ""}  ${option.description}`}
                                onClicked={() => {
                                    selectedAudio.set(option)
                                    audioRevealed?.set(false)
                                }}/>
                        })
                    })}
                </box>
            }
        />
        <RevealerRow
            icon="󰕧"
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                codecRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={selectedCodec().as((value) => {
                        return `${value.display} codec`
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    {codecs.map((value) => {
                        return <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={`󰕧  ${value.display}`}
                            onClicked={() => {
                                selectedCodec.set(value)
                                codecRevealed?.set(false)
                            }}/>
                    })}
                </box>
            }
        />
        <RevealerRow
            icon={selectedEncodingPreset().as((value) => {
                return getEncodingPresetIcon(value)
            })}
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                encodingRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={selectedEncodingPreset().as((value) => {
                        return `${value.charAt(0).toUpperCase() + value.slice(1)} encoding speed`
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    {h264EncodingPresets.map((value) => {
                        return <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={`${getEncodingPresetIcon(value)}  ${value.charAt(0).toUpperCase() + value.slice(1)}`}
                            onClicked={() => {
                                selectedEncodingPreset.set(value)
                                encodingRevealed?.set(false)
                            }}/>
                    })}
                </box>
            }
        />
        <RevealerRow
            icon={selectedCrfQuality().as((value) => {
                return getCrfQualityIcon(value)
            })}
            iconOffset={0}
            windowName={ScreenshotWindowName}
            setup={(revealed) => {
                crfRevealed = revealed
            }}
            content={
                <label
                    cssClasses={["labelMediumBold"]}
                    halign={Gtk.Align.START}
                    hexpand={true}
                    ellipsize={Pango.EllipsizeMode.END}
                    label={selectedCrfQuality().as((value) => {
                        return `${value} CRF`
                    })}/>
            }
            revealedContent={
                <box
                    vertical={true}>
                    {crfQualityValues.map((value) => {
                        return <OkButton
                            hexpand={true}
                            labelHalign={Gtk.Align.START}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={`${getCrfQualityIcon(value)}  ${value}`}
                            onClicked={() => {
                                selectedCrfQuality.set(value)
                                crfRevealed?.set(false)
                            }}/>
                    })}
                </box>
            }
        />
        <box
            vertical={false}
            marginTop={8}>
            <ScreenshotButton
                icon={""}
                label={"All"}
                onClicked={() => {
                    isRecording.set(true)
                    const time = GLib.DateTime.new_now_local().format("%Y_%m_%d_%H_%M_%S")!
                    const path = `${screenRecordingDir}/${time}_record.mp4`
                    const audioParam = selectedAudio.get() !== null ? `--audio=${selectedAudio.get()!.name}` : ""
                    const command = `wf-recorder --file=${path} ${audioParam} -p preset=${selectedEncodingPreset.get()} -p crf=${selectedCrfQuality.get()} -c ${selectedCodec.get().lib}`
                    console.log(command)
                    hideAllWindows()
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                            sleep 0.7
                            ${command}
                            `
                        ]
                    ).catch((error) => {
                        console.error(error)
                    }).finally(() => {
                        isRecording.set(false)
                        showScreenRecordingNotification(path)
                    })
                }}/>
            <ScreenshotButton
                icon={"󰹑"}
                label={"Monitor"}
                onClicked={() => {
                    isRecording.set(true)
                    const time = GLib.DateTime.new_now_local().format("%Y_%m_%d_%H_%M_%S")!
                    const path = `${screenRecordingDir}/${time}_record.mp4`
                    const audioParam = selectedAudio.get() !== null ? `--audio=${selectedAudio.get()!.name}` : ""
                    const command = `wf-recorder --file=${path} -g "$(slurp -o)" ${audioParam} -p preset=${selectedEncodingPreset.get()} -p crf=${selectedCrfQuality.get()} -c ${selectedCodec.get().lib}`
                    console.log(command)
                    hideAllWindows()
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                            ${command}
                            `
                        ]
                    ).catch((error) => {
                        console.error(error)
                    }).finally(() => {
                        isRecording.set(false)
                        showScreenRecordingNotification(path)
                    })
                }}/>
            <ScreenshotButton
                icon={""}
                label={"Window"}
                onClicked={() => {
                    isRecording.set(true)
                    const time = GLib.DateTime.new_now_local().format("%Y_%m_%d_%H_%M_%S")!
                    const path = `${screenRecordingDir}/${time}_record.mp4`
                    const audioParam = selectedAudio.get() !== null ? `--audio=${selectedAudio.get()!.name}` : ""
                    const command = `wf-recorder --file=${path} -g "$(${projectDir}/shellScripts/grabWindow)" ${audioParam} -p preset=${selectedEncodingPreset.get()} -p crf=${selectedCrfQuality.get()} -c ${selectedCodec.get().lib}`
                    console.log(command)
                    hideAllWindows()
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                            ${command}
                            `
                        ]
                    ).catch((error) => {
                        console.error(error)
                    }).finally(() => {
                        isRecording.set(false)
                        showScreenRecordingNotification(path)
                    })
                }}/>
            <ScreenshotButton
                icon={""}
                label={"Area"}
                onClicked={() => {
                    isRecording.set(true)
                    const time = GLib.DateTime.new_now_local().format("%Y_%m_%d_%H_%M_%S")!
                    const path = `${screenRecordingDir}/${time}_record.mp4`
                    const audioParam = selectedAudio.get() !== null ? `--audio=${selectedAudio.get()!.name}` : ""
                    const command = `wf-recorder --file=${path} -g "$(slurp)" ${audioParam} -p preset=${selectedEncodingPreset.get()} -p crf=${selectedCrfQuality.get()} -c ${selectedCodec.get().lib}`
                    console.log(command)
                    hideAllWindows()
                    execAsync(
                        [
                            "bash",
                            "-c",
                            `
                            ${command}
                            `
                        ]
                    ).catch((error) => {
                        console.error(error)
                    }).finally(() => {
                        isRecording.set(false)
                        showScreenRecordingNotification(path)
                    })
                }}/>
        </box>
    </box>
}

export default function () {
    setDirectories()
    updateAudioOptions()

    return <ScrimScrollWindow
        namespace={"okpanel-screenshot"}
        monitor={variableConfig.mainMonitor()}
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        windowName={ScreenshotWindowName}
        topExpand={true}
        bottomExpand={true}
        leftExpand={false}
        rightExpand={false}
        contentWidth={560}
        content={
            <box
                vertical={true}
                marginTop={20}
                marginBottom={20}
                marginStart={20}
                marginEnd={20}>
                <ScreenShots/>
                <box marginTop={20}/>
                <Divider/>
                <box marginTop={10}/>
                <ScreenRecording/>
            </box>
        }/>
}