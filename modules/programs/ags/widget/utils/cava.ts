import {variableConfig} from "../../config/config";
import {Bar, selectedBar} from "../../config/bar";
import {Binding, Variable} from "astal";

import {WaveformPosition} from "../../config/schema/definitions/barWidgets";

export function getCavaFlipStartValue(vertical: boolean): Binding<boolean> {
    return Variable.derive([
        selectedBar,
        variableConfig.verticalBar.cava_waveform.position,
        variableConfig.horizontalBar.cava_waveform.position,
    ], (bar, vPosition, hPosition) => {
        if (vertical) {
            switch (vPosition) {
                case WaveformPosition.START:
                    return true
                case WaveformPosition.END:
                    return false
                case WaveformPosition.OUTER:
                    return bar === Bar.LEFT
                case WaveformPosition.INNER:
                    return bar !== Bar.LEFT
            }
        } else {
            switch (hPosition) {
                case WaveformPosition.START:
                    return true
                case WaveformPosition.END:
                    return false
                case WaveformPosition.OUTER:
                    return bar === Bar.TOP
                case WaveformPosition.INNER:
                    return bar !== Bar.TOP
            }
        }
    })()
}