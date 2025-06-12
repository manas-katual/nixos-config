import EndpointControls from "./widgets/EndpointControls";
import Wp from "gi://AstalWp"
import {bind, Variable} from "astal"
import {getMicrophoneIcon, getVolumeIcon} from "../utils/audio";
import PowerOptions from "./widgets/PowerOptions";
import MediaPlayers from "./widgets/MediaPlayers";
import NotificationHistory from "./widgets/NotificationHistory";
import NetworkControls from "./widgets/NetworkControls";
import BluetoothControls from "./widgets/BluetoothControls";
import LookAndFeelControls from "./widgets/LookAndFeelControls";
import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import {Bar, selectedBar} from "../../config/bar";
import PowerProfileControls from "./widgets/PowerProfileControls";
import {BarWidget} from "../../config/schema/definitions/barWidgets";
import Toolbox from "./widgets/Toolbox";
import Clock from "./widgets/Clock";
import ClipboardManager from "./widgets/ClipboardManager";
import {startCliphist} from "../clipboardManager/ClipboardManager";
import ScreenRecording from "./widgets/ScreenRecording";
import Weather from "./widgets/Weather";
import {SystemMenuWidget} from "../../config/schema/definitions/systemMenuWidgets";

export const SystemMenuWindowName = "systemMenuWindow"

const {audio} = Wp.get_default()!

export type SystemWidgetsJSX = {
    network: JSX.Element
    bluetooth: JSX.Element
    audioOut: JSX.Element
    audioIn: JSX.Element
    powerProfile: JSX.Element
    lookAndFeel: JSX.Element
    mpris: JSX.Element
    powerOptions: JSX.Element
    notificationHistory: JSX.Element
    toolbox: JSX.Element
    clock: JSX.Element
    clipboardManager: JSX.Element
    screenRecording: JSX.Element
    weather: JSX.Element
}

// Creating new widgets to replace the old ones when switching configs
// is very cpu intensive and laggy.  This helps to create the widgets
// and keep them in memory so they can be reused.
export function createSystemWidgets(): SystemWidgetsJSX {
    return {
        network: <NetworkControls/>,
        bluetooth: <BluetoothControls/>,
        audioOut: <EndpointControls
            defaultEndpoint={audio.default_speaker}
            endpointsBinding={bind(audio, "speakers")}
            getIcon={getVolumeIcon}/>,
        audioIn: <EndpointControls
            defaultEndpoint={audio.default_microphone}
            endpointsBinding={bind(audio, "microphones")}
            getIcon={getMicrophoneIcon}/>,
        powerProfile: <PowerProfileControls/>,
        lookAndFeel: <LookAndFeelControls/>,
        mpris: <MediaPlayers/>,
        powerOptions: <PowerOptions/>,
        notificationHistory: <NotificationHistory/>,
        toolbox: <Toolbox/>,
        clock: <Clock/>,
        clipboardManager: <ClipboardManager/>,
        screenRecording: <ScreenRecording/>,
        weather: <Weather/>,
    }
}

export function addSystemMenuWidgets(
    widgets: SystemMenuWidget[],
    jsxWidgets: SystemWidgetsJSX,
) {
    return widgets.map((widget) => {
        switch (widget) {
            case SystemMenuWidget.NETWORK:
                return jsxWidgets.network
            case SystemMenuWidget.BLUETOOTH:
                return jsxWidgets.bluetooth
            case SystemMenuWidget.AUDIO_OUT:
                return jsxWidgets.audioOut
            case SystemMenuWidget.AUDIO_IN:
                return jsxWidgets.audioIn
            case SystemMenuWidget.POWER_PROFILE:
                return jsxWidgets.powerProfile
            case SystemMenuWidget.LOOK_AND_FEEL:
                return jsxWidgets.lookAndFeel
            case SystemMenuWidget.MPRIS_PLAYERS:
                return jsxWidgets.mpris
            case SystemMenuWidget.POWER_OPTIONS:
                return jsxWidgets.powerOptions
            case SystemMenuWidget.NOTIFICATION_HISTORY:
                return jsxWidgets.notificationHistory
            case SystemMenuWidget.TOOLBOX:
                return jsxWidgets.toolbox
            case SystemMenuWidget.CLOCK:
                return jsxWidgets.clock
            case SystemMenuWidget.CLIPBOARD_MANAGER:
                startCliphist()
                return jsxWidgets.clipboardManager
            case SystemMenuWidget.SCREEN_RECORDING_CONTROLS:
                return jsxWidgets.screenRecording
            case SystemMenuWidget.WEATHER:
                return jsxWidgets.weather
        }
    })
}

export default function () {

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
                return center.includes(BarWidget.MENU)
                    || bottom.includes(BarWidget.MENU)
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
                return center.includes(BarWidget.MENU)
                    || top.includes(BarWidget.MENU)
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
                return center.includes(BarWidget.MENU)
                    || right.includes(BarWidget.MENU)
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
                return center.includes(BarWidget.MENU)
                    || left.includes(BarWidget.MENU)
            default: return false
        }
    })

    const jsxWidgets = createSystemWidgets()

    return <ScrimScrollWindow
        namespace={"okpanel-system-menu"}
        monitor={variableConfig.mainMonitor()}
        windowName={SystemMenuWindowName}
        topExpand={topExpand()}
        bottomExpand={bottomExpand()}
        leftExpand={leftExpand()}
        rightExpand={rightExpand()}
        contentWidth={400}
        width={variableConfig.horizontalBar.minimumWidth()}
        height={variableConfig.verticalBar.minimumHeight()}
        content={
            <box
                marginTop={20}
                marginStart={20}
                marginEnd={20}
                marginBottom={20}
                vertical={true}
                spacing={10}>
                {variableConfig.systemMenu.widgets().as((widgets) => {
                    return addSystemMenuWidgets(widgets, jsxWidgets)
                })}
            </box>
        }
    />
}