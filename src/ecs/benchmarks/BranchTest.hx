package ecs.benchmarks;

import ecx.ds.CArray;
import hxsuite.benchmarks.Benchmark;

@:iterations(1000)
@:runs(3)
class BranchTest extends Benchmark {

    var _array:CArray<Int> = new CArray(0xFFFF);
    var _boxArray:CArray<Null<Int>> = new CArray(0xFFFF);
    var _result:Int = 0;

    public function new() {
        super();

        for(i in 0..._array.length) {
            _array[i] = Std.int(1 + Math.random() * 100);
        }

        for(i in 0..._boxArray.length) {
            _boxArray[i] = Std.int(1 + Math.random() * 100);
        }
    }

    @:test
    public function if1() {
        var values = _array;
        var result = _result;
        @body {
            for(i in 0...values.length) {
                var x = values[i];
                if(x <= 128) {
                    result += x;
                }
            }
        }
        _result = result;
    }

    @:test
    public function if2() {
        var values = _array;
        var result = _result;
        @body {
            for(i in 0...values.length) {
                var x = values[i];
                if(x > 128) {
                    continue;
                }
                result += x;
            }
        }
        _result = result;
    }

    @:test
    public function null1() {
        var values = _boxArray;
        var result = _result;
        @body {
            for(i in 0...values.length) {
                result += doSome1(values[i]);
            }
        }
        _result = result;
    }

    @:test
    public function null2() {
        var values = _boxArray;
        var result = _result;
        @body {
            for(i in 0...values.length) {
                result += doSome2(values[i]);
            }
        }
        _result = result;
    }

    static function doSome1(x:Null<Int>):Int {
        if(x == null) {
            throw "ERROR";
        }
        return x >> 1;
    }

    static function doSome2(x:Null<Int>):Int {
        if(x != null) {
            return x >> 1;
        }
        throw "ERROR";
    }
}
