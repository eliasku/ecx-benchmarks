package ecs.benchmarks.eskimo;

import eskimo.Entity;
import eskimo.views.View;
import eskimo.EntityManager;
import eskimo.ComponentManager;

class EskimoTests {

    // world
    var _cm:ComponentManager;
    var _em:EntityManager;

    public var entities:Array<Entity>;
    public var result:Float;
    public var count:Int;

    var _view:View;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);

        _cm = new ComponentManager();
        _em = new EntityManager(_cm);
        _view = new View([
            EskimoPosition1,
                /** optional **/ //EskimoPosition2,
            EskimoPosition3,
            EskimoPosition4
        ], _em);
    }

    public function setup() {
        entities = [];
        for(i in 0...count) {
            var e = _em.create();
            e.set(new EskimoPosition1().randomize());
            e.set(new EskimoPosition3().randomize());
            e.set(new EskimoPosition4().randomize());
            entities.push(e);
        }
        if(_em.entities.length == 0) {
            throw "Eskimo is empty";
        }
    }

    public function update() {
        var result:Float = this.result;
        var view = _view;

        for(entity in view.entities) {
            var c1:EskimoPosition1 = entity.get(EskimoPosition1);
            result += c1.x + c1.y;

            var c2:EskimoPosition2 = entity.get(EskimoPosition2);
            if(c2 != null) {
                result += c2.x + c2.y;
            }

            var c3:EskimoPosition3 = entity.get(EskimoPosition3);
            result += c3.x + c3.y;

            var c4:EskimoPosition4 = entity.get(EskimoPosition4);
            result += c4.x + c4.y;
        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            _em.destroy(entities[i]);
        }
    }
}