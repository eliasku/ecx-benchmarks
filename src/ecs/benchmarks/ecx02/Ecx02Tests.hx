package ecs.benchmarks.ecx02;

import hotmem.F32;
import hotmem.HotMemory;
import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class Ecx02Tests {

    public var world:World;

    public var entities:CArray<Entity>;
    public var result:F32;
    public var count:Int;

    var _positionStorage:EcxPositionsStorage;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        var config = new WorldConfig();
        config.add(new EcxPositionsStorage());
        HotMemory.initialize(50);
        world = Engine.initialize().createWorld(config, count);

        _positionStorage = world.resolve(EcxPositionsStorage);
    }

    public function setup() {
        entities = new CArray(count);

        for(i in 0...count) {
            var entity = world.create();
            entities[i] = entity;
        }

        for(entity in entities) {
            _positionStorage.position1(entity).randomize();
            _positionStorage.position3(entity).randomize();
            _positionStorage.position4(entity).randomize();
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

        var p1 = _positionStorage._position1;
        var p2 = _positionStorage._position2;
        var p3 = _positionStorage._position3;
        var p4 = _positionStorage._position4;

        for(entity in entities) {
            var c = entity.id << 1;
            result += p1[c] + p1[c + 1];
            if(entity.isInvalid) {
                /** Just to ignore **/
                result += p2[c] + p2[c + 1];
            }
            result += p3[c] + p3[c + 1];
            result += p4[c] + p4[c + 1];
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