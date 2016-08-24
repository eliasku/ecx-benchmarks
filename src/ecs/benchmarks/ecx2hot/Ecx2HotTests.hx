package ecs.benchmarks.ecx2hot;

import hotmem.F32;
import ecs.benchmarks.ecx2hot.Ecx2HotPositionBase;
import hotmem.HotMemory;
import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class Ecx2HotTests {

    public var world:World;

    public var entities:CArray<Entity>;
    public var result:F32;
    public var count:Int;

    public var system:Ecx2HotSystem;
    var _pos1:Ecx2HotPosition1;
    var _pos2:Ecx2HotPosition2;
    var _pos3:Ecx2HotPosition3;
    var _pos4:Ecx2HotPosition4;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        var config = new WorldConfig();
        config.add(new Ecx2HotSystem());
        config.add(new Ecx2HotPosition1());
        config.add(new Ecx2HotPosition2());
        config.add(new Ecx2HotPosition3());
        config.add(new Ecx2HotPosition4());
        HotMemory.initialize(50);
        world = Engine.initialize().createWorld(config, count);

        system = world.resolve(Ecx2HotSystem);
        _pos1 = world.resolve(Ecx2HotPosition1);
        _pos2 = world.resolve(Ecx2HotPosition2);
        _pos3 = world.resolve(Ecx2HotPosition3);
        _pos4 = world.resolve(Ecx2HotPosition4);
    }

    public function setup() {
        entities = new CArray(count);

        for(i in 0...count) {
            var entity = world.create();
            entities[i] = entity;
        }

        for(entity in entities) {
            _pos1.randomize(entity);
            _pos3.randomize(entity);
            _pos4.randomize(entity);
            world.commit(entity);
        }

        world.invalidate();

        if(entities.length == 0) {
            throw "ECX list is empty";
        }
    }

    public function update() {
        var result:Float = this.result;
        var entities = system.entities;
        var x1 = _pos1.x;
        var y1 = _pos1.y;
        var x2 = _pos2.x;
        var y2 = _pos2.y;
        var x3 = _pos3.x;
        var y3 = _pos3.y;
        var x4 = _pos4.x;
        var y4 = _pos4.y;

        for(entity in entities) {
            var c = entity.id;
            result += x1[c] + y1[c];
            if(entity.isInvalid) {
                /** Just to ignore **/
                result += x2[c] + y2[c];
            }
            result += x3[c] + y3[c];
            result += x4[c] + y4[c];
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