import {Gtk} from "astal/gtk4"
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../../common/RevealerRow";
import {SystemMenuWindowName} from "../SystemMenuWindow";
import OkButton, {OkButtonSize} from "../../common/OkButton";
import {hideAllWindows, toggleWindow} from "../../utils/windows";
import {ScreenshotWindowName} from "../../screenshot/Screenshot";
import {runColorPicker} from "../../utils/colorPicker";

function ColorPicker() {
    return <box>
        <OkButton
            offset={2}
            label=""
            size={OkButtonSize.XL}
            onClicked={() => {
                runColorPicker(500).catch((error) => console.log(error))
            }}/>
    </box>
}

function ScreenShotGizmo() {
    return <box>
        <OkButton
            offset={4}
            label="󰹑"
            size={OkButtonSize.XL}
            onClicked={() => {
                hideAllWindows()
                toggleWindow(ScreenshotWindowName)
            }}/>
    </box>
}

export default function () {
    return <RevealerRow
        icon=""
        iconOffset={0}
        windowName={SystemMenuWindowName}
        content={
            <label
                cssClasses={["labelMediumBold"]}
                halign={Gtk.Align.START}
                hexpand={true}
                ellipsize={Pango.EllipsizeMode.END}
                label="Toolbox"/>
        }
        revealedContent={
            <box
                marginTop={10}
                vertical={false}
                spacing={10}
                halign={Gtk.Align.CENTER}>
                <ColorPicker/>
                <ScreenShotGizmo/>
            </box>
        }
    />
}