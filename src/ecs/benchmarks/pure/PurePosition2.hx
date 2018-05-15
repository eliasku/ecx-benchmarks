package ecs.benchmarks.pure;

class PurePosition2 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():PurePosition2 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}