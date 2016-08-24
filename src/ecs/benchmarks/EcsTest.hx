package ecs.benchmarks;

import hxsuite.benchmarks.Benchmark;

// STABLE ECX
#if ((app=='ecx') || (app=='ecx_view'))
typedef TestLibrary = ecs.benchmarks.ecx.EcxTests;

// HOT ECX
#elseif (app=='ecx02')
typedef TestLibrary = ecs.benchmarks.ecx02.Ecx02Tests;
#elseif (app=='ecx04')
typedef TestLibrary = ecs.benchmarks.ecx04.Ecx04Tests;

// NEW ECX 0.2.0
#elseif (app=='ecx2')
typedef TestLibrary = ecs.benchmarks.ecx2.Ecx2Tests;
#elseif (app=='ecx2hot')
typedef TestLibrary = ecs.benchmarks.ecx2hot.Ecx2HotTests;

#elseif (app=='ash')
typedef TestLibrary = ecs.benchmarks.ash.AshTests;
#elseif (app=='eskimo')
typedef TestLibrary = ecs.benchmarks.eskimo.EskimoTests;
#elseif (app=='hxe')
typedef TestLibrary = ecs.benchmarks.hxe.HxeTests;
#elseif (app=='edge')
typedef TestLibrary = ecs.benchmarks.edge.EdgeTests;
#elseif (app=='seagal')
typedef TestLibrary = ecs.benchmarks.seagal.SeagalTests;
#elseif (app=='pure')
typedef TestLibrary = ecs.benchmarks.pure.PureTests;
#end

#if ((app=='eskimo') || (app=='seagal'))
@:iterations(100)
@:runs(1)
#else
@:iterations(2000)
@:runs(15)
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