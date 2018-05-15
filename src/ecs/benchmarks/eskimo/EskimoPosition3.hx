package ecs.benchmarks.eskimo;

class EskimoPosition3 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():EskimoPosition3 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}