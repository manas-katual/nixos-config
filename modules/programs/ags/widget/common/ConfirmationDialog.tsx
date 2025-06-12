import {App, Astal, Gdk} from "astal/gtk4"
import OkButton from "./OkButton";
import {hideAllWindows, registerWindow} from "../utils/windows";
import {scrimsVisible} from "./Scrim";

export default function(
    message: string,
    confirm: string,
    deny: string,
    onConfirm: () => void,
): Astal.Window {
    let window: Astal.Window
    scrimsVisible.set(true)

    return <window
        widthRequest={400}
        heightRequest={150}
        application={App}
        exclusivity={Astal.Exclusivity.NORMAL}
        layer={Astal.Layer.OVERLAY}
        cssClasses={["window"]}
        visible={true}
        keymode={Astal.Keymode.ON_DEMAND}
        onKeyPressed={function (self, key) {
            if (key === Gdk.KEY_Escape) {
                hideAllWindows()
            }
        }}
        setup={(self) => {
            window = self
            registerWindow(self)
        }}>
        <box
            vertical={true}>
            <label
                marginStart={20}
                marginEnd={20}
                marginTop={20}
                marginBottom={20}
                vexpand={true}
                label={message}
                cssClasses={["labelLarge"]}/>
            <box
                vertical={false}>
                <OkButton
                    label={deny}
                    hexpand={true}
                    onClicked={() => {
                        hideAllWindows()
                    }}/>
                <OkButton
                    label={confirm}
                    hexpand={true}
                    onClicked={() => {
                        hideAllWindows()
                        onConfirm()
                    }}/>
            </box>
        </box>
    </window> as Astal.Window
}