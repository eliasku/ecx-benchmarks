package ecs.benchmarks;

import hxsuite.benchmarks.Benchmark;

#if ((app=='ecx') || (app=='ecx_view'))
typedef TestLibrary = ecs.benchmarks.ecx.EcxTests;
#elseif (app=='ash')
typedef TestLibrary = ecs.benchmarks.ash.AshTests;
#elseif (app=='eskimo')
typedef TestLibrary = ecs.benchmarks.eskimo.EskimoTests;
#elseif (app=='hxe')
typedef TestLibrary = ecs.benchmarks.hxe.HxeTests;
#elseif (app=='edge')
typedef TestLibrary = ecs.benchmarks.edge.EdgeTests;
#elseif (app=='pure')
typedef TestLibrary = ecs.benchmarks.pure.PureTests;
#end

#if (app=='eskimo')
@:iterations(100)
@:runs(1)
#else
@:iterations(2000)
@:runs(3)
#end

class EcsTest extends Benchmark {

    var _result:Float = 0;
    var _lib:TestLibrary;

    public function new() {
        super();
        _lib = new TestLibrary(1000);
    }

    @:test
    public function iteration() {
        _lib.setup();
        @body {
            #if (app=='ecx_view')
            _lib.updateView();
            #else
            _lib.update();
            #end
        }
        _result = _lib.result;
        if(_result == 0) {
            throw "Bad result";
        }
        _lib.dispose();
    }

    override function onTestCompleted() {
        trace(_result);
    }
}