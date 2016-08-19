# ecx-benchmarks

Benchmarks for [ECX library](https://github.com/eliasku/ecx)

## Results
[View results](https://eliasku.github.io/ecx_benchmarks.html)

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

*NOTICE: Currently written only for running on Mac, Windows will be added soon!*

1. Install https://github.com/eliasku/hxmake
2. Install https://github.com/eliasku/hxsuite

For the first time try just run a couple of targets and apps
```
hxmake run -app=ash -target=node
```
Apps:
- ash
- ecx
- ecx_view
- hxe
- eskimo
- edge
- pure

Targets:
- java
- cs
- node
- js
- swf
- cpp
