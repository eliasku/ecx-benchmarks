package ecs.benchmarks.edge;

import edge.Entity;
import edge.World;

class EdgeTests {

    public var world:World;
    public var system:EdgeSystem;

    public var entities:Array<Entity>;
    public var result:Float;

    public function new() {
        result = Std.int(Math.random() * 200);

        world = new World();
        system = new EdgeSystem();
        world.render.add(system);
    }

    public function setup() {
        entities = [];
        for(i in 0...1000) {
            var e = world.engine.create([
                EdgePosition1.random(),
                EdgePosition2.random(),
                    //EdgePosition3.random(),
                EdgePosition4.random()
            ]);
            entities.push(e);
        }
        if(entities.length == 0) {
            throw "EDGE is empty";
        }
    }

    public function update() {
        var result:Float = this.result;

        for(e in system.view) {
            var data = e.data;
            result += data.p1.x + data.p1.y;
            result += data.p2.x + data.p2.y;
            //result += data.p3.x + data.p3.y;
            result += data.p4.x + data.p4.y;
        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            entities[i].destroy();
        }
    }

}
