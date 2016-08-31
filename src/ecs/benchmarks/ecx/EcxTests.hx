package ecs.benchmarks.ecx;

import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class EcxTests {

    public var world:World;

    public var entities:CArray<Entity>;

    public var result:Float;
    public var count:Int;

    var _system:EcxSystem;

    var _pos1:EcxPosition1;
    var _pos2:EcxPosition2;
    var _pos3:EcxPosition3;
    var _pos4:EcxPosition4;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        var config = new WorldConfig();
        config.add(new EcxSystem());
        config.add(new EcxPosition1());
        config.add(new EcxPosition2());
        config.add(new EcxPosition3());
        config.add(new EcxPosition4());
        world = Engine.createWorld(config, count);
        _system = world.resolve(EcxSystem);
        _pos1 = world.resolve(EcxPosition1);
        _pos2 = world.resolve(EcxPosition2);
        _pos3 = world.resolve(EcxPosition3);
        _pos4 = world.resolve(EcxPosition4);
    }

    public function setup() {
        entities = new CArray(count);

        for(i in 0...count) {
            entities[i] = world.create();
        }

        for(entity in entities) {
            _pos1.randomize(entity);
        }

        for(entity in entities) {
            _pos3.randomize(entity);
        }

        for(entity in entities) {
            _pos4.randomize(entity);
        }

        for(entity in entities) {
            world.commit(entity);
        }

        world.invalidate();

        if(entities.length == 0) {
            throw "ECX list is empty";
        }
    }

    public function update() {
        var result:Float = this.result;
        var entities = _system.entities;

        var pos1 = _pos1.data;
        var pos2 = _pos2.data;
        var pos3 = _pos3.data;
        var pos4 = _pos4.data;

        for(entity in entities) {
            var c1 = pos1[entity.id];
            result += c1.x + c1.y;

            var c2 = pos2[entity.id];
            if(c2 != null /** OPTIONAL **/) {
                result += c2.x + c2.y;
            }

            var c3 = pos3[entity.id];
            result += c3.x + c3.y;

            var c4 = pos4[entity.id];
            result += c4.x + c4.y;
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