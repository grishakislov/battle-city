package ru.arlevoland.bc.game.battle_screen.world.impact {
import flash.geom.Point;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battle_screen.bullet.Bullet;
import ru.arlevoland.bc.game.battle_screen.tank.*;
import ru.arlevoland.bc.game.battle_screen.world.*;

public class ImpactProcessor {

    public static function isBarrierAhead(actor:Actor, world:World):Boolean {
        if (actor.getType() == ActorType.BULLET) {
            return borderAhead(actor) || checkWallBeforeBullet(actor as Bullet, world);
        } else if (actor.getType().isTank()) {
            return borderAhead(actor) || checkWallBeforeActor(actor, world);
        }

        return false;
    }

    private static function borderAhead(actor:Actor):Boolean {
        var movement:ActorDirection = actor.getDirection();
        var position:Point = actor.getPosition();
        switch (movement) {
            case ActorDirection.UP:
                return position.y <= 0;
                break;
            case ActorDirection.RIGHT:
                return position.x >= GameSettings.WORLD_WIDTH * GameSettings.MAP_TILE_SIZE - GameSettings.TANK_SIZE;
                break;
            case ActorDirection.DOWN:
                return position.y >= GameSettings.WORLD_HEIGHT * GameSettings.MAP_TILE_SIZE - GameSettings.TANK_SIZE;
                break;
            case ActorDirection.LEFT:
                return position.x <= 0;
                break;
            default:
                return false;
                break;
        }
    }

    private static function checkWallBeforeBullet(bullet:Actor, world:World):Boolean {
        var frontCells:PointPair = getFrontCells(bullet);
        var result:Boolean = checkWallBeforeActor(bullet, world);
        if (result) {
            world.redrawTiles(frontCells.toArray());
        }
        return result;
    }

    private static function getEntitiesByFrontCells(frontCells:PointPair, world:World):ImpactEntityPair {
        var impactMap:ImpactMap = world.getCollisionLayer().getImpactMap();
        return impactMap.getEntities(frontCells);
    }

    private static function checkWallBeforeActor(actor:Actor, world:World):Boolean {
        var frontCells:PointPair = getFrontCells(actor);

        world.setFrontCellsCoord(frontCells); //For debug

        var entities:ImpactEntityPair = getEntitiesByFrontCells(frontCells, world);
        var first:ImpactEntity = entities.getFirst();
        var second:ImpactEntity = entities.getSecond();

        var result1:Boolean;
        var result2:Boolean;

        //Eagle
        if (first.isEagle() && actor.getType() == ActorType.BULLET) {
            result1 = first.checkImpact(actor, false);
            if (result1) {
                return true;
            } else {
                result2 = second.checkImpact(actor, true);
                if (result2) {
                    return true;
                }
            }

            if (!result1 && !result2) {
                return false;
            }
        }

        result1 = first.checkImpact(actor, false);
        result2 = second.checkImpact(actor, true);

        if (actor.getType() == ActorType.BULLET) {

            var direction:ActorDirection = actor.getDirection();
            var doubleImpact:Boolean = result1 && result2;
            var flagsEqual:Boolean = (first.getFrontFlag() == second.getFrontFlag());

            if (doubleImpact) {

                if (flagsEqual) {
                    first.destruct(direction);
                    second.destruct(direction);

                } else if (first.getFrontFlag()) first.destruct(direction);
                else if (second.getFrontFlag()) second.destruct(direction);

            } else {
                if (result1) first.destruct(direction);
                if (result2) second.destruct(direction);
            }
        }

        return result1 || result2;
    }

    private static function getFrontCells(actor:Actor):PointPair {
        var left:Point = new Point(0, 0);
        var right:Point = new Point(0, 0);
        var top:Point = new Point(0, 0);
        var bottom:Point = new Point(0, 0);
        var position:Point = actor.getPosition();

        var result:PointPair;
        var floorX:uint = Math.floor(position.x / GameSettings.TILE_SIZE);
        var floorY:uint = Math.floor(position.y / GameSettings.TILE_SIZE);
        var ceilX:uint = Math.ceil(position.x / GameSettings.TILE_SIZE);
        var ceilY:uint = Math.ceil(position.y / GameSettings.TILE_SIZE);

        switch (actor.getDirection()) {
            case ActorDirection.UP:
                left.x = floorX;
                right.x = floorX + 1;
                right.y = left.y = floorY;
                result = new PointPair(left, right);
                break;

            case ActorDirection.RIGHT:
                top.x = bottom.x = ceilX + 1;
                top.y = floorY;
                bottom.y = floorY + 1;
                result = new PointPair(top, bottom);
                break;

            case ActorDirection.DOWN:
                left.x = floorX;
                right.x = floorX + 1;
                right.y = left.y = ceilY + 1;
                result = new PointPair(left, right);
                break;

            case ActorDirection.LEFT:
                top.x = bottom.x = ceilX - 1;
                top.y = floorY;
                bottom.y = floorY + 1;
                result = new PointPair(top, bottom);
                break;

            default :
                return null;
        }

        trim(result);
        return result;

        function trim(pair:PointPair):void {
            const maxX:uint = GameSettings.WORLD_WIDTH * 2 - 1;
            const maxY:uint = GameSettings.WORLD_WIDTH * 2 - 1;
            pair.trimAll(0, maxX, 0, maxY);
        }
    }
}
}
