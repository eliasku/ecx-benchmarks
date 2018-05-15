package ecs.benchmarks.eskimo;

class EskimoPosition1 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():EskimoPosition1 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}