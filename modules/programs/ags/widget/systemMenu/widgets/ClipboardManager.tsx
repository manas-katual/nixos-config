import {Gtk} from "astal/gtk4"
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../../common/RevealerRow";
import {SystemMenuWindowName} from "../SystemMenuWindow";
import {ClipboardManagerContent} from "../../clipboardManager/ClipboardManager";

export default function () {

    return <RevealerRow
        icon={""}
        iconOffset={0}
        windowName={SystemMenuWindowName}
        content={
            <label
                cssClasses={["labelMediumBold"]}
                halign={Gtk.Align.START}
                hexpand={true}
                ellipsize={Pango.EllipsizeMode.END}
                label={"Clipboard Manager"}/>
        }
        revealedContent={
            <box
                marginTop={8}>
                <ClipboardManagerContent/>
            </box>
        }
    />
}