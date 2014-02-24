package ru.arlevoland.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.GameSettings;

import ru.arlevoland.bc.game.battle_screen.map_loader.MapLoader;
import ru.arlevoland.bc.game.battle_screen.bullet.BulletManager;
import ru.arlevoland.bc.game.battle_screen.tank.PlayerTank;
import ru.arlevoland.bc.game.battle_screen.tank.ActorDirection;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactEntity;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactProcessor;
import ru.arlevoland.bc.game.battle_screen.world.impact.PointPair;
import ru.arlevoland.bc.game.battle_screen.world.impact.WorldImpactLayer;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.keyboard.key.KeyManager;

public class World extends Sprite {

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
        if (GameSettings.DEBUG) {
            App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        }
        initTestGrid();
        addChild(c1);
        addChild(c2);
        updateImpactsVisibility();
    }

    private function onKeyDown(event:KeyboardManagerEvent):void {
        var command:KeyCommand = event.getCommand();
        if (command == KeyCommand.IMPACT_TRIGGER) {
            showImpacts = !showImpacts;
            updateImpactsVisibility();
        }
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

    public function destroy():void {
        if (GameSettings.DEBUG) {
            App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        }
    }

    //Test
    private function updateImpactsVisibility():void {
        grid.visible = showImpacts;
        c1.visible = c2.visible = showImpacts;
    }

    private var grid:Bitmap;
    private var showImpacts:Boolean;

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

    public function setFrontCellsCoord(frontCells:PointPair):void {
        if (!showImpacts) {
            return;
        }
        c1.x = frontCells.getFirst().x * GameSettings.TILE_SIZE;
        c1.y = frontCells.getFirst().y * GameSettings.TILE_SIZE;
        c2.x = frontCells.getSecond().x * GameSettings.TILE_SIZE;
        c2.y = frontCells.getSecond().y * GameSettings.TILE_SIZE;
    }

    public function redrawTiles(cells:Array):void {
        for each (var p:Point in cells) {
            redrawTileAt(p.x, p.y);
        }
    }

    private function redrawTileAt(x:uint, y:uint):void {
        collisionLayer.redrawTileAt(x,y);
    }
}
}
