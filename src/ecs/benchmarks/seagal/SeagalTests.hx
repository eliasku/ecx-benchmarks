package ecs.benchmarks.seagal;

import se.salomonsson.seagal.core.EW;
import se.salomonsson.seagal.core.EntityManager;
import se.salomonsson.seagal.core.Core;

class SeagalTests {

    public var result:Float;
    public var count:Int;

    var _entities:Array<EW>;

    var _core:Core;
    var _em:EntityManager;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);

        _core = new Core();
        _em = _core.getEntManager();
    }

    public function setup() {
        for(i in 0...count) {
            var ew = _em.allocateEntity();
            ew.addComponent(new SeagalPosition1().randomize());
            ew.addComponent(new SeagalPosition3().randomize());
            ew.addComponent(new SeagalPosition4().randomize());
        }

        _entities = _em.getEWC([SeagalPosition1, SeagalPosition3, SeagalPosition4]);
    }

    public function update() {
        var result:Float = this.result;
        var entities = _entities;

        for(ew in entities) {
            var c1 = ew.getComponent(SeagalPosition1);
            result += c1.x + c1.y;

            var c2 = ew.getComponent(SeagalPosition2);
            if(c2 != null) {
                result += c2.x + c2.y;
            }

            var c3 = ew.getComponent(SeagalPosition3);
            result += c3.x + c3.y;

            var c4 = ew.getComponent(SeagalPosition4);
            result += c4.x + c4.y;
        }

        this.result = result;
    }

    public function dispose() {
        for(ew in _entities) {
            _em.destroyEntity(ew.getEntity());
        }
    }
}