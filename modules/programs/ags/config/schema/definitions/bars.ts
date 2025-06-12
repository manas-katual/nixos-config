import {Field} from "../primitiveDefinitions";
import {BAR_WIDGET_VALUES, BarWidget, barWidgetsSchema} from "./barWidgets";

export const barWidgetsArrayField = <N extends string>( //preserve the literal key
    name: N,
    description: string,
    defaults: readonly BarWidget[],
) =>
    ({
        name,
        type: "array",
        description,
        default: defaults,
        item: {
            name: "widget",
            type: "enum",
            enumValues: BAR_WIDGET_VALUES,
        },
    } as const satisfies Field & { name: N })

const commonBarChildrenSchema = [
    {
        name: 'compact',
        type: 'boolean',
        default: false,
        description: 'Enabled compact bar mode.',
    },
    {
        name: 'expanded',
        type: 'boolean',
        default: true,
        description: 'If true, the bar stretches to the full monitor width.',
    },
    {
        name: 'splitSections',
        type: 'boolean',
        default: false,
        description: 'If true, left/center/right widgets are rendered separately with padding.',
    },
    {
        name: 'sectionPadding',
        type: 'number',
        default: 0,
        description: 'Padding (px) around each section when splitSections = true.',
    },
    {
        name: 'widgetSpacing',
        type: 'number',
        default: 0,
        description: 'Spacing (px) between widgets inside the bar.',
    },
    {
        name: 'marginInner',
        type: 'number',
        default: 5,
        description: 'Margin (px) between the bar and other windows.'
    },
    {
        name: 'marginOuter',
        type: 'number',
        default: 5,
        description: 'Margin (px) between the bar and the edge of the screen.'
    },
    {
        name: 'marginStart',
        type: 'number',
        default: 5,
        description: 'Margin (px) at the start of the bar.  (For the vertical bar, this is the top)'
    },
    {
        name: 'marginEnd',
        type: 'number',
        default: 5,
        description: 'Margin (px) at the end of the bar.  (For the vertical bar, this is the bottom)'
    },
    {
        name: 'fullBarCavaWaveform',
        type: 'object',
        description: 'Full bar cava waveform configurations.',
        children: [
            {
                name: 'enabled',
                type: 'boolean',
                default: false,
                description: 'Shows a cava waveform stretching across the entire bar, underneath other widgets.  Does not show when split sections are enabled.'
            },
            {
                name: 'intensityMultiplier',
                type: 'number',
                default: 1,
                description: 'Makes the waves bigger or smaller.'
            },
        ]
    },
] as const satisfies Field[]

export const horizontalBarSchema = {
    name: 'horizontalBar',
    type: 'object',
    description: 'Configuration for a horizontal (top/bottom) bar layout.',
    children: [
        barWidgetsArrayField(
            'leftWidgets',
            'Widgets anchored left.',
            [
                BarWidget.MENU,
                BarWidget.WORKSPACES
            ]
        ),
        barWidgetsArrayField(
            'centerWidgets',
            'Widgets centered horizontally.',
            [
                BarWidget.CAVA_WAVEFORM,
                BarWidget.MPRIS_PRIMARY_PLAYER_SWITCHER,
                BarWidget.MPRIS_CONTROLS,
                BarWidget.MPRIS_TRACK_INFO,
            ]
        ),
        barWidgetsArrayField(
            'rightWidgets',
            'Widgets anchored right.',
            [
                BarWidget.RECORDING_INDICATOR,
                BarWidget.TRAY,
                BarWidget.CLIPBOARD_MANAGER,
                BarWidget.AUDIO_OUT,
                BarWidget.AUDIO_IN,
                BarWidget.BLUETOOTH,
                BarWidget.VPN_INDICATOR,
                BarWidget.NETWORK,
                BarWidget.BATTERY,
                BarWidget.CLOCK
            ],
        ),
        {
            name: 'minimumWidth',
            type: 'number',
            default: 800,
            description: 'Minimum bar width if not expanded.',
            transformation: (value) => value < 1 ? 1 : value
        },
        ...commonBarChildrenSchema,
        ...barWidgetsSchema(false),
    ],
} as const satisfies Field

export const verticalBarSchema = {
    name: 'verticalBar',
    type: 'object',
    description: 'Configuration for a vertical (left/right) bar layout.',
    children: [
        barWidgetsArrayField(
            'topWidgets',
            'Widgets anchored at the top.',
            [
                BarWidget.MENU,
                BarWidget.WORKSPACES
            ]
        ),
        barWidgetsArrayField(
            'centerWidgets',
            'Widgets centered vertically.',
            [
                BarWidget.MPRIS_TRACK_INFO,
                BarWidget.MPRIS_CONTROLS,
                BarWidget.MPRIS_PRIMARY_PLAYER_SWITCHER,
                BarWidget.CAVA_WAVEFORM,
            ]
        ),
        barWidgetsArrayField(
            'bottomWidgets',
            'Widgets anchored at the bottom.',
            [
                BarWidget.RECORDING_INDICATOR,
                BarWidget.TRAY,
                BarWidget.CLIPBOARD_MANAGER,
                BarWidget.AUDIO_OUT,
                BarWidget.AUDIO_IN,
                BarWidget.BLUETOOTH,
                BarWidget.VPN_INDICATOR,
                BarWidget.NETWORK,
                BarWidget.BATTERY,
                BarWidget.CLOCK,
            ],
        ),
        {
            name: 'integratedMenu',
            type: 'boolean',
            default: false,
            description: 'If true, the menu will be integrated into the bar.'
        },
        {
            name: 'minimumHeight',
            type: 'number',
            default: 600,
            description: 'Minimum bar height if not expanded.',
            transformation: (value) => value < 1 ? 1 : value
        },
        ...commonBarChildrenSchema,
        ...barWidgetsSchema(true),
    ],
} as const satisfies Field
