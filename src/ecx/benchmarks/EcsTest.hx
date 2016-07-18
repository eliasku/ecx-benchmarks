package ecx.benchmarks;

import ecx.benchmarks.EdgeComponents.EdgeSystem;
import ecx.benchmarks.EdgeComponents;
import ecx.benchmarks.EcxComponents;
import ecx.benchmarks.HxeComponents;
import ecx.benchmarks.AshComponents;

import ecx.Engine in Ecx;
import ecx.MapTo;

import hxE.ComponentTypeSlot;
import hxE.EntityWorld;

import ash.core.Engine in AshEngine;
import ash.core.NodeList;

import hxsuite.benchmarks.Benchmark;

@:iterations(1000)
@:runs(3)
class EcsTest extends Benchmark {

    var _ecx:ecx.World;
    var _ash:AshEngine;
    var _hxe:EntityWorld;
    var _edge:edge.World;

    var _result:Float = 0;

    var _pos1:MapTo<EcxPosition>;
    var _pos2:MapTo<EcxPosition2>;
    var _pos3:MapTo<EcxPosition3>;
    var _pos4:MapTo<EcxPosition4>;

    var _hxe1:ComponentTypeSlot<HxePosition>;
    var _hxe2:ComponentTypeSlot<HxePosition2>;
    var _hxe3:ComponentTypeSlot<HxePosition3>;
    var _hxe4:ComponentTypeSlot<HxePosition4>;

    var _edgeSystem:EdgeSystem;

    var _ashNode:NodeList<AshNode>;

    public function new() {
        super();

        _ecx = Ecx.create(new ecx.WorldConfig([]));
        _ash = new AshEngine();
        _edge = new edge.World();
        _edgeSystem = new EdgeSystem();
        _edge.render.add(_edgeSystem);
        //_edge.start();

        _pos1 = _ecx.database.mapTo(EcxPosition);
        _pos2 = _ecx.database.mapTo(EcxPosition2);
        _pos3 = _ecx.database.mapTo(EcxPosition3);
        _pos4 = _ecx.database.mapTo(EcxPosition4);

        _ashNode = _ash.getNodeList(AshNode);

        _hxe = new EntityWorld();
        _hxe1 = new ComponentTypeSlot(HxePosition);
        _hxe2 = new ComponentTypeSlot(HxePosition2);
        _hxe3 = new ComponentTypeSlot(HxePosition3);
        _hxe4 = new ComponentTypeSlot(HxePosition4);
        _hxe1.setWorld(_hxe);
        _hxe2.setWorld(_hxe);
        _hxe3.setWorld(_hxe);
        _hxe4.setWorld(_hxe);
    }

    @:test
    public function ash() {
        var entities:Array<ash.core.Entity> = [];
        for(i in 0...1000) {
            var e = new ash.core.Entity()
                .add(new AshPosition().randomize())
                .add(new AshPosition2().randomize()) // ash dont support optional components?
                .add(new AshPosition3().randomize())
                .add(new AshPosition4().randomize());
            _ash.addEntity(e);
            entities.push(e);
        }
        _ash.update(0.0001);
        var result:Float = 0;
        var ashNodes:NodeList<AshNode> = _ashNode;
        @body {
            if(ashNodes.empty) {
                throw "EMPTY";
            }
            for(n in ashNodes) {
                result += n.p1.x + n.p1.y;
                result += n.p2.x + n.p2.y;
                result += n.p3.x + n.p3.y;
                result += n.p4.x + n.p4.y;
            }
        }

        for(i in 0...entities.length) {
            var e:ash.core.Entity = entities[i];
            _ash.removeEntity(e);
        }

        _ash.update(0.0001);
        //trace("EC: " + @:privateAccess _ash.total);
        if(result < 0) {
            throw "BAD";
        }
        _result = result;
    }

    @:test
    public function hxe() {
        var entities:Array<hxE.Entity> = [];
        for(i in 0...1000) {
            var e = _hxe.create();
            e.addComponent(new HxePosition().randomize());
            e.addComponent(new HxePosition3().randomize());
            e.addComponent(new HxePosition4().randomize());
            e.update();
            entities.push(e);
        }

        //_hxe.update.update(0.0001);
        var result:Float = 0;
        var hxe1 = _hxe1;
        var hxe2 = _hxe2;
        var hxe3 = _hxe3;
        var hxe4 = _hxe4;
        @body {
            if(entities.length == 0) {
                throw "EMPTY";
            }
            for(e in entities) {
                var c:HxePosition = hxe1.get(e);
                if(c != null) {
                    result += c.x + c.y;
                }
                var c2:HxePosition2 = hxe2.get(e);
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3:HxePosition3 = hxe3.get(e);
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4:HxePosition4 = hxe4.get(e);
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        for(i in 0...entities.length) {
            var e = entities[i];
            _hxe.destroyEntity(e);
        }

        //_ash.update(0.0001);
        //trace("EC: " + @:privateAccess _ash.total);
        if(result < 0) {
            throw "BAD";
        }
        _result = result;
    }

    @:test
    public function edge() {
        var entities:Array<edge.Entity> = [];
        for(i in 0...1000) {
            var e = _edge.engine.create([
                EdgePosition.random(),
                EdgePosition2.random(),
                EdgePosition3.random(),
                EdgePosition4.random()
            ]);
            entities.push(e);
        }
        var result:Float = 0;
        @body {
            if(entities.length == 0) {
                throw "EMPTY";
            }
            for(e in _edgeSystem.view) {
                var data = e.data;
                result += data.p1.x + data.p1.y;
                result += data.p2.x + data.p2.y;
                result += data.p3.x + data.p3.y;
                result += data.p4.x + data.p4.y;
            }
        }

        for(i in 0...entities.length) {
            var e = entities[i];
            e.destroy();
        }

        //_ash.update(0.0001);
        //trace("EC: " + @:privateAccess _ash.total);
        if(result < 0) {
            throw "BAD";
        }
        _result = result;
    }

    @:test
    public function ecx() {
        var entities:Array<ecx.Entity> = [];
        for(i in 0...1000) {
            var e = _ecx.create();
            e.create(EcxPosition).randomize();
            e.create(EcxPosition3).randomize();
            e.create(EcxPosition4).randomize();
            entities.push(e);
        }
        _ecx.invalidate();
        var result:Float = 0;
        @body {
            for(i in 0...entities.length) {
                var e:ecx.Entity = entities[i];
                var c:EcxPosition = e.get(EcxPosition);
                if(c != null) {
                    result += c.x + c.y;
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
        }

        for(i in 0...entities.length) {
            var e:ecx.Entity = entities[i];
            _ecx.delete(e);
        }

        _ecx.invalidate();

        trace("EC: " + @:privateAccess _ecx._entities.length);
        if(result < 0) {

            throw "BAD";
        }
        _result = result;
    }

    @:test
    public function ecx_map_fast() {
        var entities:Array<Int> = [];
        for(i in 0...1000) {
            var e = _ecx.create();
            e.create(EcxPosition).randomize();
            e.create(EcxPosition3).randomize();
            e.create(EcxPosition4).randomize();
            entities.push(e.id);
        }
        _ecx.invalidate();

        var pos1:MapTo<EcxPosition> = _ecx.database.mapTo(EcxPosition);
        var pos2:MapTo<EcxPosition2> = _ecx.database.mapTo(EcxPosition2);
        var pos3:MapTo<EcxPosition3> = _ecx.database.mapTo(EcxPosition3);
        var pos4:MapTo<EcxPosition4> = _ecx.database.mapTo(EcxPosition4);
        var result:Float = 0;
        @body {
            for(i in 0...entities.length) {
                var e:Int = entities[i];
                var c = pos1.getFast(e);
                if(c != null) {
                    result += c.x + c.y;
                }
                var c2 = pos2.getFast(e);
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3 = pos3.getFast(e);
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4 = pos4.getFast(e);
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        for(i in 0...entities.length) {
            var e:Int = entities[i];
            _ecx.delete(_ecx.database.entities[e]);
        }

        _ecx.invalidate();

        trace("EC: " + @:privateAccess _ecx._entities.length);
        if(result < 0) {

            throw "BAD";
        }
        _result = result;
    }

    @:test
    public function ecx_map_test() {
        var entities:Array<Int> = [];
        for(i in 0...1000) {
            var e = _ecx.create();
            e.create(EcxPosition).randomize();
            e.create(EcxPosition3).randomize();
            e.create(EcxPosition4).randomize();
            entities.push(e.id);
        }
        _ecx.invalidate();


        var result:Float = 0;
        @body {
            for(i in 0...entities.length) {
                var e:Int = entities[i];
                var c = _pos1.getFast(e);
                if(c != null) {
                    result += c.x + c.y;
                }
                var c2 = _pos2.getFast(e);
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3 = _pos3.getFast(e);
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4 = _pos4.getFast(e);
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        for(i in 0...entities.length) {
            var e:Int = entities[i];
            _ecx.delete(_ecx.database.entities[e]);
        }

        _ecx.invalidate();

        trace("EC: " + @:privateAccess _ecx._entities.length);
        if(result < 0) {

            throw "BAD";
        }
        _result = result;
    }

    override function onTestCompleted() {
        trace(_result);
    }
}