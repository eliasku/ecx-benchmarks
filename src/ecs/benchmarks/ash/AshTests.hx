package ecs.benchmarks.ash;

import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;

class AshTests {

    public var engine:Engine;
    public var list:NodeList<AshNode>;
    public var entities:Array<Entity>;
    public var result:Float;
    public var count:Int;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
        engine = new Engine();
        list = engine.getNodeList(AshNode);
    }

    public function setup() {
        entities = [];
        for(i in 0...count) {
            var e = new ash.core.Entity()
            .add(new AshPosition1().randomize())
            .add(new AshPosition3().randomize())
            .add(new AshPosition4().randomize());
            engine.addEntity(e);
            entities.push(e);
        }
        engine.update(0.0001);

        if(list.empty) {
            throw "ASH list is empty";
        }
    }

    public function update() {
        var result:Float = this.result;
        var nodes = this.list;

        for(node in nodes) {
            var p1 = node.p1;
            var p2 = null;
            var p3 = node.p3;
            var p4 = node.p4;

            // We know that it can't be null, but checking for justice
            result += p1.x + p1.y;

            if(p2 != null) {
                result += p2.x + p2.y;
            }

            result += p3.x + p3.y;
            result += p4.x + p4.y;
        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            engine.removeEntity(entities[i]);
        }
        engine.update(0.0001);
    }

}
