type key = {
  foo: string,
  bar: int,
  baz?: (float, float),
}

module KeyHash = Belt.Id.MakeHashableU({
  type t = key
  let hash = (. t) => Hashtbl.hash(t)
  let eq = (. a, b) => a == b
})

module KeyCmp = Belt.Id.MakeComparableU({
  type t = key
  let cmp = (. a, b) => Pervasives.compare(a, b)
})
