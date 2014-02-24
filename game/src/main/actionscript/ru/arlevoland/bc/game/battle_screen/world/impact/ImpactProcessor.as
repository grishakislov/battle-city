package ru.arlevoland.bc.game.battle_screen.world.impact {
import flash.geom.Point;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battle_screen.bullet.Bullet;
import ru.arlevoland.bc.game.battle_screen.tank.*;
import ru.arlevoland.bc.game.battle_screen.world.*;

public class ImpactProcessor {

    public static function borderAhead(actor:IActor):Boolean {
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

    public static function isBarrierAhead(actor:IActor, world:World):Boolean {
        if (actor.getType() == ActorType.BULLET) {
            return borderAhead(actor) || checkWallBeforeBullet(actor as Bullet, world);
        } else if (actor.getType().isTank()) {
            return borderAhead(actor) || checkWallBeforeActor(actor, world);
        }

        return false;
    }

    private static function checkWallBeforeBullet(bullet:IActor, world:World):Boolean {
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

    private static function checkWallBeforeActor(actor:IActor, world:World):Boolean {
        var frontCells:PointPair = getFrontCells(actor);

        world.setFrontCellsCoord(frontCells);

        var entities:ImpactEntityPair = getEntitiesByFrontCells(frontCells, world);
        var first:ImpactEntity = entities.getFirst();
        var second:ImpactEntity = entities.getSecond();

        var result1:Boolean = first.checkImpact(actor, false);
        var result2:Boolean = second.checkImpact(actor, true);

        if (actor.getType() == ActorType.BULLET) {
            if (result1 && result2) {
                if (first.getFrontFlag() && second.getFrontFlag()) {
                    first.destruct(actor.getDirection());
                    second.destruct(actor.getDirection());
                } else if (first.getFrontFlag()) {
                    first.destruct(actor.getDirection())
                } else if (second.getFrontFlag()) {
                    second.destruct(actor.getDirection());
                } else {
                    first.destruct(actor.getDirection());
                    second.destruct(actor.getDirection());
                }
            } else {
                if (result1) first.destruct(actor.getDirection());
                if (result2) second.destruct(actor.getDirection());
            }
        }

        return result1 || result2;
    }

    public static function getFrontCells(actor:IActor):PointPair {
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
            const minX:uint = 0;
            const minY:uint = 0;
            pair.trimAll(minX, maxX, minY, maxY);
        }
    }
}
}
