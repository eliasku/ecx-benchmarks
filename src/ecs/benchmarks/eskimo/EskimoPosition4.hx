package ecs.benchmarks.eskimo;

class EskimoPosition4 {

    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():EskimoPosition4 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}