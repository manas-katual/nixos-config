import {isRecording} from "../../screenshot/Screenshot";
import OkButton from "../../common/OkButton";
import {execAsync} from "astal/process";

export default function () {
    return <box
        visible={isRecording()}
        cssClasses={["systemMenuRecordingBox"]}>
        <box
            marginStart={20}
            marginEnd={20}
            marginTop={20}
            marginBottom={20}
            vertical={true}>
            <box
                hexpand={true}
                marginBottom={20}>
                <label
                    marginEnd={20}
                    cssClasses={["labelMediumBold", "colorWarning"]}
                    label=""/>
                <label
                    cssClasses={["labelMediumBold"]}
                    label="Recording screen..."/>
            </box>
            <OkButton
                label="Stop"
                primary={true}
                hexpand={true}
                onClicked={() => {
                    execAsync("pkill wf-recorder")
                        .catch((error) => {
                            console.error(error)
                        })
                }}/>
        </box>
    </box>
}