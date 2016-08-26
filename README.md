# ecx-benchmarks

Benchmarks for [ECX library](https://github.com/eliasku/ecx)

## Results

[View ECX report](https://eliasku.github.io/ecx2.html)

[View ECX comparison](https://eliasku.github.io/ecx2_versus.html)

[Legacy v0.0.4 results](https://eliasku.github.io/ecx_benchmarks.html) - should be updated to `ecx0.0.5`

- *1 operation* is to process 1000 entities to calculate pairs sum from 3 components `p1.x + p1.y + p3.x + p3.y + p4.x + p4.y` and branch optional `p2` component

Current results environment:
```
MacBook Pro (OSX 10.11.5)
Intel Core i7 (2.8 GHz, 4 Cores)
L2 Cache: 256 KB
L3 Cache:	6 MB
Memory:	16 GB

haxe: 3.3.0rc1
swf/js: Google Chrome 52.0.2743.116 (64-bit)
node: v6.2.2
java: v1.8.0_92
cs: Mono v4.4.0
```

## How to run

1. Install https://github.com/eliasku/hxmake
2. Install https://github.com/eliasku/hxsuite
3. Require to install for `_hot` cases https://github.com/eliasku/hotmem

For the first time try just run a couple of targets and apps
```
(haxelib run )hxmake run -app=ash -target=node
```
Apps:

- ecx
- ecx_hot
- pure
- pure_hot
- ash
- hxe
- edge
- eskimo (dropped from report)
- seagal (dropped from report)

Targets:
- java
- cs
- node
- js
- swf
- cpp
