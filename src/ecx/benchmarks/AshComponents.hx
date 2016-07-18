package ecx.benchmarks;

import ash.core.Node;

class AshPosition {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():AshPosition {
        x = Math.random();
        y = Math.random();
        return this;
    }
}

class AshPosition2 {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():AshPosition2 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}

class AshPosition3 {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():AshPosition3 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}

class AshPosition4 {
    public var x:Float = 0;
    public var y:Float = 0;

    public function new() {}

    public function randomize():AshPosition4 {
        x = Math.random();
        y = Math.random();
        return this;
    }
}

class AshNode extends Node<AshNode> {
    public var p1:AshPosition;
    public var p2:AshPosition2;
    public var p3:AshPosition3;
    public var p4:AshPosition4;
}
