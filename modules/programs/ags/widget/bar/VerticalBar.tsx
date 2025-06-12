import {App, Astal, Gtk} from "astal/gtk4"
import {addWidgets} from "./BarWidgets";
import {variableConfig} from "../../config/config";
import {Bar, selectedBar} from "../../config/bar";
import CavaWaveform from "../cava/CavaWaveform";
import {getCavaFlipStartValue} from "../utils/cava";
import {Variable} from "astal";
import {addSystemMenuWidgets, createSystemWidgets} from "../systemMenu/SystemMenuWindow";

export const verticalBarWindowName = "verticalBar"

export const integratedMenuRevealed = Variable(false)

export default function () {
    const marginLeft = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.marginOuter,
        variableConfig.verticalBar.marginInner
    ], (bar, outer, inner): number => {
        if (bar === Bar.LEFT) {
            return outer
        } else {
            return inner
        }
    })

    const marginRight = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.marginOuter,
        variableConfig.verticalBar.marginInner
    ], (bar, outer, inner): number => {
        if (bar === Bar.RIGHT) {
            return outer
        } else {
            return inner
        }
    })

    const anchor = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.expanded
    ], (bar, expanded) => {
        if (bar === Bar.LEFT) {
            if (!expanded) {
                return Astal.WindowAnchor.LEFT
            }
            return Astal.WindowAnchor.TOP
                | Astal.WindowAnchor.LEFT
                | Astal.WindowAnchor.BOTTOM
        } else {
            if (!expanded) {
                return Astal.WindowAnchor.RIGHT
            }
            return Astal.WindowAnchor.TOP
                | Astal.WindowAnchor.RIGHT
                | Astal.WindowAnchor.BOTTOM
        }
    })

    const systemJsxWidgets = createSystemWidgets()

    const integratedMenu = <revealer
        transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
        visible={variableConfig.verticalBar.integratedMenu()}
        revealChild={integratedMenuRevealed()}>
        <Gtk.ScrolledWindow
            cssClasses={["scrollWindow"]}
            vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
            propagateNaturalHeight={true}
            widthRequest={400}>
            <box
                marginTop={20}
                marginStart={20}
                marginEnd={20}
                marginBottom={20}
                vertical={true}
                spacing={10}>
                {variableConfig.systemMenu.widgets().as((widgets) => {
                    return addSystemMenuWidgets(widgets, systemJsxWidgets)
                })}
            </box>
        </Gtk.ScrolledWindow>
    </revealer>

    const fullBarCavaEnabled = Variable.derive([
        variableConfig.verticalBar.fullBarCavaWaveform.enabled,
        variableConfig.verticalBar.splitSections
    ], (enabled, split) => {
        return enabled && !split
    })

    return <window
        defaultHeight={variableConfig.verticalBar.minimumHeight()}
        defaultWidth={1} // necessary or resizing doesn't work
        name={verticalBarWindowName}
        layer={Astal.Layer.BOTTOM}
        namespace={"okpanel-vertical-bar"}
        heightRequest={variableConfig.verticalBar.minimumHeight()}
        cssClasses={["transparentBackground"]}
        monitor={variableConfig.mainMonitor()}
        visible={selectedBar((bar) => {
            return bar === Bar.LEFT || bar === Bar.RIGHT
        })}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        // this window doesn't like marginStart for some reason
        marginLeft={marginLeft()}
        marginRight={marginRight()}
        marginTop={variableConfig.verticalBar.marginStart()}
        marginBottom={variableConfig.verticalBar.marginEnd()}
        anchor={anchor()}
        application={App}>
        <box
            vertical={false}
            cssClasses={variableConfig.verticalBar.splitSections().as((split) =>
                split ? ["sideBar"] : ["barWindow", "sideBar"]
            )}>
            {selectedBar().as((bar) => {
                if (bar === Bar.LEFT) {
                    return integratedMenu
                } else {
                    return <box/>
                }
            })}
            <overlay>
                <centerbox
                    type={"overlay measure"}
                    orientation={Gtk.Orientation.VERTICAL}>
                    <box
                        visible={variableConfig.verticalBar.topWidgets().as((widgets) =>
                            widgets.length > 0
                        )}
                        vertical={true}
                        cssClasses={variableConfig.verticalBar.splitSections().as((split) =>
                            split ? ["barWindow"] : []
                        )}>
                        <box
                            vertical={true}
                            marginTop={variableConfig.verticalBar.sectionPadding()}
                            marginBottom={variableConfig.verticalBar.sectionPadding()}
                            spacing={variableConfig.verticalBar.widgetSpacing()}>
                            {variableConfig.verticalBar.topWidgets().as((widgets) =>
                                addWidgets(widgets, true)
                            )}
                        </box>
                    </box>
                    <box
                        visible={variableConfig.verticalBar.centerWidgets().as((widgets) =>
                            widgets.length > 0
                        )}
                        vertical={true}
                        cssClasses={variableConfig.verticalBar.splitSections().as((split) =>
                            split ? ["barWindow"] : []
                        )}>
                        <box
                            vertical={true}
                            marginTop={variableConfig.verticalBar.sectionPadding()}
                            marginBottom={variableConfig.verticalBar.sectionPadding()}
                            spacing={variableConfig.verticalBar.widgetSpacing()}>
                            {variableConfig.verticalBar.centerWidgets().as((widgets) =>
                                addWidgets(widgets, true)
                            )}
                        </box>
                    </box>
                    <box
                        visible={variableConfig.verticalBar.bottomWidgets().as((widgets) =>
                            widgets.length > 0
                        )}
                        vertical={true}
                        valign={Gtk.Align.END}
                        cssClasses={variableConfig.verticalBar.splitSections().as((split) =>
                            split ? ["barWindow"] : []
                        )}>
                        <box
                            vertical={true}
                            marginTop={variableConfig.verticalBar.sectionPadding()}
                            marginBottom={variableConfig.verticalBar.sectionPadding()}
                            spacing={variableConfig.verticalBar.widgetSpacing()}>
                            {variableConfig.verticalBar.bottomWidgets().as((widgets) =>
                                addWidgets(widgets, true)
                            )}
                        </box>
                    </box>
                </centerbox>
                <box>
                    {fullBarCavaEnabled().as((enabled) => {
                        if (enabled) {
                            return <CavaWaveform
                                vertical={true}
                                intensity={variableConfig.verticalBar.fullBarCavaWaveform.intensityMultiplier()}
                                flipStart={getCavaFlipStartValue(true)}
                                expand={true}
                                length={10}
                                size={40}/>
                        } else {
                            return <box/>
                        }
                    })}
                </box>
            </overlay>
            {selectedBar().as((bar) => {
                if (bar === Bar.RIGHT) {
                    return integratedMenu
                } else {
                    return <box/>
                }
            })}
        </box>
    </window>
}
