# ReScript Cache Implementation Benchmark

This is a benchmark for Map collection, which is mainly used as a cache implementation in JS.

- JavaScript `Map` class
- Belt's [`Map`](https://rescript-lang.org/docs/manual/latest/api/belt/map) module
- Belt's [`HashMap`](https://rescript-lang.org/docs/manual/latest/api/belt/hash-map) module
- Belt's [`MutableMap`](https://rescript-lang.org/docs/manual/latest/api/belt/mutable-map) module

## Results

Tested on Ubuntu 22.10 x86_64, Node.js v20.0.0, Intel i5-9600K (6) @ 4.600GHz

```
Case 1 - make empty collection
┌─────────┬─────────────────────────────┬──────────────┬────────────────────┬──────────┬─────────┐
│ (index) │          Task Name          │   ops/sec    │ Average Time (ns)  │  Margin  │ Samples │
├─────────┼─────────────────────────────┼──────────────┼────────────────────┼──────────┼─────────┤
│    0    │     'make empty JsMap'      │ '9,234,808'  │ 108.28594867760152 │ '±0.75%' │ 4617405 │
│    1    │    'make empty BeltMap'     │ '10,347,465' │ 96.64202314241864  │ '±0.21%' │ 5173733 │
│    2    │ 'make empty BeltMutableMap' │ '10,322,948' │ 96.87154461568524  │ '±0.31%' │ 5161475 │
│    3    │  'make empty BeltHashMap'   │ '9,961,124'  │ 100.39026837369214 │ '±0.63%' │ 4980563 │
└─────────┴─────────────────────────────┴──────────────┴────────────────────┴──────────┴─────────┘

Case 2 - set initial 100 entries
┌─────────┬─────────────────────────────────────┬──────────┬────────────────────┬──────────┬─────────┐
│ (index) │              Task Name              │ ops/sec  │ Average Time (ns)  │  Margin  │ Samples │
├─────────┼─────────────────────────────────────┼──────────┼────────────────────┼──────────┼─────────┤
│    0    │         'set JsMap entires'         │ '18,018' │ 55497.122131759395 │ '±0.82%' │  9010   │
│    1    │ 'set JsMap entries with stableKey'  │ '8,972'  │ 111446.8711380813  │ '±1.11%' │  4487   │
│    2    │        'set BeltMap entries'        │ '4,844'  │ 206405.99586798344 │ '±1.43%' │  2423   │
│    3    │    'set BeltMutableMap entries'     │ '5,693'  │ 175652.33061239935 │ '±1.00%' │  2847   │
│    4    │ 'set BeltHashMap entries with hash' │ '23,512' │ 42530.02589347107  │ '±1.33%' │  11762  │
│    5    │  'set BeltHashMap entries with id'  │ '34,726' │ 28796.500736142352 │ '±9.24%' │  17399  │
└─────────┴─────────────────────────────────────┴──────────┴────────────────────┴──────────┴─────────┘

Case 3 - get an existing entry (size=100)
┌─────────┬───────────────────────────────────┬─────────────┬────────────────────┬──────────┬─────────┐
│ (index) │             Task Name             │   ops/sec   │ Average Time (ns)  │  Margin  │ Samples │
├─────────┼───────────────────────────────────┼─────────────┼────────────────────┼──────────┼─────────┤
│    0    │         'get JsMap entry'         │ '2,114,297' │ 472.9703176635118  │ '±0.32%' │ 1057149 │
│    1    │ 'get JsMap entry with stableKey'  │ '1,012,047' │ 988.0956260767281  │ '±0.73%' │ 506025  │
│    2    │        'get BeltMap entry'        │  '456,402'  │ 2191.0484897480324 │ '±0.60%' │ 228202  │
│    3    │    'get BeltMutableMap entry'     │  '458,501'  │ 2181.0163787607576 │ '±0.56%' │ 229251  │
│    4    │ 'get BeltHashMap entry with hash' │ '2,327,841' │ 429.5825737945608  │ '±0.74%' │ 1163921 │
│    5    │  'get BeltHashMap entry with id'  │ '3,247,332' │ 307.94507028359845 │ '±0.61%' │ 1623667 │
└─────────┴───────────────────────────────────┴─────────────┴────────────────────┴──────────┴─────────┘

Case 4 - get an existing entry (size=10000)
┌─────────┬───────────────────────────────────┬─────────────┬────────────────────┬──────────┬─────────┐
│ (index) │             Task Name             │   ops/sec   │ Average Time (ns)  │  Margin  │ Samples │
├─────────┼───────────────────────────────────┼─────────────┼────────────────────┼──────────┼─────────┤
│    0    │         'get JsMap entry'         │ '2,098,072' │ 476.62795060850743 │ '±0.65%' │ 1049037 │
│    1    │ 'get JsMap entry with stableKey'  │ '1,069,568' │ 934.9565742400516  │ '±0.81%' │ 534785  │
│    2    │        'get BeltMap entry'        │  '259,562'  │ 3852.636640564865  │ '±0.72%' │ 129782  │
│    3    │    'get BeltMutableMap entry'     │  '260,046'  │ 3845.471353813046  │ '±0.72%' │ 130024  │
│    4    │ 'get BeltHashMap entry with hash' │ '2,319,439' │ 431.1385646771329  │ '±0.89%' │ 1159720 │
│    5    │  'get BeltHashMap entry with id'  │ '3,223,648' │ 310.2074724295191  │ '±0.81%' │ 1611825 │
└─────────┴───────────────────────────────────┴─────────────┴────────────────────┴──────────┴─────────┘
```

## Notes

- The result of Belt's `Map` and `MutableMap` are almost same.
- The `Hashtbl.hash` provided by OCaml port works quite efficient.
- Assuming it's safe to use ReScript records as keys, JS's Map with `JSON.stringify` just work.

## LICENSE

MIT
