open RescriptCore

let make = () => Map.make()

let get = (t, key) => {
  t->Map.get(Js.Json.stringifyAny(key)->Option.getUnsafe)
}

let set = (t, key, value) => {
  t->Map.set(Js.Json.stringifyAny(key)->Option.getUnsafe, value)
  t
}

@module("./stableStringify.mjs")
external stableStringifyValue: 'any => string = "stableStringify"

let getWithStableKey = (t, key) => {
  t->Map.get(stableStringifyValue(key))
}

let setWithStableKey = (t, key, value) => {
  t->Map.set(stableStringifyValue(key), value)
  t
}
