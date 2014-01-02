/**
 * @author arlechin
 * Date: 10.08.12
 * Time: 9:12
 */
package ru.arlevoland.bc.game.battlestage.tank {
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.animation.AnimatedObject;
import ru.arlevoland.bc.game.core.debug.GameError;

internal class BaseTank extends AnimatedObject implements ITank {
    public function BaseTank() {
    }


    public function getLevel():uint {
        GameError.notImplemented("getLevel()");
        return 0;
    }

    public function getType():ActorType {
        GameError.notImplemented("getType()");
        return null;
    }

    public function getWorldPosition():Point {
        return new Point(Math.floor(x / GameSettings.TILE_SIZE), Math.floor(y / GameSettings.TILE_SIZE));
    }

    public function getMovement():TankDirection {
        return movement;
    }

    public function getPosition():Point {
        return new Point(x, y);
    }

    public function getBulletCollisionTable():Array {
        GameError.notImplemented("getBulletCollisionTable()");
        return null;
    }

    protected var movement:TankDirection;
}
}
