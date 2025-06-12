import {Field} from "../primitiveDefinitions";

export enum SystemMenuWidget {
    NETWORK = "network",
    BLUETOOTH = "bluetooth",
    AUDIO_OUT = "audio_out",
    AUDIO_IN = "audio_in",
    POWER_PROFILE = "power_profile",
    LOOK_AND_FEEL = "look_and_feel",
    MPRIS_PLAYERS = "mpris_players",
    POWER_OPTIONS = "power_options",
    NOTIFICATION_HISTORY = "notification_history",
    TOOLBOX = "toolbox",
    CLOCK = "clock",
    CLIPBOARD_MANAGER = "clipboard_manager",
    SCREEN_RECORDING_CONTROLS = "screen_recording_controls",
    WEATHER = "weather",
}

export const SYSTEM_MENU_WIDGET_VALUES = Object.values(SystemMenuWidget) as readonly SystemMenuWidget[]

export enum TemperatureUnits {
    F = "fahrenheit",
    C = "celsius",
}

export const TEMP_UNITS = Object.values(TemperatureUnits) as readonly TemperatureUnits[]

export enum SpeedUnits {
    MPH = "mph",
    KPH = "kph",
}

export const SPEED_UNITS = Object.values(SpeedUnits) as readonly SpeedUnits[]

export function systemMenuWidgetsSchema() { return [
    {
        name: SystemMenuWidget.WEATHER,
        type: "object",
        description: "Configuration for the menu bar widget.",
        children: [
            {
                name: "latitude",
                type: "string",
                default: "0.0",
                description: "Latitude coordinate for weather location",
            },
            {
                name: "longitude",
                type: "string",
                default: "0.0",
                description: "Longitude coordinate for weather location",
            },
            {
                name: "temperatureUnit",
                type: "enum",
                enumValues: TEMP_UNITS,
                default: TemperatureUnits.F,
                description: "Temperature unit",
            },
            {
                name: "speedUnit",
                type: "enum",
                enumValues: SPEED_UNITS,
                default: SpeedUnits.MPH,
                description: "Speed unit",
            },
        ],
    },
] as const satisfies Field[] }
