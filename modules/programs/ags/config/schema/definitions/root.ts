import {Field} from "../primitiveDefinitions";
import {soundsSchema} from "./sounds";
import {notificationsSchema} from "./notifications";
import {horizontalBarSchema, verticalBarSchema} from "./bars";
import {systemMenuSchema} from "./systemMenu";
import {systemCommandsSchema} from "./systemCommands";
import {themeSchema} from "./theme";

export const CONFIG_SCHEMA = [
    {
        name: 'icon',
        type: 'icon',
        default: '',
        description: 'Icon (glyph) representing this config file.',
    },
    {
        name: 'iconOffset',
        type: 'number',
        default: 0,
        description: 'Icon offset (‑10 … 10).',
        withinConstraints: (value) => value >= -10 && value <= 10,
        constraintDescription: 'Must be between -10 and 10'
    },
    {
        name: 'configUpdateScript',
        type: 'string',
        description: 'Absolute path to the script run when the config changes where you can update the theme and configuration for the rest of your system.  Theme name and config file name are sent as arguments to the script.',
        required: false,
    },
    {
        name: 'wallpaperUpdateScript',
        type: 'string',
        description: 'Absolute path to the script run when the wallpaper changes.  You are responsible for changing you wallpaper.  Wallpaper path is sent as an argument to the script.',
        required: false,
    },
    {
        name: 'barUpdateScript',
        type: 'string',
        description: 'Absolute path to the script run when the bar changes.  Bar type is sent as an argument to the script.',
        required: false,
    },
    {
        name: 'wallpaperDir',
        type: 'string',
        default: '',
        description: 'Directory containing theme wallpapers (may be empty).',
    },
    {
        name: 'mainMonitor',
        type: 'number',
        default: 0,
        description: 'Index of the primary monitor (0‑based as reported by Hyprland).',
    },
    soundsSchema,
    notificationsSchema,
    systemCommandsSchema,
    themeSchema,
    systemMenuSchema,
    horizontalBarSchema,
    verticalBarSchema,
] as const satisfies Field[]