let make = (~hintSize) => Belt.HashMap.make(~id=module(Key.KeyHash), ~hintSize)

let get = (t, key) => {
  t->Belt.HashMap.get(key)
}

let set = (t, key, value) => {
  t->Belt.HashMap.set(key, value)
  t
}
