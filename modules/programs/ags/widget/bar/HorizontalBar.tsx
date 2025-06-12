import {App, Astal, Gtk} from "astal/gtk4"
import {addWidgets} from "./BarWidgets";
import {variableConfig} from "../../config/config";
import {Bar, selectedBar} from "../../config/bar";
import CavaWaveform from "../cava/CavaWaveform";
import {getCavaFlipStartValue} from "../utils/cava";
import {Variable} from "astal";

export const horizontalBarWindowName = "horizontalBar"

export default function () {
    const marginTop = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.marginOuter,
        variableConfig.horizontalBar.marginInner
    ], (bar, outer, inner): number => {
        if (bar === Bar.TOP) {
            return outer
        } else {
            return inner
        }
    })

    const marginBottom = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.marginOuter,
        variableConfig.horizontalBar.marginInner
    ], (bar, outer, inner): number => {
        if (bar === Bar.BOTTOM) {
            return outer
        } else {
            return inner
        }
    })

    const anchor = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.expanded
    ], (bar, expanded) => {
        if (bar === Bar.TOP) {
            if (!expanded) {
                return Astal.WindowAnchor.TOP
            }
            return Astal.WindowAnchor.TOP
                | Astal.WindowAnchor.LEFT
                | Astal.WindowAnchor.RIGHT
        } else {
            if (!expanded) {
                return Astal.WindowAnchor.BOTTOM
            }
            return Astal.WindowAnchor.BOTTOM
                | Astal.WindowAnchor.LEFT
                | Astal.WindowAnchor.RIGHT
        }
    })

    const fullBarCavaEnabled = Variable.derive([
        variableConfig.horizontalBar.fullBarCavaWaveform.enabled,
        variableConfig.horizontalBar.splitSections
    ], (enabled, split) => {
        return enabled && !split
    })

    return <window
        defaultHeight={1} // necessary or resizing doesn't work
        name={horizontalBarWindowName}
        layer={Astal.Layer.TOP}
        namespace={"okpanel-horizontal-bar"}
        widthRequest={variableConfig.horizontalBar.minimumWidth()}
        visible={selectedBar((bar) => {
            return bar === Bar.TOP || bar === Bar.BOTTOM
        })}
        cssClasses={["transparentBackground"]}
        monitor={variableConfig.mainMonitor()}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        // this window doesn't like marginStart for some reason
        marginLeft={variableConfig.horizontalBar.marginStart()}
        marginRight={variableConfig.horizontalBar.marginEnd()}
        marginTop={marginTop()}
        marginBottom={marginBottom()}
        anchor={anchor()}
        application={App}>
        <overlay
            cssClasses={variableConfig.horizontalBar.splitSections().as((split) =>
                split ? ["topBar"] : ["barWindow", "topBar"]
            )}>
            <centerbox
                type={"overlay measure"}
                orientation={Gtk.Orientation.HORIZONTAL}>
                <box
                    visible={variableConfig.horizontalBar.leftWidgets().as((widgets) =>
                        widgets.length > 0
                    )}
                    halign={Gtk.Align.START}
                    cssClasses={variableConfig.horizontalBar.splitSections().as((split) =>
                        split ? ["barWindow"] : []
                    )}>
                    <box
                        vertical={false}
                        marginStart={variableConfig.horizontalBar.sectionPadding()}
                        marginEnd={variableConfig.horizontalBar.sectionPadding()}
                        spacing={variableConfig.horizontalBar.widgetSpacing()}>
                        {variableConfig.horizontalBar.leftWidgets().as((widgets) =>
                            addWidgets(widgets, false)
                        )}
                    </box>
                </box>
                <box
                    visible={variableConfig.horizontalBar.centerWidgets().as((widgets) =>
                        widgets.length > 0
                    )}
                    cssClasses={variableConfig.horizontalBar.splitSections().as((split) =>
                        split ? ["barWindow"] : []
                    )}>
                    <box
                        vertical={false}
                        marginStart={variableConfig.horizontalBar.sectionPadding()}
                        marginEnd={variableConfig.horizontalBar.sectionPadding()}
                        spacing={variableConfig.horizontalBar.widgetSpacing()}>
                        {variableConfig.horizontalBar.centerWidgets().as((widgets) =>
                            addWidgets(widgets, false)
                        )}
                    </box>
                </box>
                <box
                    visible={variableConfig.horizontalBar.rightWidgets().as((widgets) =>
                        widgets.length > 0
                    )}
                    halign={Gtk.Align.END}
                    cssClasses={variableConfig.horizontalBar.splitSections().as((split) =>
                        split ? ["barWindow"] : []
                    )}>
                    <box
                        vertical={false}
                        marginStart={variableConfig.horizontalBar.sectionPadding()}
                        marginEnd={variableConfig.horizontalBar.sectionPadding()}
                        spacing={variableConfig.horizontalBar.widgetSpacing()}>
                        {variableConfig.horizontalBar.rightWidgets().as((widgets) =>
                            addWidgets(widgets, false)
                        )}
                    </box>
                </box>
            </centerbox>
            <box>
                {fullBarCavaEnabled().as((enabled) => {
                    if (enabled) {
                        return <CavaWaveform
                            vertical={false}
                            intensity={variableConfig.horizontalBar.fullBarCavaWaveform.intensityMultiplier()}
                            flipStart={getCavaFlipStartValue(false)}
                            expand={true}
                            length={10}
                            size={40}/>
                    } else {
                        return <box/>
                    }
                })}
            </box>
        </overlay>
    </window>
}
