import Cairo from "cairo";
import {Gtk} from "astal/gtk4";
import {variableConfig} from "../../config/config";
import {hexToRgba} from "../utils/strings";
import {Binding, Variable} from "astal";
import {isBinding} from "../utils/bindings";

export default function (
    {
        text,
        fontSize,
        flipped,
        bold,
        alignment,
        minimumHeight = 0,
        foregroundColor = variableConfig.theme.colors.foreground(),
    }:
    {
        text: string | Binding<string>,
        fontSize: number,
        flipped: boolean | Binding<boolean>,
        bold: boolean,
        alignment: Binding<Gtk.Align>,
        minimumHeight?: number,
        foregroundColor?: Binding<string>
    }
) {
    const variableParams = Variable.derive([
        variableConfig.theme.font,
        alignment
    ])
    return <box>
        {variableParams().as(([font, align]) => {
            return <VerticalLabelInternal
                text={text}
                fontSize={fontSize}
                flipped={flipped}
                bold={bold}
                alignment={align}
                minimumHeight={minimumHeight}
                font={font}
                foregroundColor={foregroundColor}/>
        })}
    </box>
}

function VerticalLabelInternal(
    {
        text,
        fontSize,
        flipped,
        bold,
        alignment = Gtk.Align.CENTER,
        minimumHeight = 0,
        font,
        foregroundColor,
    }:
    {
        text: string | Binding<string>,
        fontSize: number,
        flipped: boolean | Binding<boolean>,
        bold: boolean,
        alignment?: Gtk.Align,
        minimumHeight?: number,
        font: string,
        foregroundColor: Binding<string>
    }
) {
    const area = new Gtk.DrawingArea()
    area.set_content_width(fontSize)

    let realText = ""
    if (isBinding(text)) {
        text.subscribe((value) => {
            realText = value
            area.queue_draw()
        })
        realText = text.get()
    } else {
        realText = text
    }

    let realFlipped = false
    if (isBinding(flipped)) {
        flipped.subscribe((value) => {
            realFlipped = value
            area.queue_draw()
        })
        realFlipped = flipped.get()
    } else {
        realFlipped = flipped
    }

    let [r, g, b, a] = hexToRgba(foregroundColor.get())

    foregroundColor.subscribe((foreground) => {
        [r, g, b, a] = hexToRgba(foreground)
        area.queue_draw()
    })

    area.set_draw_func((widget, cr, width, height) => {
        // @ts-ignore
        cr.save()
        // @ts-ignore
        cr.translate(realFlipped ? width / 4 : width * 3/4, (height / 2) - 8)
        // @ts-ignore
        cr.rotate(realFlipped ? Math.PI / 2 : -Math.PI / 2) // 90 degrees counterclockwise
        // @ts-ignore
        cr.setSourceRGBA(r, g, b, a)
        // @ts-ignore
        cr.selectFontFace(font, Cairo.FontSlant.NORMAL, bold ? Cairo.FontWeight.BOLD : Cairo.FontWeight.NORMAL)// @ts-ignore
        cr.setFontSize(fontSize)

        // @ts-ignore
        const extents = cr.textExtents(realText)
        const textWidth = extents.width
        const textHeight = extents.height

        // align the text
        let y
        if (alignment === Gtk.Align.CENTER) {
            y = -textWidth / 2
        } else if ((alignment === Gtk.Align.START && flipped) || (alignment === Gtk.Align.END && !flipped)) {
            y = -height / 2
        } else {
            y = (height / 2) - textWidth
        }

        const x = (width - textHeight) / 2
        // @ts-ignore
        cr.moveTo(y, x)

        // @ts-ignore
        cr.showText(realText)
        // @ts-ignore
        cr.restore()

        // textWidth is height when rotated
        area.set_content_height(textWidth)
    })

    return <box
        heightRequest={minimumHeight}>
        {area}
    </box>
}