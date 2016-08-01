package ecs.benchmarks;

import cpp.Float32;
import ecx.ds.CArray;
import hxsuite.benchmarks.Benchmark;

@:iterations(10)
@:runs(3)
class F32Test extends Benchmark {

    var _t32:CArray<T32> = new CArray(0xFFFF);
    var _t64:CArray<T64> = new CArray(0xFFFF);
    var _result:Float32 = 0;

    public function new() {
        super();

        for(i in 0..._t32.length) {
            _t32[i] = new T32();
        }

        for(i in 0..._t64.length) {
            _t64[i] = new T64();
        }
    }

    @:test
    public function f32() {
        var values = _t32;
        var result:Float32 = _result;
        @body {
            for(i in 0...values.length) {
                var value:T32 = _t32[i];
                result += value.a;
                result += value.b;
                result += value.c;
                result += value.d;
                result += value.x;
                result += value.y;
            }
        }
        _result = result;
    }

    @:test
    public function f64() {
        var values = _t64;
        var result:Float = _result;
        @body {
            for(i in 0...values.length) {
                var value:T64 = _t64[i];
                result += value.a;
                result += value.b;
                result += value.c;
                result += value.d;
                result += value.x;
                result += value.y;
            }
        }
        _result = result;
    }
}

@:unreflective
@:final
class T64 {

    public var a:Float = 1;
    public var b:Float = 0;
    public var c:Float = 0;
    public var d:Float = 1;
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {

    }
}

@:unreflective
@:final
class T32 {
    public var a:Float32 = 1;
    public var b:Float32 = 0;
    public var c:Float32 = 0;
    public var d:Float32 = 1;
    public var x:Float32 = 0;
    public var y:Float32 = 0;

    public function new() {

    }
}