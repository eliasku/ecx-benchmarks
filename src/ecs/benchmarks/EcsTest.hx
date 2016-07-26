package ecs.benchmarks;

import ecs.benchmarks.ecx.EcxTests;
import ecs.benchmarks.edge.EdgeTests;
import ecs.benchmarks.hxe.HxeTests;
import ecs.benchmarks.ash.AshTests;

import hxsuite.benchmarks.Benchmark;

@:iterations(1000)
@:runs(3)
class EcsTest extends Benchmark {

    var _result:Float = 0;

    var _ecx:EcxTests;
    var _ash:AshTests;
    var _hxe:HxeTests;
    var _edge:EdgeTests;

    public function new() {
        super();

        _ecx = new EcxTests();
        _ash = new AshTests();
        _hxe = new HxeTests();
        _edge = new EdgeTests();
    }

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

    @:test
    public function ecx_map_to() {

        _ecx.setup();
        @body {
            _ecx.updateWithMapping();
        }
        _result = _ecx.result;
        if(_result == 0) {
            throw "ECX bad result";
        }
        _ecx.dispose();
    }

    @:test
    public function ecx_map_to_field_access() {

        _ecx.setup();
        @body {
            _ecx.updateWithMappingFA();
        }
        _result = _ecx.result;
        if(_result == 0) {
            throw "ECX bad result";
        }
        _ecx.dispose();
    }

    override function onTestCompleted() {
        trace(_result);
    }
}