package ecs.benchmarks.ecx;

import ecx.ds.CArray;
import ecx.Entity;
import ecx.EntityView;
import ecx.MapTo;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class EcxTests {

    public var world:World;

    // TODO: use Family<>
    public var entities:CArray<Entity>;
    public var views:CArray<EntityView>;
    public var result:Float;
    public var count:Int;

    var _pos1:MapTo<EcxPosition1>;
    var _pos2:MapTo<EcxPosition2>;
    var _pos3:MapTo<EcxPosition3>;
    var _pos4:MapTo<EcxPosition4>;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        world = Engine.initialize().createWorld(new WorldConfig([]), 0x800);
        _pos1 = world.mapTo(EcxPosition1);
        _pos2 = world.mapTo(EcxPosition2);
        _pos3 = world.mapTo(EcxPosition3);
        _pos4 = world.mapTo(EcxPosition4);
    }

    public function setup() {
        entities = new CArray(count);
        views = new CArray(count);

        for(i in 0...count) {
            var entity = world.create();
            entities[i] = entity;
            views[i] = world.edit(entity);
        }

        for(i in 0...count) {
            views[i].create(EcxPosition1).randomize();
        }

        for(i in 0...count) {
            views[i].create(EcxPosition3).randomize();
        }

        for(i in 0...count) {
            views[i].create(EcxPosition4).randomize();
        }

        world.invalidate();

        if(entities.length == 0) {
            throw "ECX list is empty";
        }
    }

    public function updateView() {
        var result:Float = this.result;
        var entities = this.views;

        for(i in 0...entities.length) {
            var e:EntityView = entities[i];
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
        var entities = this.entities;

        var pos1:MapTo<EcxPosition1> = _pos1;
        var pos2:MapTo<EcxPosition2> = _pos2;
        var pos3:MapTo<EcxPosition3> = _pos3;
        var pos4:MapTo<EcxPosition4> = _pos4;
        @body {
            for(i in 0...entities.length) {
                var entity = entities[i];
                var c1 = pos1.get(entity);
                if(c1 != null) {
                    result += c1.x + c1.y;
                }
                var c2 = pos2.get(entity);
                if(c2 != null) {
                    result += c2.x + c2.y;
                }
                var c3 = pos3.get(entity);
                if(c3 != null) {
                    result += c3.x + c3.y;
                }
                var c4 = pos4.get(entity);
                if(c4 != null) {
                    result += c4.x + c4.y;
                }
            }
        }

        this.result = result;
    }

//    public function updateFA() {
//        var result:Float = this.result;
//        var entities = this.entities;
//
//        @body {
//            for(i in 0...entities.length) {
//                var entity = entities[i];
//                var c1 = _pos1.get(entity);
//                if(c1 != null) {
//                    result += c1.x + c1.y;
//                }
//                var c2 = _pos2.get(entity);
//                if(c2 != null) {
//                    result += c2.x + c2.y;
//                }
//                var c3 = _pos3.get(entity);
//                if(c3 != null) {
//                    result += c3.x + c3.y;
//                }
//                var c4 = _pos4.get(entity);
//                if(c4 != null) {
//                    result += c4.x + c4.y;
//                }
//            }
//        }
//
//        this.result = result;
//    }

    public function dispose() {
        for(i in 0...entities.length) {
            world.delete(entities[i]);
        }
        world.invalidate();
    }

}