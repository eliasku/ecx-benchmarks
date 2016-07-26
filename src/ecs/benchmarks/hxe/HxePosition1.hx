package ecs.benchmarks.hxe;

import hxE.Component;

class HxePosition1 extends Component {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {
        super();
    }

    public function randomize():HxePosition1 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}