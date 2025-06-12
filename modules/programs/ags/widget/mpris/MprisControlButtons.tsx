import {LoopStatus, PlaybackStatus, Player, ShuffleStatus} from "../utils/mpris";
import {Gtk} from "astal/gtk4";
import OkButton, {OkButtonHorizontalPadding} from "../common/OkButton";
import {getHPadding, getVPadding} from "../bar/BarWidgets";

export default function (
    {
        player,
        vertical,
        foregroundCss = [],
        backgroundCss = [],
    }:
    {
        player: Player,
        vertical: boolean,
        foregroundCss?: string[],
        backgroundCss?: string[],
    }
) {
    const playIcon = player.playbackStatus(s =>
        s === PlaybackStatus.Playing
            ? ""
            : ""
    )

    return <box
        halign={Gtk.Align.CENTER}
        vertical={vertical}>
        <OkButton
            labelCss={foregroundCss}
            backgroundCss={backgroundCss}
            hpadding={getHPadding(vertical)}
            vpadding={getVPadding(vertical)}
            onClicked={() => {
                if (player.shuffleStatus.get() === ShuffleStatus.Enabled) {
                    player.setShuffleStatus(ShuffleStatus.Disabled)
                } else {
                    player.setShuffleStatus(ShuffleStatus.Enabled)
                }
            }}
            visible={player.shuffleStatus((shuffle) => shuffle !== ShuffleStatus.Unsupported)}
            label={player.shuffleStatus((shuffle) => {
                if (shuffle === ShuffleStatus.Enabled) {
                    return ""
                } else {
                    return "󰒞"
                }
            })}/>
        <OkButton
            labelCss={foregroundCss}
            backgroundCss={backgroundCss}
            hpadding={getHPadding(vertical)}
            vpadding={getVPadding(vertical)}
            onClicked={() => {
                player.previousTrack()
            }}
            visible={player.canGoPrevious()}
            label=""/>
        <OkButton
            labelCss={foregroundCss}
            backgroundCss={backgroundCss}
            hpadding={getHPadding(vertical)}
            vpadding={getVPadding(vertical)}
            onClicked={() => {
                player.playPause()
            }}
            visible={player.canControl()}
            label={playIcon}/>
        <OkButton
            labelCss={foregroundCss}
            backgroundCss={backgroundCss}
            hpadding={getHPadding(vertical)}
            vpadding={getVPadding(vertical)}
            onClicked={() => {
                player.nextTrack()
            }}
            visible={player.canGoNext()}
            label=""/>
        <OkButton
            labelCss={foregroundCss}
            backgroundCss={backgroundCss}
            hpadding={getHPadding(vertical)}
            vpadding={getVPadding(vertical)}
            onClicked={() => {
                if (player.loopStatus.get() === LoopStatus.None) {
                    player.setLoopStatus(LoopStatus.Playlist)
                } else if (player.loopStatus.get() === LoopStatus.Playlist) {
                    player.setLoopStatus(LoopStatus.Track)
                } else {
                    player.setLoopStatus(LoopStatus.None)
                }
            }}
            visible={player.loopStatus((status) => status !== LoopStatus.Unsupported)}
            label={player.loopStatus((status) => {
                if (status === LoopStatus.None) {
                    return "󰑗"
                } else if (status === LoopStatus.Playlist) {
                    return "󰑖"
                } else {
                    return "󰑘"
                }
            })}/>
    </box>
}