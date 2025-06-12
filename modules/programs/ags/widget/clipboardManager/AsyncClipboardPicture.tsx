import {Gdk, Gtk} from "astal/gtk4";
import Gio from "gi://Gio?version=2.0";

export async function getTextureFromCliphist(
    cliphistId: number
): Promise<Gdk.Texture | undefined> {
    try {
        const proc = new Gio.Subprocess({
            argv: ["cliphist", "decode", cliphistId.toString()],
            flags: Gio.SubprocessFlags.STDOUT_PIPE | Gio.SubprocessFlags.STDERR_SILENCE,
        });

        proc.init(null);

        const [, stdoutBytes] = proc.communicate(null, null); // <== This is GLib.Bytes

        if (!stdoutBytes) {
            throw new Error("No image data received");
        }

        return Gdk.Texture.new_from_bytes(stdoutBytes);
    } catch (e) {
        console.error(e);
        return undefined;
    }
}

export default function ({cliphistId}: {cliphistId: number}) {
    const picture = new Gtk.Picture({
        heightRequest: 150,
        cssClasses: ["image"],
        keepAspectRatio: true,
        contentFit: Gtk.ContentFit.COVER,
        hexpand: true,
        marginEnd: 20
    })

    getTextureFromCliphist(cliphistId).catch((error) => {
        console.log(error)
    }).then((texture) => {
        if (typeof texture !== "object") {
            return
        }
        picture.paintable = texture
    })

    return picture
}
