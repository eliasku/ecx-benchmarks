package ecs.benchmarks.pure_hot;

import hotmem.F32;
import hotmem.HotMemory;
import ecx.ds.CArray;

class PureHotTests {

    public var entities:CArray<Int>;
    public var result:F32;
    public var count:Int;

    var _storage:PureHotStorage;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);

        HotMemory.initialize(50);
        _storage = new PureHotStorage(count);
    }

    public function setup() {
        entities = new CArray(count);

        for(i in 0...count) {
            entities[i] = i;
        }

        for(entity in entities) {
            _storage.randomize1(entity);
            _storage.randomize3(entity);
            _storage.randomize4(entity);
        }

        if(entities.length == 0) {
            throw "Pure hot list is empty";
        }
    }

    public function update() {
        var result:Float = this.result;

        var p1_x = _storage._position1_x;
        var p1_y = _storage._position1_y;
        var p2_x = _storage._position2_x;
        var p2_y = _storage._position2_y;
        var p3_x = _storage._position3_x;
        var p3_y = _storage._position3_y;
        var p4_x = _storage._position4_x;
        var p4_y = _storage._position4_y;

        for(entity in entities) {
            result += p1_x[entity] + p1_y[entity];
            if(entity == 0xFFFFFF) {
                /** Just to ignore **/
                result += p2_x[entity] + p2_y[entity];
            }
            result += p3_x[entity] + p3_y[entity];
            result += p4_x[entity] + p4_y[entity];
        }

        this.result = result;
    }

    public function dispose() {}
}