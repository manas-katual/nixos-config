import {Field} from "../primitiveDefinitions";

export const systemCommandsSchema = {
    name: 'systemCommands',
    type: 'object',
    description: 'Shell commands executed by power options.',
    children: [
        {
            name: 'logout',
            type: 'string',
            default: 'uwsm stop',
            description: 'Command to log the current user out.',
        },
        {
            name: 'logoutConfirmationEnabled',
            type: 'boolean',
            default: true,
            description: 'Enable a confirmation dialog when logging out.'
        },
        {
            name: 'lock',
            type: 'string',
            default: 'uwsm app -- hyprlock',
            description: 'Command to lock the screen.',
        },
        {
            name: 'lockConfirmationEnabled',
            type: 'boolean',
            default: false,
            description: 'Enable a confirmation dialog when locking the screen.'
        },
        {
            name: 'restart',
            type: 'string',
            default: 'systemctl reboot',
            description: 'Command to reboot the machine.',
        },
        {
            name: 'restartConfirmationEnabled',
            type: 'boolean',
            default: true,
            description: 'Enable a confirmation dialog when restarting the computer.'
        },
        {
            name: 'shutdown',
            type: 'string',
            default: 'systemctl poweroff',
            description: 'Command to shut down the machine safely.',
        },
        {
            name: 'shutdownConfirmationEnabled',
            type: 'boolean',
            default: true,
            description: 'Enable a confirmation dialog when shutting the computer down.'
        },
    ],
} as const satisfies Field