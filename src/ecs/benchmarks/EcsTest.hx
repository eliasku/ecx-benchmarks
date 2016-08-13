package ecs.benchmarks;

import ecs.benchmarks.pure.PureTests;
import ecs.benchmarks.ecx.EcxTests;
import ecs.benchmarks.edge.EdgeTests;
import ecs.benchmarks.hxe.HxeTests;
import ecs.benchmarks.ash.AshTests;

import hxsuite.benchmarks.Benchmark;

@:iterations(2000)
@:runs(3)
class EcsTest extends Benchmark {

    var _result:Float = 0;

#if ((testid=='ecx') || (testid=='ecx_view'))
    var _ecx:EcxTests;
    #elseif (testid=='ash')
    var _ash:AshTests;
    #elseif (testid=='hxe')
    var _hxe:HxeTests;
    #elseif (testid=='edge')
    var _edge:EdgeTests;
    #elseif (testid=='pure')
    var _pure:PureTests;
    #end

    public function new() {
        super();
        var count = 1000;
        #if ((testid=='ecx') || (testid=='ecx_view'))
        _ecx = new EcxTests(count);
        #elseif (testid=='ash')
        _ash = new AshTests(count);
        #elseif (testid=='hxe')
        _hxe = new HxeTests(count);
        #elseif (testid=='edge')
        _edge = new EdgeTests(count);
        #elseif (testid=='pure')
        _pure = new PureTests(count);
        #end
    }

    #if (testid=='ecx_view')
    @:test
    public function ecx_view() {
        _ecx.setup();
        @body {
            _ecx.updateView();
        }
        _result = _ecx.result;
        if(_result == 0) {
            throw "ECX bad result";
        }
        _ecx.dispose();
    }
    #elseif (testid=='ecx')
    @:test
    public function ecx() {

        _ecx.setup();
        @body {
            _ecx.update();
        }
        _result = _ecx.result;
        if(_result == 0) {
            throw "ECX bad result";
        }
        _ecx.dispose();
    }
    #elseif (testid=='ash')
    @:test
    public function ash() {
        _ash.setup();
        @body {
            _ash.update();
        }
        _result = _ash.result;
        if(_result == 0) {
            throw "ASH bad result";
        }
        _ash.dispose();
    }
    #elseif (testid=='hxe')
    @:test
    public function hxe() {
        _hxe.setup();
        @body {
            _hxe.update();
        }
        _result = _hxe.result;
        if(_result == 0) {
            throw "hxE bad result";
        }
        _hxe.dispose();
    }
    #elseif (testid=='edge')
    @:test
    public function edge() {
        _edge.setup();
        @body {
            _edge.update();
        }
        _result = _edge.result;
        if(_result == 0) {
            throw "EDGE bad result";
        }
        _edge.dispose();
    }
    #elseif (testid=='pure')
    @:test
    public function pure() {
        _pure.setup();
        @body {
            _pure.update();
        }
        _result = _pure.result;
        if(_result == 0) {
            throw "PURE bad result";
        }
        _pure.dispose();
    }
    #end

    override function onTestCompleted() {
        trace(_result);
    }
}