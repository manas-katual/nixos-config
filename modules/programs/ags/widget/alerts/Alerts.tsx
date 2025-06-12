import {App, Astal, Gtk} from "astal/gtk4"
import Wp from "gi://AstalWp"
import {bind, Variable, Binding, GLib} from "astal"
import {getVolumeIcon, playPowerPlug, playPowerUnplug} from "../utils/audio";
import Brightness from "../utils/connectables/brightness";
import {getBrightnessIcon} from "../utils/brightness";
import Battery from "gi://AstalBattery"
import Hyprland from "gi://AstalHyprland"

const VolumeAlertName = "volumeAlert"
const BrightnessAlertName = "brightnessAlert"

export function AlertWindow(
    {
        iconLabel,
        label,
        sliderValue,
        windowName,
        showVariable,
        monitor
    }: {
        iconLabel: Binding<string>,
        label: string,
        sliderValue: Binding<number>,
        windowName: string,
        showVariable: Variable<any>
        monitor: Hyprland.Monitor
    }
): Astal.Window {
    let windowVisibilityTimeout: GLib.Source | null = null

    return <window
        namespace={"okpanel-alerts"}
        monitor={monitor.id}
        name={windowName}
        application={App}
        anchor={Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.NORMAL}
        layer={Astal.Layer.OVERLAY}
        cssClasses={["window"]}
        margin_bottom={100}
        visible={false}
        setup={(self) => {
            let canShow = false
            setTimeout(() => {
                canShow = true
            }, 3_000)
            showVariable.subscribe(() => {
                if (!canShow) {
                    return
                }
                if (windowVisibilityTimeout != null) {
                    windowVisibilityTimeout.destroy()
                }
                self.visible = true
                windowVisibilityTimeout = setTimeout(() => {
                    self.visible = false
                    windowVisibilityTimeout?.destroy()
                    windowVisibilityTimeout = null
                }, 1_000)
            })
        }}>
        <box
            vertical={true}>

        </box>
        <box
            vertical={false}
            marginBottom={18}
            marginTop={18}
            marginStart={5}
            marginEnd={5}
            halign={Gtk.Align.CENTER}>
            <label
                marginStart={20}
                marginEnd={15}
                cssClasses={["alertIcon"]}
                label={iconLabel}/>
            <box
                vertical={true}
                marginStart={10}
                valign={Gtk.Align.CENTER}>
                <label
                    cssClasses={["labelSmall"]}
                    label={label}
                    halign={Gtk.Align.START}/>
                <slider
                    marginTop={2}
                    marginEnd={20}
                    cssClasses={["alertProgress"]}
                    hexpand={true}
                    value={sliderValue}/>
            </box>
        </box>
    </window> as Astal.Window
}

export function VolumeAlert(monitor: Hyprland.Monitor): Astal.Window {
    const defaultSpeaker = Wp.get_default()!.audio.default_speaker

    const speakerVar = Variable.derive([
        bind(defaultSpeaker, "description"),
        bind(defaultSpeaker, "volume"),
        bind(defaultSpeaker, "mute")
    ])

    const showVariable = Variable.derive([
        bind(defaultSpeaker, "volume"),
        bind(defaultSpeaker, "mute")
    ])

    return <AlertWindow
        iconLabel={speakerVar(() => getVolumeIcon(defaultSpeaker))}
        label="Volume"
        sliderValue={bind(defaultSpeaker, "volume")}
        windowName={VolumeAlertName}
        showVariable={showVariable}
        monitor={monitor}/> as Astal.Window
}

export function BrightnessAlert(monitor: Hyprland.Monitor): Astal.Window {
    const brightness = Brightness.get_default()

    const showVariable = Variable.derive([
        bind(brightness, "screen")
    ])
    
    return <AlertWindow
        iconLabel={bind(brightness, "screen").as(() => {
            return getBrightnessIcon(brightness)
        })}
        label="Brightness"
        sliderValue={bind(brightness, "screen")}
        windowName={BrightnessAlertName}
        showVariable={showVariable}
        monitor={monitor}/> as  Astal.Window
}

export function ChargingAlertSound() {
    const linePowerDevice = Battery
        .UPower
        .new()
        .devices
        .find((device) => {
            return device.deviceType === Battery.Type.LINE_POWER &&
                (device.nativePath.includes("ACAD") ||
                device.nativePath.includes("ACPI") ||
                device.nativePath.includes("AC") ||
                device.nativePath.includes("ADP"))
        })

    if (linePowerDevice !== null && linePowerDevice !== undefined) {
        bind(linePowerDevice, "online").subscribe((online) => {
            if (online) {
                playPowerPlug()
            } else {
                playPowerUnplug()
            }
        })
    }
}