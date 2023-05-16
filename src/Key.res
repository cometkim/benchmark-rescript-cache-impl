type key = {
  id: int,
  foo: string,
  baz?: (float, float),
}

module ObjectHash = Belt.Id.MakeHashableU({
  type t = key
  let hash = (. t) => Hashtbl.hash(t)
  let eq = (. a, b) => a == b
})

module ObjectCmp = Belt.Id.MakeComparableU({
  type t = key
  let cmp = (. a, b) => Pervasives.compare(a, b)
})

module EntityHash = Belt.Id.MakeHashableU({
  type t = key
  let hash = (. t) => t.id
  let eq = (. a, b) => a == b
})
