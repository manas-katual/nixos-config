// ───────────────────────────────────────────────
//  Derived section‑level types for convenience
// ───────────────────────────────────────────────
import {SchemaToType, VariableSchemaToType} from "./typeGeneration";


import {CONFIG_SCHEMA} from "../schema/definitions/root";

export type Config = SchemaToType<typeof CONFIG_SCHEMA>
export type Notifications = Config["notifications"]
export type HorizontalBar = Config["horizontalBar"]
export type VerticalBar = Config["verticalBar"]
export type SystemMenu = Config["systemMenu"]
export type SystemCommands = Config["systemCommands"]


export const themeSchema = (CONFIG_SCHEMA.find(f => f.name === "theme")!)!

export type VariableConfig = VariableSchemaToType<typeof CONFIG_SCHEMA>
export type Theme = VariableConfig["theme"]