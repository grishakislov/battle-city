package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.IActor;
import ru.arlevoland.bc.game.battle_screen.world.impact.ImpactProcessor;
import ru.arlevoland.bc.game.core.animation.AnimatedObject;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.core.debug.GameError;
import ru.arlevoland.bc.game.sfx.SfxLoop;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

internal class Bullet extends AnimatedObject implements IActor {

    public function Bullet(data:BulletData) {
        this.direction = data.getDirection();
        this.tankCoords = data.getTankCoords();
        initialize();
        applyStartCoordsForBullet();
        playShootSound();
        start();
    }

    private function initialize():void {
        UP = App.assetManager.getTileAsset("BULLET_U");
        RIGHT = App.assetManager.getTileAsset("BULLET_R");
        DOWN = App.assetManager.getTileAsset("BULLET_D");
        LEFT = App.assetManager.getTileAsset("BULLET_L");
    }

    private function applyStartCoordsForBullet():void {
        /*
         Спрайт пули независимо от направления имеет размер 1x2
         */
        switch (direction) {
            case ActorDirection.UP:
                x = tankCoords.x + 3;
                y = tankCoords.y - 7;
                break;
            case ActorDirection.RIGHT:
                x = tankCoords.x + GameSettings.TANK_SIZE - 5;
                y = tankCoords.y;
                break;
            case ActorDirection.DOWN:
                x = tankCoords.x + 3;
                y = tankCoords.y + 7;
                break;
            case ActorDirection.LEFT:
                x = tankCoords.x - 3;
                y = tankCoords.y;
                break;
        }
    }

    private function applyStartCoordsForExplode():void {
        switch (direction) {
            case ActorDirection.UP:
                x -= 4;
                y -= 2;
                break;
            case ActorDirection.RIGHT:
                y -= 1;
                x -= 2;
                break;
            case ActorDirection.DOWN:
                x -= 3;
                y += 2;
                break;
            case ActorDirection.LEFT:
                x -= 5;
                break;
        }
    }


    override protected function onAnimation(delta:uint):void {
        super.onAnimation(delta);
        if (isMoving()) {
            move(delta);
        } else {
            if (framesSkipped >= explodeSequenceFramesSkip) {
                if (explodeSequenceIndex == explodeSequence.length - 1) {
                    onExploded();
                    return;
                }
                framesSkipped = 0;
                explodeSequenceIndex++;
                updateExplodeVisualAsset(explodeSequenceIndex);
            }
            framesSkipped++;
        }
    }

    private function onTick(e:TickerEvent):void {



    }

    private function move(delta:uint):void {
        if (wallAhead()) {
            explode();
            stopMovement();
            return;
        }
        if (endAhead()) {
            explode();
            stopMovement();
            return;
        }

//        if (tankAhead() != null) {
//            stopMovement();
//            return;
//        }
        switch (movement) {
            case ActorDirection.UP:
                y -= delta;
                break;
            case ActorDirection.RIGHT:
                x += delta;
                break;
            case ActorDirection.DOWN:
                y += delta;
                break;
            case ActorDirection.LEFT:
                x -= delta;
                break;
        }
    }

    private function endAhead():Boolean {
        return ImpactProcessor.borderAhead(this);
    }

    private function wallAhead():Boolean {
        /*
         избавиться от карт столкновений и проверять тайлы

         ввести в бинарник модели столкновений для тайлов

         алгоритм:
         проверяем, есть ли тайл (8x8) впереди
         если есть, проверяем, прозрачный он или нет
         если непрозрачный, определяем координаты столкновения
         */

        //TODO: Проверить уровень пули

        return ImpactProcessor.checkWall(this);
    }

    private function tankAhead():* {
        return null;
    }

    private function getForwardBound():Point {
        var result:Point = new Point();
        switch (movement) {
            case ActorDirection.UP:
                result.x = x;
                result.y = y + 6;
                break;
            case ActorDirection.RIGHT:
                result.x = x - 10;
                result.y = y;
                break;
            case ActorDirection.DOWN:
                result.x = x;
                result.y = y - 6;
                break;
            case ActorDirection.LEFT:
                result.x = x + 2;
                result.y = y;
                break;
        }
        return result;
    }

    private function explode():void {
        removeChild(visual);
        applyStartCoordsForExplode();
    }

    private function playShootSound():void {
        App.sfxManager.playShoot();
    }

    private function start():void {
        var visualName:String;
        movement = direction;
        switch (direction) {
            case ActorDirection.UP:
                visualName = "BULLET_U";
                break;
            case ActorDirection.RIGHT:
                visualName = "BULLET_R";
                break;
            case ActorDirection.DOWN:
                visualName = "BULLET_D";
                break;
            case ActorDirection.LEFT:
                visualName = "BULLET_L";
                break;
        }
        visual = App.assetManager.getTileAsset(visualName).getClone();
        addChild(visual);
    }

    private function updateExplodeVisualAsset(index:int):void {
        if (contains(visual)) removeChild(visual);
        visual.getBitmap().bitmapData.dispose();
        visual = App.assetManager.getTileAsset(explodeSequence[index]).getClone();
        addChild(visual);
    }

    private function onExploded():void {
        destroy();
    }

    private function stopMovement():void {
        movement = null;
    }

    private function isMoving():Boolean {
        return movement != null;
    }

    override public function destroy():void {
        super.destroy();
        parent.removeChild(this);
        visual.getBitmap().bitmapData.dispose();
        Ticker.removeEventListener(TickerEvent.TICK, onTick);
    }

    //IActor

    public function getLevel():uint {
        return level;
    }

    public function getType():ActorType {
        return ActorType.BULLET;
    }

    [Deprecated]
    public function getWorldPosition():Point {
        return null;
    }

    public function getPosition():Point {
        return getForwardBound();
    }

    public function getDirection():ActorDirection {
        return movement;
    }

    private var _millisElapsed:int = 0;

    private var direction:ActorDirection;
    private var level:uint;
    private var tankCoords:Point;
    private var movement:ActorDirection;

    private var UP:TileAsset;
    private var RIGHT:TileAsset;
    private var DOWN:TileAsset;
    private var LEFT:TileAsset;

    private var visual:TileAsset;
    private var explodeSequence:Array = ["EXPLODE_1", "EXPLODE_2", "EXPLODE_3", "EXPLODE_2", "EXPLODE_1"];
    private var explodeSequenceIndex:uint;
    private var explodeSequenceFramesSkip:uint = 2;
    private var framesSkipped:uint;
}
}
