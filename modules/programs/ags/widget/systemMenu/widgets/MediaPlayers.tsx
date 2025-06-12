import {Gtk} from "astal/gtk4"
import Pango from "gi://Pango?version=1.0";
import {Mpris, Player} from "../../utils/mpris"
import MprisControlButtons from "../../mpris/MprisControlButtons";

const mpris = Mpris.get_default()
const STREAMING_TRACK_LENGTH = 9999999999

function lengthStr(length: number) {
    const min = Math.floor(length / 60)
    const sec = Math.floor(length % 60)
    const sec0 = sec < 10 ? "0" : ""
    return `${min}:${sec0}${sec}`
}

function MediaPlayer({ player }: { player: Player }) {
    const { START, END, CENTER } = Gtk.Align

    const title = player.title(t =>
        t || "Unknown Track")

    const artist = player.artist(a =>
        a || "Unknown Artist")

    return <box
        cssClasses={["mediaPlayer"]}
        vertical={true}>
        <label
            cssClasses={["labelSmallBold"]}
            ellipsize={Pango.EllipsizeMode.END}
            halign={CENTER}
            label={title}/>
        <label
            cssClasses={["labelSmall"]}
            ellipsize={Pango.EllipsizeMode.END}
            halign={CENTER}
            label={artist}/>
        <box
            cssClasses={["seekContainer"]}
            vertical={false}>
            <label
                cssClasses={["labelSmall"]}
                halign={START}
                visible={player.trackLength(l => l > 0)}
                label={player.position(lengthStr)}
            />
            <slider
                cssClasses={["seek"]}
                hexpand={true}
                visible={player.trackLength(l => l > 0)}
                onChangeValue={({value}) => {
                    if (player.trackLength.get() > STREAMING_TRACK_LENGTH) {
                        return
                    }
                    player.setPosition(value * player.trackLength.get())
                }}
                value={player.position((position) => {
                    return player.trackLength.get() > 0 ? position / player.trackLength.get() : 0
                })}
            />
            <label
                cssClasses={["labelSmall"]}
                halign={END}
                visible={player.trackLength(l => l > 0)}
                label={player.trackLength((l) => {
                    if (l > STREAMING_TRACK_LENGTH) {
                        return " "
                    } else if (l > 0) {
                        return lengthStr(l)
                    } else {
                        return "0:00"
                    }
                })}
            />
        </box>
        <MprisControlButtons player={player} vertical={false}/>
    </box>
}

export default function () {
    return <box
        vertical={true}>
        {mpris.players(players => {
            return players.map(player => (
                <MediaPlayer player={player}/>
            ))
        })}
    </box>
}