export default function(
    {
        cssClasses,
        marginTop,
        marginBottom,
        marginStart,
        marginEnd,
        thin = false,
    }: {
        cssClasses?: string[],
        marginTop?: number,
        marginBottom?: number,
        marginStart?: number,
        marginEnd?: number,
        thin?: boolean
    }
) {
    return <box
        marginTop={marginTop}
        marginBottom={marginBottom}
        marginStart={marginStart}
        marginEnd={marginEnd}
        cssClasses={
            cssClasses != null ?
                cssClasses.concat([thin ? "dividerThin" : "divider"]) :
                [thin ? "dividerThin" : "divider"]
        }/>
}