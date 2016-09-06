package ecs.benchmarks.ecx_hot;

import hotmem.F32;
import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class EcxHotTests {

    public var world:World;

    public var entities:CArray<Entity>;
    public var result:F32;
    public var count:Int;

    public var system:EcxHotSystem;
    var _pos1:EcxHotPosition1;
    var _pos2:EcxHotPosition2;
    var _pos3:EcxHotPosition3;
    var _pos4:EcxHotPosition4;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);

        var config = new WorldConfig();
        config.add(new EcxHotSystem());
        config.add(new EcxHotPosition1());
        config.add(new EcxHotPosition2());
        config.add(new EcxHotPosition3());
        config.add(new EcxHotPosition4());
        world = Engine.createWorld(config, count);

        system = world.resolve(EcxHotSystem);
        _pos1 = world.resolve(EcxHotPosition1);
        _pos2 = world.resolve(EcxHotPosition2);
        _pos3 = world.resolve(EcxHotPosition3);
        _pos4 = world.resolve(EcxHotPosition4);
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