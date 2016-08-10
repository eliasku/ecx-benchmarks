package ecs.benchmarks.pure;

import ecx.ds.CArray;
class PureTests {

    public var result:Float;
    public var count:Int;

    var _pos1:CArray<PurePosition1>;
    var _pos2:CArray<PurePosition2>;
    var _pos3:CArray<PurePosition3>;
    var _pos4:CArray<PurePosition4>;
    var _entities:CArray<Int>;

    public function new(count:Int) {
        this.count = count;
        result = Std.int(Math.random() * 200);
    }

    public function setup() {
        _entities = new CArray(count);
        for(i in 0...count) {
            _entities[i] = i;
        }

        _pos1 = new CArray(count);
        for(i in 0...count) {
            _pos1[i] = new PurePosition1().randomize();
        }

        _pos2 = new CArray(count);
        for(i in 0...count) {
            _pos2[i] = null;
        }

        _pos3 = new CArray(count);
        for(i in 0...count) {
            _pos3[i] = new PurePosition3().randomize();
        }

        _pos4 = new CArray(count);
        for(i in 0...count) {
            _pos4[i] = new PurePosition4().randomize();
        }
    }

    public function update() {
        var result:Float = this.result;
        var entities = _entities;
        var p1 = _pos1;
        var p2 = _pos2;
        var p3 = _pos3;
        var p4 = _pos4;

        for(i in 0...p1.length) {
            var index = entities[i];
            var c1 = p1[index];
            if(c1 != null) {
                result += c1.x + c1.y;
            }
            var c2 = p2[index];
            if(c2 != null) {
                result += c2.x + c2.y;
            }
            var c3 = p3[index];
            if(c3 != null) {
                result += c3.x + c3.y;
            }
            var c4 = p4[index];
            if(c4 != null) {
                result += c4.x + c4.y;
            }
        }

        this.result = result;
    }

    public function dispose() {
        _pos1 = null;
        _pos2 = null;
        _pos3 = null;
        _pos4 = null;
    }

}