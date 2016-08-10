package ecs.benchmarks.edge;

import edge.Entity;
import edge.World;

class EdgeTests {

    public var world:World;
    public var system:EdgeSystem;

    public var entities:Array<Entity>;
    public var result:Float;
    public var count:Int;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);

        world = new World();
        system = new EdgeSystem();
        world.render.add(system);
    }

    public function setup() {
        entities = [];
        for(i in 0...count) {
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
            var p1 = data.p1;
            var p2:EdgePosition3 = null;
            var p3 = data.p3;
            var p4 = data.p4;
            if(p1 != null) {
                result += p1.x + p1.y;
            }
            if(p2 != null) {
                result += p2.x + p2.y;
            }
            if(p3 != null) {
                result += p3.x + p3.y;
            }
            if(p4 != null) {
                result += p4.x + p4.y;
            }

        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            entities[i].destroy();
        }
    }

}
