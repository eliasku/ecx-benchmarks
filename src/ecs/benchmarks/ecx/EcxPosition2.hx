package ecs.benchmarks.ecx;

import ecx.Component;

class EcxPosition2 extends Component {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():EcxPosition2 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}