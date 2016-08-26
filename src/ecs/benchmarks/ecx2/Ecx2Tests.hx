package ecs.benchmarks.ecx2;

import ecx.ds.CArray;
import ecx.Entity;
import ecx.WorldConfig;
import ecx.Engine;
import ecx.World;

class Ecx2Tests {

    public var world:World;

    public var entities:CArray<Entity>;

    public var result:Float;
    public var count:Int;

    var _system:Ecx2System;

    var _pos1:Ecx2Position1;
    var _pos2:Ecx2Position2;
    var _pos3:Ecx2Position3;
    var _pos4:Ecx2Position4;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        var config = new WorldConfig();
        config.add(new Ecx2System());
        config.add(new Ecx2Position1());
        config.add(new Ecx2Position2());
        config.add(new Ecx2Position3());
        config.add(new Ecx2Position4());
        world = Engine.initialize().createWorld(config, count);
        _system = world.resolve(Ecx2System);
        _pos1 = world.resolve(Ecx2Position1);
        _pos2 = world.resolve(Ecx2Position2);
        _pos3 = world.resolve(Ecx2Position3);
        _pos4 = world.resolve(Ecx2Position4);
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