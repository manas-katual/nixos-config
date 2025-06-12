import {Field} from "../primitiveDefinitions";

export enum BarWidget {
    MENU = "menu",
    WORKSPACES = "workspaces",
    CLOCK = "clock",
    AUDIO_OUT = "audio_out",
    AUDIO_IN = "audio_in",
    BLUETOOTH = "bluetooth",
    NETWORK = "network",
    RECORDING_INDICATOR = "recording_indicator",
    VPN_INDICATOR = "vpn_indicator",
    BATTERY = "battery",
    TRAY = "tray",
    APP_LAUNCHER = "app_launcher",
    SCREENSHOT = "screenshot",
    CLIPBOARD_MANAGER = "clipboard_manager",
    POWER_PROFILE = "power_profile",
    CAVA_WAVEFORM = "cava_waveform",
    MPRIS_CONTROLS = "mpris_controls",
    MPRIS_TRACK_INFO = "mpris_track_info",
    MPRIS_PRIMARY_PLAYER_SWITCHER = "mpris_primary_player_switcher",
    NOTIFICATION_HISTORY = "notification_history",
    COLOR_PICKER = "color_picker",
    LOGOUT = "logout",
    LOCK = "lock",
    RESTART = "restart",
    SHUTDOWN = "shutdown",
}
export const BAR_WIDGET_VALUES = Object.values(BarWidget) as readonly BarWidget[]

export enum WaveformPosition {
    INNER = "inner",
    OUTER = "outer",
    START = "start",
    END = "end",
}
export const WAVEFORM_POSITIONS = Object.values(WaveformPosition) as readonly WaveformPosition[]

export enum Alignment {
    START = "start",
    CENTER = "center",
    END = "end"
}
export const ALIGNMENT_VALUES = Object.values(Alignment) as readonly Alignment[]

function commonFields(
    marginStart: number = 0,
    marginEnd: number = 0,
    marginTop: number = 0,
    marginBottom: number = 0,
) { return [
    {
        name: 'marginStart',
        type: 'number',
        default: marginStart,
        description: "Margin at the start of the widget.",
        withinConstraints: (value) => value >= 0,
        constraintDescription: 'Must be >= 0',
    },
    {
        name: 'marginEnd',
        type: 'number',
        default: marginEnd,
        description: "Margin at the end of the widget.",
        withinConstraints: (value) => value >= 0,
        constraintDescription: 'Must be >= 0',
    },
    {
        name: 'marginTop',
        type: 'number',
        default: marginTop,
        description: "Margin at the top of the widget.",
        withinConstraints: (value) => value >= 0,
        constraintDescription: 'Must be >= 0',
    },
    {
        name: 'marginBottom',
        type: 'number',
        default: marginBottom,
        description: "Margin at the bottom of the widget.",
        withinConstraints: (value) => value >= 0,
        constraintDescription: 'Must be >= 0',
    }
] as const satisfies Field[] }

export function barWidgetsSchema(vertical: boolean) { return [
    {
        name: BarWidget.MENU,
        type: "object",
        description: "Configuration for the menu bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.WORKSPACES,
        type: "object",
        description: "Configuration for the workspaces bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.CLOCK,
        type: "object",
        description: "Configuration for the clock bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.AUDIO_OUT,
        type: "object",
        description: "Configuration for the audio_out bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.AUDIO_IN,
        type: "object",
        description: "Configuration for the audio_in bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.BLUETOOTH,
        type: "object",
        description: "Configuration for the bluetooth bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.NETWORK,
        type: "object",
        description: "Configuration for the network bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.RECORDING_INDICATOR,
        type: "object",
        description: "Configuration for the recording_indicator bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.VPN_INDICATOR,
        type: "object",
        description: "Configuration for the vpn_indicator bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.BATTERY,
        type: "object",
        description: "Configuration for the battery bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.TRAY,
        type: "object",
        description: "Configuration for the tray bar widget.",
        children: [
            ...commonFields(),
            {
                name: 'collapsable',
                type: 'boolean',
                default: true,
                description: 'If true, a tray icon will show and need to be clicked to reveal the tray apps.'
            }
        ],
    },
    {
        name: BarWidget.APP_LAUNCHER,
        type: "object",
        description: "Configuration for the app_launcher bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.SCREENSHOT,
        type: "object",
        description: "Configuration for the screenshot bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.CLIPBOARD_MANAGER,
        type: "object",
        description: "Configuration for the clipboard_manager bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.POWER_PROFILE,
        type: "object",
        description: "Configuration for the power_profile bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.CAVA_WAVEFORM,
        type: "object",
        description: "Configuration for the cava_waveform bar widget.",
        children: [
            ...commonFields(),
            {
                name: 'length',
                type: 'number',
                default: 200,
                description: 'Length of the cava waveform.  This has no effect on the full bar waveform.',
                withinConstraints: value => value >= 100,
                constraintDescription: 'Must be >= 100'
            },
            {
                name: 'expanded',
                type: 'boolean',
                default: false,
                description: 'Expands the waveform to fill the empty space.  This can expand beyond the set length.  This has no effect on the full bar waveform.'
            },
            {
                name: 'position',
                type: 'enum',
                enumValues: WAVEFORM_POSITIONS,
                default: vertical ? WaveformPosition.OUTER : WaveformPosition.END,
                description: 'The base position of the waveform'
            },
            {
                name: 'intensityMultiplier',
                type: 'number',
                default: 1,
                description: 'Makes the waves bigger or smaller.',
                withinConstraints: value => value >= 0,
                constraintDescription: 'Must be >= 0'
            },
        ],
    },
    {
        name: BarWidget.MPRIS_CONTROLS,
        type: "object",
        description: "Configuration for the mpris_controls bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.MPRIS_TRACK_INFO,
        type: "object",
        description: "Configuration for the mpris_track_info bar widget.",
        children: [
            ...commonFields(
                vertical ? 0 : 10,
                vertical ? 0 : 10,
                vertical ? 10 : 0,
                vertical ? 10 : 0,
            ),
            {
                name: 'textLength',
                type: 'number',
                default: 30,
                description: 'The max number of characters to display.'
            },
            {
                name: 'textAlignment',
                type: 'enum',
                enumValues: ALIGNMENT_VALUES,
                default: vertical ? Alignment.END : Alignment.START,
                description: 'How to align the text.'
            },
            {
                name: 'minimumLength',
                type: 'number',
                default: 300,
                description: 'The minimum length of the widget.'
            }
        ],
    },
    {
        name: BarWidget.MPRIS_PRIMARY_PLAYER_SWITCHER,
        type: "object",
        description: "Configuration for the mpris_primary_player_switcher bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.NOTIFICATION_HISTORY,
        type: "object",
        description: "Configuration for the notification_history bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.COLOR_PICKER,
        type: "object",
        description: "Configuration for the color_picker bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.LOGOUT,
        type: "object",
        description: "Configuration for the logout bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.LOCK,
        type: "object",
        description: "Configuration for the lock bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.RESTART,
        type: "object",
        description: "Configuration for the restart bar widget.",
        children: [...commonFields()],
    },
    {
        name: BarWidget.SHUTDOWN,
        type: "object",
        description: "Configuration for the shutdown bar widget.",
        children: [...commonFields()],
    },
] as const satisfies Field[] }