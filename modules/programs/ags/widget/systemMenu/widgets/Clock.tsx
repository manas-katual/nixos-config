import {GLib, Variable} from "astal";
import {Gtk} from "astal/gtk4";
import {variableConfig} from "../../../config/config";

export default function () {
    const weekday = Variable<string>("").poll(1000, () => {
        const text = GLib.DateTime.new_now_local().format("%A")! // Full weekday name
        if (variableConfig.theme.systemMenu.clock.dayAllCaps.get()) {
            return text.toUpperCase()
        }
        return text
    });

    const date = Variable<string>("").poll(1000, () =>
            GLib.DateTime.new_now_local().format("%m/%d/%Y")!
        // %-d: Day of month (no leading 0), %B: Full month name, %Y: Year
    );

    const time = Variable<string>("").poll(1000, () =>
            GLib.DateTime.new_now_local().format("%-I:%M %p")!
        // %-I: Hour (12-hour, no leading 0), %M: Minute, %p: AM/PM
    );

    return <box
        vertical={false}>
        <label
            marginStart={20}
            halign={Gtk.Align.START}
            hexpand={true}
            cssClasses={["labelXXLBold", "systemMenuClockDayFont"]}
            label={weekday()}/>
        <box
            halign={Gtk.Align.START}
            marginStart={20}
            hexpand={true}
            vertical={true}>
            <label
                halign={Gtk.Align.START}
                cssClasses={["labelMediumBold"]}
                label={date()}/>
            <label
                halign={Gtk.Align.START}
                cssClasses={["labelSmall"]}
                label={time()}/>
        </box>
    </box>
}