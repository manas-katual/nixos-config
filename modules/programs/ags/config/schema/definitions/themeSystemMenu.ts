import {Field} from "../primitiveDefinitions";

import {SystemMenuWidget} from "./systemMenuWidgets";

export const themeSystemMenuSchema = {
    name: 'systemMenu',
    type: 'object',
    description: 'System menu theme configurations.',
    children: [
        {
            name: SystemMenuWidget.CLOCK,
            type: 'object',
            description: 'Theme configurations for the system menu clock.',
            children: [
                {
                    name: "dayAllCaps",
                    type: 'boolean',
                    default: false,
                    description: "If the week day name text should be in all caps",
                },
                {
                    name: "dayFont",
                    type: "string",
                    default: {from: "theme.font"},
                    description: "Font used for the week day name",
                    reactive: false,
                }
            ]
        }
    ],
} as const satisfies Field