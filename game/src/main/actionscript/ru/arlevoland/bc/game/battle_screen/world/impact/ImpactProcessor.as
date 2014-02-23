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
            return borderAhead(actor) || checkWallBeforeTank(actor as BaseTank, world);
        }

        return false;
    }

    private static function checkWallBeforeBullet(bullet:IActor, world:World):Boolean {
        var frontCells:Array = getFrontCells(bullet);

        //TODO: applyDestruction
        return false;
    }

    private static function checkWallBeforeTank(tank:IActor, world:World):Boolean {
        var impactMap:ImpactMap = world.getCollisionLayer().getImpactMap();
        var frontCells:Array = getFrontCells(tank);
        world.setFrontCellsCoord(frontCells[0], frontCells[1]);
        [ArrayElementType("ru.arlevoland.bc.game.battle_screen.world.impact.ImpactEntity")]
        var entities:Array = [];
        entities.push(impactMap.getEntity(frontCells[0].x, frontCells[0].y));
        entities.push(impactMap.getEntity(frontCells[1].x, frontCells[1].y));

        var r0:Boolean = entities[0].checkImpact(tank);
        var r1:Boolean = entities[1].checkImpact(tank);

        return entities[0].checkImpact(tank) || entities[1].checkImpact(tank);
    }

    public static function getFrontCells(actor:IActor):Array {
        var left:Point = new Point(0, 0);
        var right:Point = new Point(0, 0);
        var top:Point = new Point(0, 0);
        var bottom:Point = new Point(0, 0);
        var position:Point = actor.getPosition();

        switch (actor.getDirection()) {
            case ActorDirection.UP:
                left.x = Math.floor(position.x / GameSettings.TILE_SIZE);
                right.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
                right.y = left.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                trim(left, right);
                return [left, right];
                break;

            case ActorDirection.RIGHT:
                top.x = bottom.x = Math.ceil(position.x / GameSettings.TILE_SIZE) + 1;
                top.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                bottom.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
                trim(top, bottom);
                return [top, bottom];
                break;

            case ActorDirection.DOWN:
                left.x = Math.floor(position.x / GameSettings.TILE_SIZE);
                right.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
                right.y = left.y = Math.ceil(position.y / GameSettings.TILE_SIZE) + 1;
                trim(left, right);
                return [left, right];
                break;

            case ActorDirection.LEFT:
                top.x = bottom.x = Math.ceil(position.x / GameSettings.TILE_SIZE) - 1;
                top.y = Math.floor(position.y / GameSettings.TILE_SIZE);
                bottom.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
                trim(top, bottom);
                return [top, bottom];
                break;

            default :
                return null;
        }

        function trim(p1:Point, p2:Point):void {
            trace(p1 + " " + p2);
            const maxX:uint = GameSettings.WORLD_WIDTH * 2 - 1;
            const maxY:uint = GameSettings.WORLD_WIDTH * 2 - 1;
            const minX:uint = 0;
            const minY:uint = 0;
            if (p1.x > maxX) p1.x = maxX;
            if (p1.x < minX) p1.x = minX;
            if (p1.y > maxY) p1.y = maxY;
            if (p1.y < minY) p1.y = minY;
            if (p2.x > maxX) p2.x = maxX;
            if (p2.x < minX) p2.x = minX;
            if (p2.y > maxY) p2.y = maxY;
            if (p2.y < minY) p2.y = minY;
        }
    }

    private static function applyDestruction(worldCoords:Array, direction:ActorDirection, world:World):void {
        var worldPoint:Point;
        while (worldCoords.length > 0) {
            worldPoint = worldCoords.shift();
            world.applyDestruction(worldPoint, direction);
        }
    }
}
}
