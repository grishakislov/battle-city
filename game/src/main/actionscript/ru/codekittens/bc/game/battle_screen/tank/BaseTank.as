package ru.codekittens.bc.game.battle_screen.tank {
import flash.geom.Point;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.world.Actor;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.core.animation.AnimatedObject;
import ru.codekittens.bc.game.core.debug.GameError;

public class BaseTank extends AnimatedObject implements Actor {

    public function getLevel():uint {
        GameError.notImplemented("getLevel()");
        return 0;
    }

    public function getType():ActorType {
        GameError.notImplemented("getType()");
        return null;
    }

    public function getWorldPosition():Point {
        worldPosition.setTo(Math.floor(x / GameSettings.TILE_SIZE), Math.floor(y / GameSettings.TILE_SIZE));
        return worldPosition;
    }

    public function getDirection():ActorDirection {
        return direction;
    }

    public function getPosition():Point {
        switch (direction) {
            case ActorDirection.UP:
                position.setTo(x, y);
                break;
            case ActorDirection.LEFT:
                position.setTo(x, y);
                break;
            case ActorDirection.DOWN:
                position.setTo(x, y);
                break;
            case ActorDirection.RIGHT:
                position.setTo(x, y);
                break;
        }
        return position;
    }

    public function getBulletCollisionTable():Array {
        GameError.notImplemented("getBulletCollisionTable()");
        return null;
    }

    protected var position:Point = new Point(0,0)
    protected var worldPosition:Point = new Point(0,0)
    protected var movement:ActorDirection;
    protected var direction:ActorDirection;
}
}
