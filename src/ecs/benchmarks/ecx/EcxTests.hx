package ecs.benchmarks.ecx;

import ecx.MapTo;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.Entity;
import ecx.World;

class EcxTests {

    public var world:World;
    public var entities:Array<Entity>;
    public var eids:Array<Int>;
    public var result:Float;

    var _pos1:MapTo<EcxPosition1>;
    var _pos2:MapTo<EcxPosition2>;
    var _pos3:MapTo<EcxPosition3>;
    var _pos4:MapTo<EcxPosition4>;

    public function new() {
        result = Std.int(Math.random() * 200);
        world = Engine.initialize(0x800).createWorld(new WorldConfig([]));
        _pos1 = world.engine.mapTo(EcxPosition1);
        _pos2 = world.engine.mapTo(EcxPosition2);
        _pos3 = world.engine.mapTo(EcxPosition3);
        _pos4 = world.engine.mapTo(EcxPosition4);
    }

    public function setup() {
        entities = [];
        eids = [];

//        for(i in 0...1000) {
//            var e = world.create();
//            e.create(EcxPosition1).randomize();
//            e.create(EcxPosition3).randomize();
//            e.create(EcxPosition4).randomize();
//            entities.push(e);
//            eids.push(e.id);
//        }
        for(i in 0...1000) {
            var e = world.create();
            entities.push(e);
            eids.push(e.id);
        }
        for(i in 0...1000) {
            var e = entities[i];
            e.create(EcxPosition1).randomize();
        }

        for(i in 0...1000) {
            var e = entities[i];
            e.create(EcxPosition3).randomize();
        }

        for(i in 0...1000) {
            var e = entities[i];
            e.create(EcxPosition4).randomize();
        }

        world.invalidate();

//        trace("+++++++++++");
//        for(eid in eids) {
//            trace(eid);
//        }

        if(entities.length == 0) {
            throw "ECX list is empty";
        }
    }

    public function updateRef() {
        var result:Float = this.result;
        var entities = this.entities;

        for(i in 0...entities.length) {
            var e = entities[i];
            var c1:EcxPosition1 = e.get(EcxPosition1);
            if(c1 != null) {
                result += c1.x + c1.y;
            }
            var c2:EcxPosition2 = e.get(EcxPosition2);
            if(c2 != null) {
                result += c2.x + c2.y;
            }
            var c3:EcxPosition3 = e.get(EcxPosition3);
            if(c3 != null) {
                result += c3.x + c3.y;
            }
            var c4:EcxPosition4 = e.get(EcxPosition4);
            if(c4 != null) {
                result += c4.x + c4.y;
            }
        }

        this.result = result;
    }

    public function update() {
        var result:Float = this.result;
        var eids = this.eids;

        var pos1:MapTo<EcxPosition1> = _pos1;
        var pos2:MapTo<EcxPosition2> = _pos2;
        var pos3:MapTo<EcxPosition3> = _pos3;
        var pos4:MapTo<EcxPosition4> = _pos4;
        var result:Float = 0;
        @body {
            for(i in 0...eids.length) {
                var eid:Int = eids[i];
                var c1 = pos1.getFast(eid);
                if(c1 != null) {
                    result += c1.x + c1.y;
                }
                var c2 = pos2.getFast(eid);
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3 = pos3.getFast(eid);
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4 = pos4.getFast(eid);
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        this.result = result;
    }

    public function updateFA() {
        var result:Float = this.result;
        var eids = this.eids;
        var result:Float = 0;

        @body {
            for(i in 0...eids.length) {
                var eid:Int = eids[i];
                var c1 = _pos1[eid];
                if(c1 != null) {
                    result += c1.x + c1.y;
                }
                var c2 = _pos2[eid];
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3 = _pos3[eid];
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4 = _pos4[eid];
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            world.delete(entities[i]);
        }
        world.invalidate();
    }

}