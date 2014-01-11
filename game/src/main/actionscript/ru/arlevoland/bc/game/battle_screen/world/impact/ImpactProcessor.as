package ru.arlevoland.bc.game.battle_screen.world.impact {
import ru.arlevoland.bc.game.battle_screen.world.*;
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.IActor;

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

    public static function checkWall(actor:IActor):Boolean {

//        var collisionCoords:Array = [];
//        var isBullet:Boolean = actor.getType() == ActorType.BULLET;
//
//        var leftForward:Point = new Point(0, 0);
//        var rightForward:Point = new Point(0, 0);
//        var topForward:Point = new Point(0, 0);
//        var bottomForward:Point = new Point(0, 0);
//
//        var minX:int = -1000;
//        var maxX:int = 1000;
//        var minY:int = -1000;
//        var maxY:int = 1000;
//
//        var direction:ActorDirection = actor.getDirection();
//        var position:Point = actor.getPosition();
//
//        switch (direction) {
//            case ActorDirection.UP:
//                leftForward.x = Math.floor(position.x / GameSettings.TILE_SIZE);
//                rightForward.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
//                rightForward.y = leftForward.y = Math.floor(position.y / GameSettings.TILE_SIZE);
//
//                if (collisionTable[leftForward.x + leftForward.y * GameSettings.WORLD_WIDTH * 2] == 1) {
//                    collisionCoords.push(leftForward);
//                    minY = (leftForward.y + 1) * GameSettings.TILE_SIZE;
//                }
//                if (collisionTable[rightForward.x + rightForward.y * GameSettings.WORLD_WIDTH * 2] == 1) {
//                    collisionCoords.push(rightForward);
//                    minY = (rightForward.y + 1) * GameSettings.TILE_SIZE;
//                }
//
//                if (position.y <= minY) {
//                    applyDestruction(collisionCoords, actor.getMovement(), isBullet);
//                    return true;
//                }
//                break;
//
//            case ActorDirection.RIGHT:
//                topForward.x = bottomForward.x = Math.ceil(position.x / GameSettings.TILE_SIZE) + 1;
//                topForward.y = Math.floor(position.y / GameSettings.TILE_SIZE);
//                bottomForward.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
//
//                if (collisionTable[topForward.x + topForward.y * GameSettings.WORLD_WIDTH * 2] == 1 ||
//                        collisionTable[bottomForward.x + bottomForward.y * GameSettings.WORLD_WIDTH * 2] == 1) {
//                    maxX = (topForward.x - 2) * GameSettings.TILE_SIZE;
//                }
//
//                return position.x >= maxX;
//                break;
//            case ActorDirection.DOWN:
//
//                leftForward.x = Math.floor(position.x / GameSettings.TILE_SIZE);
//                rightForward.x = Math.floor(position.x / GameSettings.TILE_SIZE) + 1;
//                rightForward.y = leftForward.y = Math.ceil(position.y / GameSettings.TILE_SIZE) + 1;
//
//                if (collisionTable[leftForward.x + leftForward.y * GameSettings.WORLD_WIDTH * 2] == 1 ||
//                        collisionTable[rightForward.x + rightForward.y * GameSettings.WORLD_WIDTH * 2] == 1) {
//                    maxY = (rightForward.y - 2) * GameSettings.TILE_SIZE;
//                }
//
//                return position.y >= maxY;
//                break;
//
//            case ActorDirection.LEFT:
//                topForward.x = bottomForward.x = Math.floor(position.x / GameSettings.TILE_SIZE);
//                topForward.y = Math.floor(position.y / GameSettings.TILE_SIZE);
//                bottomForward.y = Math.floor(position.y / GameSettings.TILE_SIZE) + 1;
//
//                if (collisionTable[topForward.x + topForward.y * GameSettings.WORLD_WIDTH * 2] == 1 ||
//                        collisionTable[bottomForward.x + bottomForward.y * GameSettings.WORLD_WIDTH * 2] == 1) {
//                    minX = (topForward.x + 1) * GameSettings.TILE_SIZE;
//                }
//                return position.x <= minX;
//                break;
//        }
        return false;
    }

    private static function applyDestruction(worldCoords:Array, direction:ActorDirection, isBullet:Boolean):void {
        if (!isBullet) return;
        var worldPoint:Point;
        while (worldCoords.length > 0) {
            worldPoint = worldCoords.shift();
            App.battleground.applyDestruction(worldPoint, direction);
        }
    }
}
}