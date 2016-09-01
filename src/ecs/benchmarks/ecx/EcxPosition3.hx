package ecs.benchmarks.ecx;

import ecx.AutoComp;
import ecx.Entity;

class EcxPosition3 extends AutoComp<EcxPositionData> {

    public function randomize(entity:Entity):EcxPositionData {
        var data = get(entity);
        if(data == null) {
            data = create(entity);
        }
        data.x = Math.random();
        data.y = Math.random();
        return data;
    }
}