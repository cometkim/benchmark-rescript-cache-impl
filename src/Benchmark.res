open RescriptCore
open RescriptTinybench

{
  Console.log("Case 1 - make empty collection")

  let bench =
    Bench.make()
    ->Bench.add("make empty JsMap", () => {
      let _ = JsMap.make()
    })
    ->Bench.add("make empty BeltMap", () => {
      let _ = BeltMap.make()
    })
    ->Bench.add("make empty BeltHashMap", () => {
      let _ = BeltHashMap.make(~hintSize=0)
    })

  await bench.run(.)
  bench.table(.)->Console.table
}

{
  Console.log("Case 1 - set initial 10 entries")

  let makeKey = n => {
    Key.foo: "test",
    bar: n,
    baz: (1.0, 2.0),
  }

  let jsMap = JsMap.make()
  let beltMap = BeltMap.make()
  let beltHashMap = BeltHashMap.make(~hintSize=10)

  let bench =
    Bench.make()
    ->Bench.add("set JsMap 10 entires", () => {
      Array.fromInitializer(~length=10, i => i)
      ->Array.reduce(jsMap, (map, i) => {
        map->JsMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltMap 10 entries", () => {
      Array.fromInitializer(~length=10, i => i)
      ->Array.reduce(beltMap, (map, i) => {
        map->BeltMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltHashMap 10 entries", () => {
      Array.fromInitializer(~length=10, i => i)
      ->Array.reduce(beltHashMap, (map, i) => {
        map->BeltHashMap.set(makeKey(i), i)
      })
      ->ignore
    })

  await bench.run(.)
  bench.table(.)->Console.table
}

{
  Console.log("Case 3 - get an existing entry")

  let key = {
    Key.foo: "test",
    bar: 123,
    baz: (1.0, 2.0),
  }

  let jsMap = JsMap.make()->JsMap.set(key, "test")
  let beltMap = BeltMap.make()->BeltMap.set(key, "test")
  let beltHashMap = BeltHashMap.make(~hintSize=1)->BeltHashMap.set(key, "test")

  let bench =
    Bench.make()
    ->Bench.add("get JsMap entry", () => {
      jsMap->JsMap.get(key)->ignore
    })
    ->Bench.add("get BeltMap entry", () => {
      beltMap->BeltMap.get(key)->ignore
    })
    ->Bench.add("get BeltHashMap entry", () => {
      beltHashMap->BeltHashMap.get(key)->ignore
    })

  await bench.run(.)
  bench.table(.)->Console.table
}
