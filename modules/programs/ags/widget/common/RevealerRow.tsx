import {bind, Binding, Variable} from "astal";
import {App, Gtk} from "astal/gtk4";
import OkButton, {OkButtonHorizontalPadding, OkButtonSize} from "./OkButton";

type Params = {
    marginTop?: number;
    marginBottom?: number;
    marginStart?: number;
    marginEnd?: number;
    visible?: boolean | Binding<boolean>;
    icon: string | Binding<string>;
    iconOffset: number | Binding<number>;
    windowName: string;
    setup?: (revealed: Variable<boolean>) => void;
    onClick?: () => void;
    content?: JSX.Element;
    revealedContent?: JSX.Element;
}

export default function (
    {
        marginTop = 0,
        marginBottom = 0,
        marginStart = 0,
        marginEnd = 0,
        visible = true,
        icon,
        iconOffset,
        windowName,
        setup,
        onClick,
        content,
        revealedContent,
    }: Params
) {
    const revealed = Variable(false)

    if (setup) {
        setup(revealed)
    }

    setTimeout(() => {
        bind(App.get_window(windowName)!, "visible").subscribe((visible) => {
            if (!visible) {
                revealed.set(false)
            }
        })
    }, 1_000)

    return <box
        visible={visible}
        marginTop={marginTop}
        marginBottom={marginBottom}
        marginEnd={marginEnd}
        marginStart={marginStart}
        vertical={true}>
        <box
            vertical={false}>
            <OkButton
                size={OkButtonSize.XL}
                offset={iconOffset}
                label={icon}
                onClicked={onClick}/>
            <box marginEnd={10}/>
            <box
                marginTop={4}>
                {content}
            </box>
            <OkButton
                size={OkButtonSize.SMALL}
                hpadding={OkButtonHorizontalPadding.THIN}
                label={revealed((revealed): string => {
                    if (revealed) {
                        return ""
                    } else {
                        return ""
                    }
                })}
                onClicked={() => {
                    revealed.set(!revealed.get())
                }}/>
        </box>
        <revealer
            marginStart={10}
            marginEnd={10}
            revealChild={revealed()}
            transitionDuration={200}
            transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}>
            {revealedContent}
        </revealer>
    </box>
}