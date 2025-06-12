import {App, Astal, Gdk, Gtk} from "astal/gtk4";
import {Binding, Variable} from "astal";
import {variableConfig} from "../../config/config";
import {hideAllWindows} from "../utils/windows";
import {Bar, selectedBar} from "../../config/bar";

type Params = {
    monitor: number | Binding<number>;
    windowName: string,
    namespace?: string,
    anchor?: Binding<Astal.WindowAnchor> | Astal.WindowAnchor,
    topExpand: Binding<boolean> | boolean,
    bottomExpand: Binding<boolean> | boolean,
    rightExpand: Binding<boolean> | boolean,
    leftExpand: Binding<boolean> | boolean,
    contentWidth: number,
    width?: number | Binding<number>,
    height?: number | Binding<number>,
    content?: JSX.Element;
}

function defaultAnchor(){
    return Variable.derive([
        selectedBar,
        variableConfig.horizontalBar.expanded,
        variableConfig.verticalBar.expanded,
    ], (bar, hExpanded, vExpanded) => {
        switch (bar) {
            case Bar.TOP:
            case Bar.BOTTOM:
                if (hExpanded) {
                    return Astal.WindowAnchor.TOP
                        | Astal.WindowAnchor.RIGHT
                        | Astal.WindowAnchor.BOTTOM
                        | Astal.WindowAnchor.LEFT
                }
                return Astal.WindowAnchor.TOP
                    | Astal.WindowAnchor.BOTTOM
            case Bar.LEFT:
                if (!vExpanded) {
                    return Astal.WindowAnchor.LEFT
                }
                return Astal.WindowAnchor.TOP
                    | Astal.WindowAnchor.LEFT
                    | Astal.WindowAnchor.BOTTOM
            case Bar.RIGHT:
                if (!vExpanded) {
                    return Astal.WindowAnchor.RIGHT
                }
                return Astal.WindowAnchor.TOP
                    | Astal.WindowAnchor.RIGHT
                    | Astal.WindowAnchor.BOTTOM
        }
    })
}

export default function(
    {
        monitor,
        windowName,
        namespace,
        anchor = defaultAnchor()(),
        topExpand,
        bottomExpand,
        rightExpand,
        leftExpand,
        contentWidth,
        width = 0,
        height = 0,
        content,
    }: Params
) {
    let mainBox: Astal.Box

    return <window
        heightRequest={height}
        widthRequest={width}
        monitor={monitor}
        namespace={namespace}
        name={windowName}
        anchor={anchor}
        margin={variableConfig.theme.windows.gaps()}
        exclusivity={Astal.Exclusivity.NORMAL}
        layer={Astal.Layer.OVERLAY}
        cssClasses={["transparentBackground"]}
        application={App}
        visible={false}
        keymode={Astal.Keymode.ON_DEMAND}
        onKeyPressed={function (_, key) {
            if (key === Gdk.KEY_Escape) {
                hideAllWindows()
            }
        }}
        setup={(self) => {
            const gesture = new Gtk.GestureClick();
            gesture.connect('pressed', (_gesture, n_press, x, y) => {
                const [_, childX, childY] = mainBox.translate_coordinates(self, 0, 0)
                const allocation = mainBox.get_allocation();
                const insideIgnoredChild =
                    x >= childX &&
                    x <= childX + allocation.width &&
                    y >= childY &&
                    y <= childY + allocation.height;

                if (insideIgnoredChild) {
                    return;
                }
                hideAllWindows()
            });
            self.add_controller(gesture);
        }}>
        <box vertical={true}>
            <box vexpand={topExpand}/>
            <box
                vertical={false}>
                <box hexpand={leftExpand}/>
                <box
                    hexpand={false}
                    vertical={true}
                    cssClasses={["window"]}
                    setup={(self) => {
                        mainBox = self;
                    }}>
                    <Gtk.ScrolledWindow
                        cssClasses={["scrollWindow"]}
                        vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                        propagateNaturalHeight={true}
                        widthRequest={contentWidth}>
                        {content}
                    </Gtk.ScrolledWindow>
                </box>
                <box hexpand={rightExpand}/>
            </box>
            <box vexpand={bottomExpand}/>
        </box>
    </window>
}