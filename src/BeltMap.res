let make = () => Belt.Map.make(~id=module(Key.ObjectCmp))

let get = (t, key) => {
  t->Belt.Map.get(key)
}

let set = (t, key, value) => {
  t->Belt.Map.set(key, value)
}
