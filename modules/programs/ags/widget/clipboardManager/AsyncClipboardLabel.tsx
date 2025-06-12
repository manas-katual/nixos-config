import {execAsync} from "astal/process";
import {Variable} from "astal";
import {insertNewlines} from "../utils/strings";

export default function ({cliphistId}: {cliphistId: number}) {
    const text = Variable("")
    const label = <label
        xalign={0}
        wrap={true}
        hexpand={true}
        cssClasses={["labelSmall"]}
        label={text()}/>

    execAsync(["bash", "-c", `cliphist decode ${cliphistId}`]).catch((error) => {
        console.log(error)
    }).then((value) => {
        if (typeof value !== "string") {
            return
        }
        text.set(insertNewlines(value, 30))
    })

    return label
}
