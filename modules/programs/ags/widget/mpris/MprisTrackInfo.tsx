import {Player} from "../utils/mpris";
import VerticalLabel from "../common/VerticalLabel";
import {Binding, Variable} from "astal";
import {truncateString} from "../utils/strings";
import {variableConfig} from "../../config/config";
import {alignmentToGtk} from "../utils/configHelper";
import {Gtk} from "astal/gtk4";

export default function (
    {
        player,
        vertical,
        flipped,
        compact,
    }: {
        player: Player,
        vertical: boolean,
        flipped: Binding<boolean>,
        compact: Binding<boolean>,
    }
) {
    const title = Variable.derive([
        player.title,
        variableConfig.verticalBar.mpris_track_info.textLength,
        variableConfig.horizontalBar.mpris_track_info.textLength,
    ], (title, vLength, hLength) => {
        return title ? truncateString(
            title,
            vertical ? vLength : hLength
        ) : "Unknown Track"
    })

    const artist = Variable.derive([
        player.artist,
        variableConfig.verticalBar.mpris_track_info.textLength,
        variableConfig.horizontalBar.mpris_track_info.textLength,
    ], (artist, vLength, hLength) => {
        return artist ?  truncateString(
            artist,
            vertical ? vLength : hLength
        ) : "Unknown Artist"
    })

    return <box>
        {vertical &&
            <box
                hexpand={true}>
                {flipped.as((isFlipped) => {
                    const alignment: Binding<Gtk.Align> = variableConfig.verticalBar.mpris_track_info.textAlignment().as((align) =>
                        alignmentToGtk(align)
                    )
                    if (isFlipped) {
                        return <box
                            hexpand={true}
                            halign={Gtk.Align.CENTER}
                            vertical={false}
                            heightRequest={variableConfig.verticalBar.mpris_track_info.minimumLength()}>
                            <VerticalLabel
                                text={artist()}
                                fontSize={14}
                                flipped={isFlipped}
                                bold={false}
                                alignment={alignment}
                                foregroundColor={variableConfig.theme.bars.mpris_track_info.foreground()}
                            />
                            <VerticalLabel
                                text={title()}
                                fontSize={14}
                                flipped={isFlipped}
                                bold={true}
                                alignment={alignment}
                                foregroundColor={variableConfig.theme.bars.mpris_track_info.foreground()}
                            />
                        </box>
                    } else {
                        return <box
                            hexpand={true}
                            halign={Gtk.Align.CENTER}
                            vertical={false}
                            heightRequest={variableConfig.verticalBar.mpris_track_info.minimumLength()}>
                            <VerticalLabel
                                text={title()}
                                fontSize={14}
                                flipped={isFlipped}
                                bold={true}
                                alignment={alignment}
                                foregroundColor={variableConfig.theme.bars.mpris_track_info.foreground()}
                            />
                            <VerticalLabel
                                text={artist()}
                                fontSize={14}
                                flipped={isFlipped}
                                bold={false}
                                alignment={alignment}
                                foregroundColor={variableConfig.theme.bars.mpris_track_info.foreground()}
                            />
                        </box>
                    }
                })}
            </box>
        }
        {!vertical &&
            <box
                vertical={true}
                valign={Gtk.Align.CENTER}
                widthRequest={variableConfig.horizontalBar.mpris_track_info.minimumLength()}>
                <label
                    marginStart={8}
                    cssClasses={["labelSmallBold", "barMprisTrackInfoForeground", "lineHeightCompact"]}
                    halign={variableConfig.horizontalBar.mpris_track_info.textAlignment().as((a) => alignmentToGtk(a))}
                    label={title()}/>
                <label
                    marginStart={8}
                    cssClasses={["labelSmall", "barMprisTrackInfoForeground", "lineHeightCompact"]}
                    halign={variableConfig.horizontalBar.mpris_track_info.textAlignment().as((a) => alignmentToGtk(a))}
                    label={artist()}/>
            </box>
        }
    </box>
}