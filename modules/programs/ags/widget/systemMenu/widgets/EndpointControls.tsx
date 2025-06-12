import Wp from "gi://AstalWp"
import {bind, Binding, Variable} from "astal"
import {Gtk} from "astal/gtk4"
import Pango from "gi://Pango?version=1.0";
import RevealerRow from "../../common/RevealerRow";
import {toggleMuteEndpoint} from "../../utils/audio";
import {SystemMenuWindowName} from "../SystemMenuWindow";
import OkButton from "../../common/OkButton";

/**
 * An Endpoint is either a speaker or microphone
 *
 * @param defaultEndpoint either [Wp.Audio.default_speaker] or [Wp.Audio.default_microphone]
 * @param getIcon function that takes an Endpoint and returns the proper string icon
 * @param endpointsBinding binding obtained via [bind(Wp.Audio, "speakers")] or [bind(Wp.Audio, "microphones"]
 */
export default function (
    {
        defaultEndpoint,
        getIcon,
        endpointsBinding
    }: {
        defaultEndpoint: Wp.Endpoint,
        getIcon: (endpoint: Wp.Endpoint) => string,
        endpointsBinding: Binding<Wp.Endpoint[]>
    }
) {
    const endpointLabelVar = Variable.derive([
        bind(defaultEndpoint, "description"),
        bind(defaultEndpoint, "volume"),
        bind(defaultEndpoint, "mute")
    ])

    return <RevealerRow
        icon={endpointLabelVar(() => getIcon(defaultEndpoint))}
        iconOffset={0}
        windowName={SystemMenuWindowName}
        onClick={() => {
            toggleMuteEndpoint(defaultEndpoint)
        }}
        content={
            <slider
                cssClasses={["systemMenuVolumeProgress"]}
                hexpand={true}
                onChangeValue={({value}) => {
                    defaultEndpoint.volume = value
                }}
                value={bind(defaultEndpoint, "volume")}
            />
        }
        revealedContent={
            <box
                marginTop={10}
                vertical={true}>
                {endpointsBinding.as((endpoints) => {
                    return endpoints.map((endpoint) => {
                        return <OkButton
                            hexpand={true}
                            onClicked={() => {
                                endpoint.set_is_default(true)
                            }}
                            ellipsize={Pango.EllipsizeMode.END}
                            label={bind(endpoint, "isDefault").as((isDefault) => {
                                if (isDefault) {
                                    return `  ${endpoint.description}`
                                } else {
                                    return `   ${endpoint.description}`
                                }
                            })}
                            labelHalign={Gtk.Align.START}/>
                    })
                })}
            </box>
        }
    />
}