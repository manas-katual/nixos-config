import {Field} from "../primitiveDefinitions";

export const soundsSchema = {
    name: 'sounds',
    type: 'object',
    description: 'Global sound configs.',
    children: [
        {
            name: 'playVolumeChangingSound',
            type: 'boolean',
            description: 'Whether or not to play a sound when changing volume',
            default: 'true'
        },
        {
            name: 'volumeChangingSoundPath',
            type: 'string',
            description: 'Full path to a sound file that will be used for volume changes',
            default: ''
        },
        {
            name: 'playScreenshotSound',
            type: 'boolean',
            description: 'Whether or not to play a sound when taking a screenshot',
            default: 'true'
        },
        {
            name: 'screenshotSoundPath',
            type: 'string',
            description: 'Full path to a sound file that will be used for screenshots',
            default: ''
        },
        {
            name: 'playLowBatteryWarningSound',
            type: 'boolean',
            description: 'Whether or not to play a sound when the battery is low',
            default: 'true'
        },
        {
            name: 'lowBatteryWarningSoundPath',
            type: 'string',
            description: 'Full path to a sound file that will be used for low battery warnings',
            default: ''
        },
        {
            name: 'playChargingSound',
            type: 'boolean',
            description: 'Whether or not to play a sound when charging the battery',
            default: 'true'
        },
        {
            name: 'chargingPlugInSoundPath',
            type: 'string',
            description: 'Full path to a sound file that will be used for starting battery charging',
            default: ''
        },
        {
            name: 'chargingUnplugSoundPath',
            type: 'string',
            description: 'Full path to a sound file that will be used for stopping battery charging',
            default: ''
        },
    ]
} as const satisfies Field