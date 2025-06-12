import {variableConfig} from "../../config/config";
import ScrimScrollWindow from "../common/ScrimScrollWindow";
import {Bar, selectedBar} from "../../config/bar";
import NotificationHistory from "../systemMenu/widgets/NotificationHistory";


import {BarWidget} from "../../config/schema/definitions/barWidgets";
import {Variable} from "astal";

export const NotificationHistoryWindowName = "notificationHistoryWindow"

export default function () {

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
                return center.includes(BarWidget.NOTIFICATION_HISTORY)
                    || bottom.includes(BarWidget.NOTIFICATION_HISTORY)
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
                return center.includes(BarWidget.NOTIFICATION_HISTORY)
                    || top.includes(BarWidget.NOTIFICATION_HISTORY)
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
                return center.includes(BarWidget.NOTIFICATION_HISTORY)
                    || right.includes(BarWidget.NOTIFICATION_HISTORY)
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
                return center.includes(BarWidget.NOTIFICATION_HISTORY)
                    || left.includes(BarWidget.NOTIFICATION_HISTORY)
            default: return false
        }
    })

    return <ScrimScrollWindow
        namespace={"okpanel-notification-history"}
        monitor={variableConfig.mainMonitor()}
        windowName={NotificationHistoryWindowName}
        topExpand={topExpand()}
        bottomExpand={bottomExpand()}
        leftExpand={leftExpand()}
        rightExpand={rightExpand()}
        contentWidth={400}
        width={variableConfig.horizontalBar.minimumWidth()}
        height={variableConfig.verticalBar.minimumHeight()}
        content={
            <box
                marginTop={20}
                marginStart={20}
                marginEnd={20}
                marginBottom={20}>
                <NotificationHistory/>
            </box>
        }/>
}