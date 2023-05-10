open RescriptCore

let make = () => Map.make()

@module("./stableStringify.mjs")
external stableStringifyValue: 'any => string = "stableStringify"

let get = (t, key) => {
  t->Map.get(stableStringifyValue(key))
}

let set = (t, key, value) => {
  t->Map.set(stableStringifyValue(key), value)
  t
}
