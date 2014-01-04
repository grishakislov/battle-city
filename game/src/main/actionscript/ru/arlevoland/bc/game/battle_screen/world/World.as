package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.MapLoader;
import ru.arlevoland.bc.game.battle_screen.tank.BulletManager;
import ru.arlevoland.bc.game.battle_screen.tank.PlayerTank;
import ru.arlevoland.bc.game.battle_screen.tank.TankDirection;

public class World extends Sprite {

    public function initialize(levelId:uint):void {

        stageId = levelId;
        bulletManager = new BulletManager();
        collisionLayer = new WorldCollisionLayer();
        collisionLayer.initialize(levelId);
        addChild(collisionLayer);

        waterLayer = new WorldWaterLayer();
        waterLayer.initialize(levelId);
        addChild(waterLayer);

        tankLayer = new Sprite();
        addChild(tankLayer);


        bulletLayer = BulletManager.getBulletLayer();
        addChild(bulletLayer);

        treeLayer = new WorldTreeLayer();
        treeLayer.initialize(levelId);
        addChild(treeLayer);

        tankCollisionMap = MapLoader.fillTankCollisionMap(stageId);
        bulletCollisionMap = MapLoader.fillBulletCollisionMap(stageId);

    }

    public function initializePlayerTank(tankLevel:uint):void {
        playerTank1 = new PlayerTank(tankLevel, this);
        playerTank1.initialize();
        tankLayer.addChild(playerTank1);
    }

    public function pause():void {
        playerTank1.pause();
    }


    public function getStageId():uint {
        return stageId;
    }

    public function getTankCollisionMap():Array {
        return tankCollisionMap;
    }

    public function getBulletCollisionMap():Array {
        return bulletCollisionMap;
    }

    public function getBulletManager():BulletManager {
        return bulletManager;
    }

    public function applyDestruction(worldPoint:Point, direction:TankDirection):void {
        collisionLayer.applyDestruction(worldPoint, direction);
    }

    private var tankCollisionMap:Array;
    private var bulletCollisionMap:Array;

    private var bulletManager:BulletManager;

    private var stageId:uint;
    private var tankLayer:Sprite;
    private var playerTank1:PlayerTank;
    private var player2:PlayerTank;
    private var aiTanks:Array = [];
    private var collisionLayer:WorldCollisionLayer;
    private var waterLayer:WorldWaterLayer;
    private var bulletLayer:Sprite;
    private var effectsLayer:Sprite;
    private var treeLayer:WorldTreeLayer;

}
}
