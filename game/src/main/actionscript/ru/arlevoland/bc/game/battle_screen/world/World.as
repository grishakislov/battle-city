package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.MapLoader;
import ru.arlevoland.bc.game.battle_screen.bullet.BulletManager;
import ru.arlevoland.bc.game.battle_screen.tank.PlayerTank;
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;

public class World extends Sprite {

    public function initialize(levelId:uint):void {

        stageId = levelId;
        bulletManager = new BulletManager();
        collisionLayer = new WorldImpactLayer();
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

    public function getBulletManager():BulletManager {
        return bulletManager;
    }

    public function applyDestruction(worldPoint:Point, direction:ActorDirection):void {
        collisionLayer.applyDestruction(worldPoint, direction);
    }

    public function shoot(tank:IActor):void {
        bulletManager.shoot(tank);
    }

//    private var tankCollisionMap:Array;
//    private var bulletCollisionMap:Array;

    private var bulletManager:BulletManager;

    private var stageId:uint;
    private var tankLayer:Sprite;
    private var playerTank1:PlayerTank;
    private var player2:PlayerTank;
    private var aiTanks:Array = [];
    private var collisionLayer:WorldImpactLayer;
    private var waterLayer:WorldWaterLayer;
    private var bulletLayer:Sprite;
    private var effectsLayer:Sprite;
    private var treeLayer:WorldTreeLayer;

}
}
