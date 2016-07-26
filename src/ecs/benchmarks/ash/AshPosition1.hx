package ecs.benchmarks.ash;

class AshPosition1 {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():AshPosition1 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}