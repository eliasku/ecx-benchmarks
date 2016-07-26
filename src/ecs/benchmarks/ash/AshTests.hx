package ecs.benchmarks.ash;

import ash.core.Entity;
import ash.core.Engine;
import ash.core.NodeList;

class AshTests {

    public var engine:Engine;
    public var list:NodeList<AshNode>;
    public var entities:Array<Entity>;
    public var result:Float;

    public function new() {
        result = Std.int(Math.random() * 200);
        engine = new Engine();
        list = engine.getNodeList(AshNode);
    }

    public function setup() {
        entities = [];
        for(i in 0...1000) {
            var e = new ash.core.Entity()
            .add(new AshPosition1().randomize())
            .add(new AshPosition2().randomize())
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
            result += node.p1.x + node.p1.y;
            result += node.p2.x + node.p2.y;
            //result += n.p3.x + n.p3.y;
            result += node.p4.x + node.p4.y;
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
