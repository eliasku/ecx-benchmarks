package ecs.benchmarks.hxe;

import hxE.ComponentTypeSlot;
import hxE.Entity;
import hxE.EntityWorld;

class HxeTests {

    public var world:EntityWorld;

    public var entities:Array<Entity>;
    public var result:Float;

    var _hxe1:ComponentTypeSlot<HxePosition1>;
    var _hxe2:ComponentTypeSlot<HxePosition2>;
    var _hxe3:ComponentTypeSlot<HxePosition3>;
    var _hxe4:ComponentTypeSlot<HxePosition4>;

    public function new() {
        result = Std.int(Math.random() * 200);

        world = new EntityWorld();
        _hxe1 = new ComponentTypeSlot(HxePosition1);
        _hxe2 = new ComponentTypeSlot(HxePosition2);
        _hxe3 = new ComponentTypeSlot(HxePosition3);
        _hxe4 = new ComponentTypeSlot(HxePosition4);

        _hxe1.setWorld(world);
        _hxe2.setWorld(world);
        _hxe3.setWorld(world);
        _hxe4.setWorld(world);
    }

    public function setup() {
        entities = [];
        for(i in 0...1000) {
            var e = world.create();
            e.addComponent(new HxePosition1().randomize());
            e.addComponent(new HxePosition3().randomize());
            e.addComponent(new HxePosition4().randomize());
            e.update();
            entities.push(e);
        }
        if(entities.length == 0) {
            throw "hxE is empty";
        }

    }

    public function update() {
        var result:Float = this.result;
        var hxe1 = _hxe1;
        var hxe2 = _hxe2;
        var hxe3 = _hxe3;
        var hxe4 = _hxe4;

        for(e in entities) {
            var c1:HxePosition1 = hxe1.get(e);
            if(c1 != null) {
                result += c1.x + c1.y;
            }
            var c2:HxePosition2 = hxe2.get(e);
            if(c2 != null) {
                result += c2.x + c2.y;
            }
            var c3:HxePosition3 = hxe3.get(e);
            if(c3 != null) {
                result += c3.x + c3.y;
            }
            var c4:HxePosition4 = hxe4.get(e);
            if(c4 != null) {
                result += c4.x + c4.y;
            }
        }

        this.result = result;
    }

    public function dispose() {
        for(i in 0...entities.length) {
            world.destroyEntity(entities[i]);
        }
    }

}
