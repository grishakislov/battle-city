package ru.arlevoland.bc.game.battle_screen.tank {
import flash.geom.Point;

public class BulletData {

    public function BulletData(direction:TankDirection, tankCoords:Point, collisionTable:Array) {
        this.direction = direction;
        this.tankCoords = tankCoords;
        this.collisionTable = collisionTable;
    }

    public function getDirection():TankDirection {
        return direction;
    }

    public function getTankCoords():Point {
        return tankCoords;
    }

    public function getCollisionTable():Array {
        return collisionTable;
    }

    private var direction:TankDirection;
    private var tankCoords:Point;
    private var collisionTable:Array;

}
}
