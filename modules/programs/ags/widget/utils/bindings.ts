import {Binding} from "astal";

export function isBinding<T>(value: unknown): value is Binding<T> {
    return (
        typeof value === "object" &&
        value !== null &&
        "get" in value &&
        typeof (value as Binding<T>).get === "function"
    );
}