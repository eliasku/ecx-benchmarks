package ecx.benchmarks;

import edge.View;
import edge.ISystem;
import edge.IComponent;

class EdgePosition implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition {
        return new EdgePosition(Math.random(), Math.random());
    }
}

class EdgePosition2 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition2 {
        return new EdgePosition2(Math.random(), Math.random());
    }
}

class EdgePosition3 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition3 {
        return new EdgePosition3(Math.random(), Math.random());
    }
}

class EdgePosition4 implements IComponent {

    public var x:Float = 0;
    public var y:Float = 0;

    public static function random():EdgePosition4 {
        return new EdgePosition4(Math.random(), Math.random());
    }
}

class EdgeSystem implements ISystem {
    public var view:View<{
        p1:EdgePosition,
        p2:EdgePosition2,
        p3:EdgePosition3,
        p4:EdgePosition4
    }>;

    function update() {}
}
