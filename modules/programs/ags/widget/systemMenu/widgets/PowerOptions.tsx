import {Gtk} from "astal/gtk4"
import {hideAllWindows} from "../../utils/windows";
import OkButton, {OkButtonSize} from "../../common/OkButton";
import {lock, logout, restart, shutdown} from "../../utils/powerOptions";

export default function () {
    return <box
        vertical={false}
        halign={Gtk.Align.CENTER}
        spacing={12}>
        <OkButton
            size={OkButtonSize.XL}
            label="󰍃"
            offset={0}
            onClicked={() => {
                hideAllWindows()
                logout()
            }}/>
        <OkButton
            size={OkButtonSize.XL}
            label=""
            offset={2}
            onClicked={() => {
                hideAllWindows()
                lock()
            }}/>
        <OkButton
            size={OkButtonSize.XL}
            label=""
            offset={0}
            onClicked={() => {
                hideAllWindows()
                restart()
            }}/>
        <OkButton
            size={OkButtonSize.XL}
            label="⏻"
            offset={2}
            onClicked={() => {
                hideAllWindows()
                shutdown()
            }}/>
    </box>
}