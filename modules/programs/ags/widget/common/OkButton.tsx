import {bind, Binding, Variable} from "astal";
import {isBinding} from "../utils/bindings";
import {Gtk} from "astal/gtk4";
import Pango from "gi://Pango?version=1.0";

export enum OkButtonHorizontalPadding {
    STANDARD,
    THIN,
    NONE
}

export enum OkButtonVerticalPadding {
    STANDARD,
    THIN,
    NONE
}

export enum OkButtonSize {
    SMALL,
    MEDIUM,
    LARGE,
    XL,
}

function buildButtonCssClasses(
    backgroundCss: string[],
    size: OkButtonSize,
    primary: boolean,
    menuButtonContent?: JSX.Element,
    selected?: Binding<boolean>,
): string[] | Binding<string[]> {
    const buttonClasses: string[] = []

    switch (size) {
        case OkButtonSize.SMALL:
        case OkButtonSize.MEDIUM:
        case OkButtonSize.LARGE:
            buttonClasses.push("radiusSmall")
            break
        case OkButtonSize.XL:
            buttonClasses.push("radiusLarge")
            break
    }

    if (menuButtonContent !== undefined) {
        buttonClasses.push("trayIconButton")
    }

    if (primary) {
        buttonClasses.push("backgroundColorPrimary")
    }

    if (selected === undefined) {
        buttonClasses.push("okButtonClass")
        if (primary) {
            buttonClasses.push("okButtonClassPrimary")
        }
        buttonClasses.push(...backgroundCss)
        return buttonClasses
    }

    return selected.as((isSelected) => {
        if (isSelected) {
            return buttonClasses.concat("okButtonClassSelected")
        } else {
            return buttonClasses.concat("okButtonClass")
        }
    })
}

export default function(
    {
        labelCss = [],
        backgroundCss = [],
        label,
        offset = 0,
        selected,
        hpadding = OkButtonHorizontalPadding.STANDARD,
        vpadding = OkButtonVerticalPadding.STANDARD,
        size = OkButtonSize.SMALL,
        bold = false,
        warning = false,
        primary = false,
        visible = true,
        widthRequest = 0,
        heightRequest = 0,
        marginTop,
        marginBottom,
        marginStart,
        marginEnd,
        hexpand = false,
        vexpand = false,
        halign = Gtk.Align.FILL,
        valign = Gtk.Align.FILL,
        labelHalign = Gtk.Align.FILL,
        ellipsize = Pango.EllipsizeMode.NONE,
        menuButtonContent,
        onHoverEnter,
        onHoverLeave,
        onClicked,
    }:
    {
        labelCss?: string[]
        backgroundCss?: string[]
        label: Binding<string> | string,
        offset?: number | Binding<number>,
        selected?: Binding<boolean>,
        hpadding?: OkButtonHorizontalPadding | Binding<OkButtonHorizontalPadding>,
        vpadding?: OkButtonVerticalPadding | Binding<OkButtonVerticalPadding>,
        size?: OkButtonSize | Binding<OkButtonSize>,
        bold?: boolean | Binding<boolean>,
        warning?: boolean | Binding<boolean>,
        primary?: boolean,
        visible?: boolean | Binding<boolean>,
        widthRequest?: number,
        heightRequest?: number,
        marginTop?: number,
        marginBottom?: number,
        marginStart?: number,
        marginEnd?: number,
        hexpand?: boolean | Binding<boolean>,
        vexpand?: boolean | Binding<boolean>,
        halign?: Gtk.Align | Binding<Gtk.Align>,
        valign?: Gtk.Align | Binding<Gtk.Align>,
        labelHalign?: Gtk.Align | Binding<Gtk.Align>,
        ellipsize?: Pango.EllipsizeMode,
        menuButtonContent?: JSX.Element,
        onHoverEnter?: () => void,
        onHoverLeave?: () => void,
        onClicked?: () => void
    }
) {
    let realWarning: Binding<boolean>
    if (isBinding(warning)) {
        realWarning = warning
    } else {
        realWarning = bind(Variable(warning))
    }
    let realSize: Binding<OkButtonSize>
    if (isBinding(size)) {
        realSize = size
    } else {
        realSize = bind(Variable(size))
    }
    let realBold: Binding<boolean>
    if (isBinding(bold)) {
        realBold = bold
    } else {
        realBold = bind(Variable(bold))
    }
    const cssInputs = Variable.derive([
        realWarning,
        realSize,
        realBold,
    ])

    const labelVerticalMargin = Variable.derive([
        isBinding(vpadding) ? vpadding : bind(Variable(vpadding))
    ], (v) => {
        switch (v) {
            case OkButtonVerticalPadding.STANDARD:
                return 8
            case OkButtonVerticalPadding.THIN:
                return 4
            case OkButtonVerticalPadding.NONE:
                return 0
        }
    })

    const labelMarginStart = Variable.derive([
        isBinding(offset) ? offset : bind(Variable(offset)),
        isBinding(hpadding) ? hpadding : bind(Variable(hpadding)),
    ], (o, h) => {
        let horizontalPadding
        switch (h) {
            case OkButtonHorizontalPadding.STANDARD:
                horizontalPadding = 18
                break
            case OkButtonHorizontalPadding.THIN:
                horizontalPadding = 14
                break
            case OkButtonHorizontalPadding.NONE:
                horizontalPadding = 0
        }
        return horizontalPadding - o
    })

    const labelMarginEnd = Variable.derive([
        isBinding(offset) ? offset : bind(Variable(offset)),
        isBinding(hpadding) ? hpadding : bind(Variable(hpadding)),
    ], (o, h) => {
        let horizontalPadding
        switch (h) {
            case OkButtonHorizontalPadding.STANDARD:
                horizontalPadding = 18
                break
            case OkButtonHorizontalPadding.THIN:
                horizontalPadding = 14
                break
            case OkButtonHorizontalPadding.NONE:
                horizontalPadding = 0
        }
        return horizontalPadding + o
    })

    const onlyLabel = onClicked === undefined && menuButtonContent === undefined

    const labelWidget = <label
        visible={visible}
        ellipsize={ellipsize}
        halign={labelHalign}
        valign={onlyLabel ? valign : Gtk.Align.FILL}
        hexpand={onlyLabel ? hexpand : false}
        vexpand={onlyLabel ? vexpand : false}
        cssClasses={cssInputs(([warning, size, bold]) => {
            const labelClasses: string[] = []

            switch (size) {
                case OkButtonSize.SMALL:
                    labelClasses.push("labelSmall")
                    break
                case OkButtonSize.MEDIUM:
                    labelClasses.push("labelMedium")
                    break
                case OkButtonSize.LARGE:
                    labelClasses.push("labelLarge")
                    break
                case OkButtonSize.XL:
                    labelClasses.push("labelXL")
                    break
            }

            if (bold) {
                labelClasses.push("bold")
            }

            labelClasses.push(...labelCss)

            return warning ? labelClasses.concat("colorWarning") : labelClasses
        })}
        marginTop={labelVerticalMargin()}
        marginBottom={labelVerticalMargin()}
        marginStart={labelMarginStart()}
        marginEnd={labelMarginEnd()}
        label={label}
        onHoverEnter={onHoverEnter}
        onHoverLeave={onHoverLeave}/>

    const buttonClasses = buildButtonCssClasses(
        backgroundCss,
        realSize.get(),
        primary,
        menuButtonContent,
        selected,
    )

    if (menuButtonContent !== undefined) {
        return <menubutton
            widthRequest={widthRequest}
            heightRequest={heightRequest}
            marginTop={marginTop}
            marginBottom={marginBottom}
            marginStart={marginStart}
            marginEnd={marginEnd}
            halign={halign}
            valign={valign}
            hexpand={hexpand}
            vexpand={vexpand}
            visible={visible}
            cssClasses={buttonClasses}
            onClicked={onClicked}>
            {labelWidget}
            {menuButtonContent}
        </menubutton>
    }

    return <button
        sensitive={!onlyLabel}
        widthRequest={widthRequest}
        heightRequest={heightRequest}
        marginTop={marginTop}
        marginBottom={marginBottom}
        marginStart={marginStart}
        marginEnd={marginEnd}
        halign={halign}
        valign={valign}
        hexpand={hexpand}
        vexpand={vexpand}
        visible={visible}
        cssClasses={buttonClasses}
        onClicked={onClicked}>
        {labelWidget}
    </button>
}