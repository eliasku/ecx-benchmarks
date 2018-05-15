package ecs.benchmarks.pure;

class PurePosition4 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():PurePosition4 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}