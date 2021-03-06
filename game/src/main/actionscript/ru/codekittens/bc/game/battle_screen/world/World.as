package ru.codekittens.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.Scores;
import ru.codekittens.bc.game.battle_screen.bonus.BonusManager;
import ru.codekittens.bc.game.battle_screen.bullet.BulletManager;
import ru.codekittens.bc.game.battle_screen.map_loader.MapHelper;
import ru.codekittens.bc.game.battle_screen.tank.BaseTank;
import ru.codekittens.bc.game.battle_screen.tank.player.PlayerTank;
import ru.codekittens.bc.game.battle_screen.world.impact.BarrierType;
import ru.codekittens.bc.game.battle_screen.world.impact.ImpactEntity;
import ru.codekittens.bc.game.battle_screen.world.impact.ImpactProcessor;
import ru.codekittens.bc.game.battle_screen.world.impact.PointPair;
import ru.codekittens.bc.game.battle_screen.world.impact.WorldImpactLayer;
import ru.codekittens.bc.game.battle_screen.world.score.ScoreLayer;
import ru.codekittens.bc.game.events.BattleScreenEvent;
import ru.codekittens.bc.game.events.HQDestroyEvent;
import ru.codekittens.bc.game.keyboard.KeyboardManagerEvent;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

public class World extends GameObject {

    private var bulletManager:BulletManager;
    private var stageId:uint;

    private var tankLayer:Sprite;
    private var playerTank1:PlayerTank;
    private var playerTank2:PlayerTank;
    private var aiTanks:Array = [];
    private var collisionLayer:WorldImpactLayer;
    private var waterLayer:WorldWaterLayer;
    private var bulletLayer:Sprite;
    private var effectsLayer:Sprite;
    private var treeLayer:WorldTreeLayer;
    private var bonusLayer:Sprite;
    private var scoreLayer:ScoreLayer;
    private var bonusManager:BonusManager;

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

        bonusLayer = new Sprite();
        addChild(bonusLayer);

        scoreLayer = new ScoreLayer();
        addChild(scoreLayer);

        bonusManager = new BonusManager();
        bonusManager.initialize();
        bonusManager.reset(bonusLayer);

        //Test
        if (GameSettings.DEBUG) {
            App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        }

        App.dispatcher.addEventListener(HQDestroyEvent.HQ_DESTROY, onHQDestroyed);
        initTestGrid();
        addChild(c1);
        addChild(c2);
        updateImpactsVisibility();
    }

    private function onKeyDown(event:KeyboardManagerEvent):void {
        var command:KeyCommand = event.getCommand();
        switch (command) {
            case KeyCommand.IMPACT_TRIGGER:
                showImpacts = !showImpacts;
                updateImpactsVisibility();
                break;
            case KeyCommand.BONUS_TRIGGER:
                bonusManager.appearBonus(this);
                break;
        }
    }

    public function initializePlayerTank(tankLevel:uint, score:uint, lifes:uint):void {
        playerTank1 = new PlayerTank(tankLevel, score, lifes, this);
        playerTank1.initialize();
        tankLayer.addChild(playerTank1);
    }

    public function getStageId():uint {
        return stageId;
    }

    public function getBulletManager():BulletManager {
        return bulletManager;
    }

    public function shoot(tank:BaseTank):void {
        bulletManager.shoot(tank, this);
    }

    public function isBarrierAhead(actor:Actor):Boolean {
        var barrier:BarrierType = ImpactProcessor.isBarrierAhead(actor, this);
        if (actor.getType() == ActorType.BULLET && barrier != null) {
            switch (barrier.getId()) {
                case BarrierType.BORDER.getId():
                    App.sfxManager.playBorderRicochet();
                    break;
                case BarrierType.BRICK.getId():
                    App.sfxManager.playBrickRicochet();
                    break;
                case BarrierType.EAGLE.getId():
                    App.sfxManager.playEagleExplode();
                    break;
            }
        }
        //TODO: sfx
        return barrier != null;
    }

    override public function destroy():* {
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

        var fullTile:BitmapData = new BitmapData(8, 8, true, 0xAAFFFFFF);
        var emptyTile:BitmapData = new BitmapData(8, 8, true, 0x00FFFFFF);
        var currentBitmapData:BitmapData;
        var currentEntity:ImpactEntity;
        var currentPoint:Point = new Point();
        grid = new Bitmap(new BitmapData(w * 8, h * 8, true, 0x00FFFFFF));
        for (var y:uint = 0; y < h; y++) {
            for (var x:uint = 0; x < w; x++) {
                currentEntity = collisionLayer.getImpactMap().getEntity(x, y);
                currentBitmapData = currentEntity.isBrick() ? fullTile : emptyTile;
                currentPoint.setTo(x * GameSettings.TILE_SIZE, y * GameSettings.TILE_SIZE);
                grid.bitmapData.copyPixels(currentBitmapData, currentBitmapData.rect, currentPoint);
            }
        }

        addChild(grid);
    }

    private var c1:Bitmap = new Bitmap(new BitmapData(8, 8, false, 0x00FF00));
    private var c2:Bitmap = new Bitmap(new BitmapData(8, 8, false, 0x00FF00));

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
        collisionLayer.redrawTileAt(x, y);
    }

    private function onHQDestroyed(event:HQDestroyEvent):void {
        freezePlayers();
        MapHelper.drawBrokenFlag(collisionLayer.getVisual().bitmapData);
        var gameOverEffect:HQGameOverAnimation = new HQGameOverAnimation();
        addChild(gameOverEffect);
        gameOverEffect.addDestroyCallback(function ():void {
            //TODO
            trace("Game Over");
        });
    }

    private function freezePlayers():void {
        playerTank1.togglePause();
        //TODO: Player 2
    }

    public function getCollisionLayer():WorldImpactLayer {
        return collisionLayer;
    }

    public function getBonusLayer():Sprite {
        return bonusLayer;
    }

    private var playerRect:Rectangle = new Rectangle(0, 0, GameSettings.TILE_SIZE * 2, GameSettings.TILE_SIZE * 2);
    private var bonusRect:Rectangle = new Rectangle(0, 0, GameSettings.TILE_SIZE * 2, GameSettings.TILE_SIZE * 2);

    public function checkIntersectWithPlayerTank(tank:PlayerTank, rect:Rectangle):Boolean {
        if (tank == null) {
            return false;
        }

        playerRect.x = tank.getPosition().x;
        playerRect.y = tank.getPosition().y;
        return playerRect.intersects(rect)
    }

    public function checkIntersectWithPlayerTanks(rect:Rectangle):Boolean {
        return checkIntersectWithPlayerTank(playerTank1, rect) || checkIntersectWithPlayerTank(playerTank2, rect);
    }

    public function checkBonus(tank:PlayerTank):void {
        if (bonusManager.bonusOnScreen()) {
            bonusRect.x = bonusManager.getCurrentBonus().coords.x;
            bonusRect.y = bonusManager.getCurrentBonus().coords.y;
            if (checkIntersectWithPlayerTank(tank, bonusRect)) {
                bonusManager.applyBonus(tank);
                tank.scoreUp(Scores.BONUS);
                scoreLayer.showScore(Scores.BONUS, new Point(bonusRect.x, bonusRect.y));
                App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.REDRAW_HUD));
            }
        }
    }

}
}
