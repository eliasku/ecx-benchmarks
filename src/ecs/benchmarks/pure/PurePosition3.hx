package ecs.benchmarks.pure;

class PurePosition3 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():PurePosition3 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}