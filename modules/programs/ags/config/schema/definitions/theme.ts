import {Field} from "../primitiveDefinitions";
import {themeWindowsSchema} from "./themeWindows";
import {themeBarsSchema} from "./themeBars";
import {themeSystemMenuSchema} from "./themeSystemMenu";

export const themeSchema = {
    name: 'theme',
    type: 'object',
    description: 'Global theme definitions.',
    children: [
        {
            name: 'name',
            type: 'string',
            default: 'myTheme',
            description: 'Theme name.  Passed as the first argument to the configUpdateScript when changing configs.',
            reactive: false,
        },
        {
            name: 'buttonBorderRadius',
            type: 'number',
            default: 8,
            description: 'Border radius (px) used by regular buttons.',
            reactive: false,
        },
        {
            name: 'largeButtonBorderRadius',
            type: 'number',
            default: 16,
            description: 'Border radius (px) used by large buttons.',
            reactive: false,
        },
        {
            name: 'font',
            type: 'string',
            default: 'JetBrainsMono NF',
            description: 'Default font family used across the panel widgets.',
        },
        {
            name: 'nightLightTemperature',
            type: 'number',
            default: 5000,
            description: 'The temperature of the night light.',
            reactive: false,
        },
        {
            name: 'colors',
            type: 'object',
            description: 'Palette used by widgets & windows.',
            children: [
                {
                    name: 'background',
                    type: 'color',
                    default: '#1F2932',
                    description: 'Background color',
                    reactive: false,
                },
                {
                    name: 'foreground',
                    type: 'color',
                    default: '#AFB3BD',
                    description: 'Foreground color',
                    reactive: false,
                },
                {
                    name: 'primary',
                    type: 'color',
                    default: '#7C545F',
                    description: 'Primary / accent color',
                    reactive: false,
                },
                {
                    name: 'buttonPrimary',
                    type: 'color',
                    default: '#7C545F',
                    description: 'Button color',
                    reactive: false,
                },
                {
                    name: 'warning',
                    type: 'color',
                    default: '#7C7C54',
                    description: 'Warning color',
                    reactive: false,
                },
                {
                    name: 'alertBorder',
                    type: 'color',
                    default: '#7C545F',
                    description: 'Color of alert borders (OSD)',
                    reactive: false,
                },
                {
                    name: 'scrimColor',
                    type: 'color',
                    default: '#00000001',
                    description: 'Color used for translucent overlays (RGBA hex).',
                    transformation: (value) => {
                        if (value === "#00000000" || value === "#000000") {
                            return "#00000001"
                        } else {
                            return value
                        }
                    },
                    reactive: false,
                },
            ],
        },
        themeBarsSchema,
        themeWindowsSchema,
        themeSystemMenuSchema,
    ],
} as const satisfies Field