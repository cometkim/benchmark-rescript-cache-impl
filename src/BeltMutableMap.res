let make = () => Belt.MutableMap.make(~id=module(Key.ObjectCmp))

let get = (t, key) => {
  t->Belt.MutableMap.get(key)
}

let set = (t, key, value) => {
  t->Belt.MutableMap.set(key, value)
  t
}
