package ecs.benchmarks.ecx2;

import ecx.storage.AutoComp;
import ecx.Entity;

class Ecx2Position1 extends AutoComp<Ecx2PositionData> {

    public function randomize(entity:Entity):Ecx2PositionData {
        var data = get(entity);
        if(data == null) {
            data = create(entity);
        }
        data.x = Math.random();
        data.y = Math.random();
        return data;
    }
}