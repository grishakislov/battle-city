package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.game.GameSettings;

import ru.arlevoland.bc.game.battle_screen.map_loader.MapLoader;
import ru.arlevoland.bc.game.battle_screen.bullet.BulletManager;
import ru.arlevoland.bc.game.battle_screen.tank.PlayerTank;
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactEntity;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactProcessor;
import ru.arlevoland.bc.game.battle_screen.world.impact.WorldImpactLayer;

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


        //Test
        initTestGrid();
        addChild(c1);
        addChild(c2);
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
        bulletManager.shoot(tank, this);
    }

    public function isBarrierAhead(actor:IActor):Boolean {
        return ImpactProcessor.isBarrierAhead(actor, this);
    }

    public function getCollisionLayer():WorldImpactLayer {
        return collisionLayer;
    }


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

    //Test
    private var grid:Bitmap;


    private function initTestGrid():void {
        var w:uint = GameSettings.WORLD_WIDTH * 2;
        var h:uint = GameSettings.WORLD_HEIGHT * 2;

        var fullTile:BitmapData = new BitmapData(8,8,true,0xAAFFFFFF);
        var emptyTile:BitmapData = new BitmapData(8,8,true,0x00FFFFFF);
        var currentBitmapData:BitmapData;
        var currentEntity:ImpactEntity;
        var currentPoint:Point = new Point();
        grid = new Bitmap(new BitmapData(w*8,h*8,true,0x00FFFFFF));
        for (var y:uint = 0; y < h; y++) {
            for (var x:uint = 0; x < w; x++) {
                currentEntity = collisionLayer.getImpactMap().getEntity(x,y);
                currentBitmapData = currentEntity.isBrick() ? fullTile : emptyTile;
                currentPoint.x = x * GameSettings.TILE_SIZE;
                currentPoint.y = y * GameSettings.TILE_SIZE;
                grid.bitmapData.copyPixels(currentBitmapData, currentBitmapData.rect, currentPoint);
            }
        }

        addChild(grid);
    }
    private var c1:Bitmap = new Bitmap(new BitmapData(8,8,false, 0x00FF00));
    private var c2:Bitmap = new Bitmap(new BitmapData(8,8,false, 0x00FF00));
    public function setFrontCellsCoord(frontCell:Point, frontCell2:Point):void {
        c1.x = frontCell.x * GameSettings.TILE_SIZE;
        c1.y = frontCell.y * GameSettings.TILE_SIZE;
        c2.x = frontCell2.x * GameSettings.TILE_SIZE;
        c2.y = frontCell2.y * GameSettings.TILE_SIZE;
    }
}
}
