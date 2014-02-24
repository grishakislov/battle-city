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
        var result1:Boolean = entities.getFirst().checkImpact(actor, false);
        var result2:Boolean = entities.getSecond().checkImpact(actor, true);
        return result1 || result2;
    }

    public static function getFrontCells(actor:IActor):PointPair {
        var left:Point = new Point(0, 0);
        var right:Point = new Point(0, 0);
        var top:Point = new Point(0, 0);
        var bottom:Point = new Point(0, 0);
        var position:Point = actor.getPosition();

        var result:PointPair;

        switch (actor.getDirection()) {
            case ActorDirection.UP:
                left.x = Math.floor(position.x / GameSettings.TILE_SIZE);
                right.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
                right.y = left.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                result = new PointPair(left, right);
                trim(result);
                return result;
                break;

            case ActorDirection.RIGHT:
                top.x = bottom.x = Math.ceil(position.x / GameSettings.TILE_SIZE) + 1;
                top.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                bottom.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
                result = new PointPair(top, bottom);
                break;

            case ActorDirection.DOWN:
                left.x = Math.floor(position.x / GameSettings.TILE_SIZE);
                right.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
                right.y = left.y = Math.ceil(position.y / GameSettings.TILE_SIZE) + 1;
                result = new PointPair(left, right);
                break;

            case ActorDirection.LEFT:
                top.x = bottom.x = Math.ceil(position.x / GameSettings.TILE_SIZE) - 1;
                top.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                bottom.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
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
            if (pair.getFirst().x > maxX) pair.getFirst().x = maxX;
            if (pair.getFirst().x < minX) pair.getFirst().x = minX;
            if (pair.getFirst().y > maxY) pair.getFirst().y = maxY;
            if (pair.getFirst().y < minY) pair.getFirst().y = minY;
            if (pair.getSecond().x > maxX) pair.getSecond().x = maxX;
            if (pair.getSecond().x < minX) pair.getSecond().x = minX;
            if (pair.getSecond().y > maxY) pair.getSecond().y = maxY;
            if (pair.getSecond().y < minY) pair.getSecond().y = minY;
        }
    }
}
}
