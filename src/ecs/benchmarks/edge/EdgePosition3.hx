package ecs.benchmarks.edge;

import edge.IComponent;

class EdgePosition3 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition3 {
        return new EdgePosition3(Math.random(), Math.random());
    }
}