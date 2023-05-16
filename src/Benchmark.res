open RescriptCore
open RescriptTinybench

@val @scope("process.env") external format: string = "FORMAT"
let printAsJson = format == "json" || format == "JSON"

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
    ->Bench.add("make empty BeltMutableMap", () => {
      let _ = BeltMutableMap.make()
    })
    ->Bench.add("make empty BeltHashMap", () => {
      let _ = Belt.HashMap.make(~hintSize=0, ~id=module(Key.ObjectHash))
    })

  await bench.run(.)

  if printAsJson {
    bench.table(.)->Console.log
  } else {
    bench.table(.)->Console.table
  }
}

{
  let size = 100

  Console.log(`Case 2 - set initial ${size->Int.toString} entries`)

  let id = x => x
  let makeKey = n => {
    Key.id: n,
    foo: "test",
    baz: (1.0, 2.0),
  }

  let jsMap = JsMap.make()
  let jsMapStableKey = JsMap.make()
  let beltMap = BeltMap.make()
  let beltMutableMap = BeltMutableMap.make()
  let beltHashMapObjects = Belt.HashMap.make(~hintSize=size, ~id=module(Key.ObjectHash))
  let beltHashMapEntities = Belt.HashMap.make(~hintSize=size, ~id=module(Key.EntityHash))

  let bench =
    Bench.make()
    ->Bench.add("set JsMap entires", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(jsMap, (map, i) => {
        map->JsMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set JsMap entries with stableKey", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(jsMapStableKey, (map, i) => {
        map->JsMap.setWithStableKey(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltMap entries", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(beltMap, (map, i) => {
        map->BeltMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltMutableMap entries", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(beltMutableMap, (map, i) => {
        map->BeltMutableMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltHashMap entries with hash", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(beltHashMapObjects, (map, i) => {
        map->BeltHashMap.set(makeKey(i), i)
      })
      ->ignore
    })
    ->Bench.add("set BeltHashMap entries with id", () => {
      Array.fromInitializer(~length=size, id)
      ->Array.reduce(beltHashMapEntities, (map, i) => {
        map->BeltHashMap.set(makeKey(i), i)
      })
      ->ignore
    })

  await bench.run(.)

  if printAsJson {
    bench.table(.)->Console.log
  } else {
    bench.table(.)->Console.table
  }
}

{
  let size = 100

  Console.log(`Case 3 - get an existing entry (size=${size->Int.toString})`)

  let id = x => x
  let makeKey = n => {
    Key.id: n,
    foo: "test",
    baz: (1.0, 2.0),
  }

  let jsMap = Array.fromInitializer(~length=size, id)->Array.reduce(JsMap.make(), (map, i) => {
    map->JsMap.set(makeKey(i), i)
  })
  let jsMapStableKey = Array.fromInitializer(~length=size, id)->Array.reduce(JsMap.make(), (
    map,
    i,
  ) => {
    map->JsMap.set(makeKey(i), i)
  })
  let beltMap = Array.fromInitializer(~length=size, id)->Array.reduce(BeltMap.make(), (map, i) => {
    map->BeltMap.set(makeKey(i), i)
  })
  let beltMutableMap = Array.fromInitializer(~length=size, id)->Array.reduce(
    BeltMutableMap.make(),
    (map, i) => {
      map->BeltMutableMap.set(makeKey(i), i)
    },
  )
  let beltHashMapObjects = Array.fromInitializer(~length=size, id)->Array.reduce(
    Belt.HashMap.make(~hintSize=size, ~id=module(Key.ObjectHash)),
    (map, i) => {
      map->BeltHashMap.set(makeKey(i), i)
    },
  )
  let beltHashMapEntities = Array.fromInitializer(~length=size, id)->Array.reduce(
    Belt.HashMap.make(~hintSize=size, ~id=module(Key.EntityHash)),
    (map, i) => {
      map->BeltHashMap.set(makeKey(i), i)
    },
  )

  let searchKey = makeKey(size / 2)

  let bench =
    Bench.make()
    ->Bench.add("get JsMap entry", () => {
      jsMap->JsMap.get(searchKey)->ignore
    })
    ->Bench.add("get JsMap entry with stableKey", () => {
      jsMapStableKey->JsMap.getWithStableKey(searchKey)->ignore
    })
    ->Bench.add("get BeltMap entry", () => {
      beltMap->BeltMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltMutableMap entry", () => {
      beltMutableMap->BeltMutableMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltHashMap entry with hash", () => {
      beltHashMapObjects->BeltHashMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltHashMap entry with id", () => {
      beltHashMapEntities->BeltHashMap.get(searchKey)->ignore
    })

  await bench.run(.)

  if printAsJson {
    bench.table(.)->Console.log
  } else {
    bench.table(.)->Console.table
  }
}

{
  let size = 10000

  Console.log(`Case 4 - get an existing entry (size=${size->Int.toString})`)

  let id = x => x
  let makeKey = n => {
    Key.id: n,
    foo: "test",
    baz: (1.0, 2.0),
  }
  let searchKey = makeKey(size / 2)

  let jsMap = Array.fromInitializer(~length=size, id)->Array.reduce(JsMap.make(), (map, i) => {
    map->JsMap.set(makeKey(i), i)
  })
  let jsMapStableKey = Array.fromInitializer(~length=size, id)->Array.reduce(JsMap.make(), (
    map,
    i,
  ) => {
    map->JsMap.set(makeKey(i), i)
  })
  let beltMap = Array.fromInitializer(~length=size, id)->Array.reduce(BeltMap.make(), (map, i) => {
    map->BeltMap.set(makeKey(i), i)
  })
  let beltMutableMap = Array.fromInitializer(~length=size, id)->Array.reduce(
    BeltMutableMap.make(),
    (map, i) => {
      map->BeltMutableMap.set(makeKey(i), i)
    },
  )
  let beltHashMapObjects = Array.fromInitializer(~length=size, id)->Array.reduce(
    Belt.HashMap.make(~hintSize=size, ~id=module(Key.ObjectHash)),
    (map, i) => {
      map->BeltHashMap.set(makeKey(i), i)
    },
  )
  let beltHashMapEntities = Array.fromInitializer(~length=size, id)->Array.reduce(
    Belt.HashMap.make(~hintSize=size, ~id=module(Key.EntityHash)),
    (map, i) => {
      map->BeltHashMap.set(makeKey(i), i)
    },
  )

  let bench =
    Bench.make()
    ->Bench.add("get JsMap entry", () => {
      jsMap->JsMap.get(searchKey)->ignore
    })
    ->Bench.add("get JsMap entry with stableKey", () => {
      jsMapStableKey->JsMap.getWithStableKey(searchKey)->ignore
    })
    ->Bench.add("get BeltMap entry", () => {
      beltMap->BeltMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltMutableMap entry", () => {
      beltMutableMap->BeltMutableMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltHashMap entry with hash", () => {
      beltHashMapObjects->BeltHashMap.get(searchKey)->ignore
    })
    ->Bench.add("get BeltHashMap entry with id", () => {
      beltHashMapEntities->BeltHashMap.get(searchKey)->ignore
    })

  await bench.run(.)

  if printAsJson {
    bench.table(.)->Console.log
  } else {
    bench.table(.)->Console.table
  }
}
