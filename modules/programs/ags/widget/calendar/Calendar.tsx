import {Gtk} from "astal/gtk4"
import {GLib, Variable} from "astal"
import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import {Bar, selectedBar} from "../../config/bar";
import {BarWidget} from "../../config/schema/definitions/barWidgets";

export const CalendarWindowName = "calendarWindow"

export default function () {
    const time = Variable<GLib.DateTime>(GLib.DateTime.new_now_local())
        .poll(1000, () => GLib.DateTime.new_now_local())

    const topExpand = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.centerWidgets,
        variableConfig.verticalBar.bottomWidgets,
    ], (bar, center, bottom) => {
        switch (bar) {
            case Bar.BOTTOM:
                return true
            case Bar.LEFT:
            case Bar.RIGHT:
                return center.includes(BarWidget.CLOCK)
                    || bottom.includes(BarWidget.CLOCK)
            default: return false
        }
    })

    const bottomExpand = Variable.derive([
        selectedBar,
        variableConfig.verticalBar.centerWidgets,
        variableConfig.verticalBar.topWidgets,
    ], (bar, center, top) => {
        switch (bar) {
            case Bar.TOP:
                return true
            case Bar.LEFT:
            case Bar.RIGHT:
                return center.includes(BarWidget.CLOCK)
                    || top.includes(BarWidget.CLOCK)
            default: return false
        }
    })

    const leftExpand = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.centerWidgets,
        variableConfig.horizontalBar.rightWidgets,
    ], (bar, center, right) => {
        switch (bar) {
            case Bar.RIGHT:
                return true
            case Bar.TOP:
            case Bar.BOTTOM:
                return center.includes(BarWidget.CLOCK)
                    || right.includes(BarWidget.CLOCK)
            default: return false
        }
    })

    const rightExpand = Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.centerWidgets,
        variableConfig.horizontalBar.leftWidgets,
    ], (bar, center, left) => {
        switch (bar) {
            case Bar.LEFT:
                return true
            case Bar.TOP:
            case Bar.BOTTOM:
                return center.includes(BarWidget.CLOCK)
                    || left.includes(BarWidget.CLOCK)
            default: return false
        }
    })

    return <ScrimScrollWindow
        namespace={"okpanel-calendar"}
        monitor={variableConfig.mainMonitor()}
        windowName={CalendarWindowName}
        topExpand={topExpand()}
        bottomExpand={bottomExpand()}
        leftExpand={leftExpand()}
        rightExpand={rightExpand()}
        contentWidth={340}
        width={variableConfig.horizontalBar.minimumWidth()}
        height={variableConfig.verticalBar.minimumHeight()}
        content={
            <box
                cssClasses={["calendarBox"]}
                vertical={true}>
                <label
                    cssClasses={["labelMedium"]}
                    label={time().as((t) => {
                        return t.format("%A")!
                    })}/>
                <label
                    cssClasses={["labelMedium"]}
                    label={time().as((t) => {
                        return t.format("%B %-d, %Y")!
                    })}/>
                <Gtk.Calendar
                    marginTop={12}
                    cssClasses={["calendar"]}/>
            </box>
        }/>
}