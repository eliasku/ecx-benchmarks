package ecs.benchmarks.ecx_hot2;

import hotmem.F32;
import hotmem.HotMemory;
import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class EcxHot2Tests {

    public var world:World;

    public var entities:CArray<Entity>;
    public var result:F32;
    public var count:Int;

    var _positionStorage:EcxHot2PositionsStorage;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        var config = new WorldConfig();
        config.add(new EcxHot2PositionsStorage());
        HotMemory.initialize(50);
        world = Engine.initialize().createWorld(config, count);

        _positionStorage = world.resolve(EcxHot2PositionsStorage);
    }

    public function setup() {
        entities = new CArray(count);

        for(i in 0...count) {
            var entity = world.create();
            entities[i] = entity;
        }

        for(entity in entities) {
            _positionStorage.randomize1(entity);
            _positionStorage.randomize3(entity);
            _positionStorage.randomize4(entity);
        }

        world.invalidate();

        if(entities.length == 0) {
            throw "ECX list is empty";
        }
    }

    public function update() {
        var result:Float = this.result;

//        for(entity in entities) {
//            var c1 = _positionStorage.position1(entity);
//            result += c1.x + c1.y;
//
//            var c2 = _positionStorage.position2(entity);
//            //if(c2 != null /** OPTIONAL **/) {
//               // result += c2.x + c2.y;
//            //}
//
//            var c3 = _positionStorage.position3(entity);
//            result += c3.x + c3.y;
//
//            var c4 = _positionStorage.position4(entity);
//            result += c4.x + c4.y;
//        }

        var p1_x = _positionStorage._position1_x;
        var p1_y = _positionStorage._position1_y;
        var p2_x = _positionStorage._position2_x;
        var p2_y = _positionStorage._position2_y;
        var p3_x = _positionStorage._position3_x;
        var p3_y = _positionStorage._position3_y;
        var p4_x = _positionStorage._position4_x;
        var p4_y = _positionStorage._position4_y;

        for(entity in entities) {
            var ptr = entity.id;
            result += p1_x[ptr] + p1_y[ptr];
            if(entity.isInvalid) {
                /** Just to ignore **/
                result += p2_x[ptr] + p2_y[ptr];
            }
            result += p3_x[ptr] + p3_y[ptr];
            result += p4_x[ptr] + p4_y[ptr];
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