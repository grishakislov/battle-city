/**
 * @author arlechin
 * Date: 30.09.12
 * Time: 23:08
 */
package ru.arlevoland.bc.game.battlestage.tank {
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
