package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

public class BulletData {

    public function BulletData(direction:ActorDirection, tankCoords:Point, level:uint) {
        this.direction = direction;
        this.tankCoords = tankCoords;
        this.level = level;
    }

    public function getDirection():ActorDirection {
        return direction;
    }

    public function getTankCoords():Point {
        return tankCoords;
    }

    public function getLevel():uint {
        return level;
    }

    private var direction:ActorDirection;
    private var tankCoords:Point;
    private var level:uint;

}
}
