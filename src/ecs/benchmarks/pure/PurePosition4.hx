package ecs.benchmarks.pure;

import ecx.Component;

class PurePosition4 extends Component {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():PurePosition4 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}