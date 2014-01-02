/**
 * @author arlechin
 * Date: 11.04.12
 * Time: 23:38
 */

package ru.arlevoland.bc.game.battlestage.tank {
import flash.geom.Point;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.battlestage.tank.sequencer.SequencerRequest;
import ru.arlevoland.bc.game.battlestage.tank.sequencer.TankSpriteSequencer;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.battlestage.battleground.Battleground;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.model.StageResult;
import ru.arlevoland.bc.game.sfx.SfxLoop;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class PlayerTank extends BaseTank {

    private static const DEFAULT_DIRECTION:TankDirection = TankDirection.UP;
    private static const TRACK_FRAMES_SKIP:uint = 4;

    public function PlayerTank(tankLevel:uint, world:Battleground) {
        this.tankLevel = tankLevel;
        this.world = world;
    }

    public function initialize():void {

        controller = new PlayerTankController();
        controller.initialize();
        controller.addEventListener(PlayerTankControllerEvent.START, onTankEvent);
        controller.addEventListener(PlayerTankControllerEvent.STOP, onTankEvent);
        setDirection(DEFAULT_DIRECTION);
        addChild(visual);
        moveTo(GameSettings.PLAYER_TANK_1_INITIAL_COORDS);
        setPixelsPerSecond(GameSettings.PLAYER_TANK_SPEED)
        playIdleSound();
    }

    public function setMovement(direction:TankDirection):void {
        if (movement == direction) return;
        movement = direction;
        playMovingSound();
        alignTankToGrid();
    }

    private function stopMovement():void {
        playIdleSound();
        movement = null;
    }


    override protected function onAnimation(delta:uint):void {
        super.onAnimation(delta);
        if (movement == null) {
            return;
        }

        //TODO: Отвязать от кадров
        animationFramesPassed++;
        if (animationFramesPassed >= TRACK_FRAMES_SKIP - 1) {
            changeAnimationKey();
        }
        processMovement(delta);
    }

    private function processMovement(delta:uint):void {
        if (CollisionHelper.borderAhead(this) || CollisionHelper.wallAhead(this, world.tankCollisionMap)) {
            movement = null;
            playIdleSound();
            return;
        }

        switch (movement) {
            case TankDirection.UP:
                y -= delta;
                break;
            case TankDirection.RIGHT:
                x += delta;
                break;
            case TankDirection.DOWN:
                y += delta;
                break;
            case TankDirection.LEFT:
                x -= delta;
                break;
        }
    }

    private function alignTankToGrid():void {
        switch (movement) {
            case TankDirection.UP:
            case TankDirection.DOWN:
                x = Math.round(x / GameSettings.TANK_GRID_SIZE) * GameSettings.TANK_GRID_SIZE;
                break;
            case TankDirection.RIGHT:
            case TankDirection.LEFT:
                y = Math.round(y / GameSettings.TANK_GRID_SIZE) * GameSettings.TANK_GRID_SIZE;
                break;
        }
    }

    private function changeAnimationKey():void {
        animationKey = animationKey == 1 ? 2 : 1;
        animationFramesPassed = 0;
        setSprite(TankSpriteSequencer.getSprite(getSequencerRequest()));
    }

    private function onTankEvent(e:PlayerTankControllerEvent):void {
        if (e.type == PlayerTankControllerEvent.START) {
            switch (e.getCommand()) {
                case KeyCommand.UP:
                    setDirection(TankDirection.UP);
                    setMovement(TankDirection.UP);
                    break;
                case KeyCommand.RIGHT:
                    setDirection(TankDirection.RIGHT);
                    setMovement(TankDirection.RIGHT);
                    break;
                case KeyCommand.DOWN:
                    setDirection(TankDirection.DOWN);
                    setMovement(TankDirection.DOWN);
                    break;
                case KeyCommand.LEFT:
                    setDirection(TankDirection.LEFT);
                    setMovement(TankDirection.LEFT);
                    break;
                case KeyCommand.FIRE:
                    //TODO: Wrap
                    world.bulletManager.shoot(_currentDirection, this);
                    break;
            }
        } else {
            switch (e.getCommand()) {
                case KeyCommand.UP:
                case KeyCommand.RIGHT:
                case KeyCommand.DOWN:
                case KeyCommand.LEFT:
//                case KeyCommand.FIRE:
                    stopMovement();
                    break;
            }
        }
    }

    public function pause():void {
        if (!paused) {
            paused = true;
            stopSound();
            setAnimationEnabled(false);
            controller.removeEventListener(PlayerTankControllerEvent.START, onTankEvent);
            controller.removeEventListener(PlayerTankControllerEvent.STOP, onTankEvent);
        } else {
            paused = false;
            movement = null;
            playIdleSound();
            setAnimationEnabled(true);
            controller.addEventListener(PlayerTankControllerEvent.START, onTankEvent);
            controller.addEventListener(PlayerTankControllerEvent.STOP, onTankEvent);
        }
    }

    private function setDirection(direction:TankDirection):void {
        if (_currentDirection == direction) return;
        _currentDirection = direction;
        setSprite(TankSpriteSequencer.getSprite(getSequencerRequest()));
    }

    private function moveTo(coords:Point):void {
        x = coords.x * GameSettings.TANK_SIZE;
        y = coords.y * GameSettings.TANK_SIZE;
    }

    //visual

    private function setSprite(sprite:TileAsset):void {
        if (visual != null) removeChild(visual);
        visual = sprite;
        addChild(visual);
    }

    private function getSequencerRequest():SequencerRequest {
        var result:SequencerRequest = new SequencerRequest();
        result.direction = _currentDirection;
        result.tankType = ActorType.PLAYER;
        result.level = tankLevel;
        result.animationKey = animationKey;
        return result;
    }

    //Collisions
    private function getCurrentWorldCoords():Point {
        var result:Point = new Point();
        result.x = Math.floor(x / GameSettings.TANK_GRID_SIZE);
        result.y = Math.floor(y / GameSettings.TANK_GRID_SIZE);
        return result;
    }

    [ArrayElementType("flash.geom.Point")]
    private function getCellsBeforeTank():Array {
        var result:Array = [];

        return result;
    }

    //Shooting

    //Sound
    private function playIdleSound():void {
        App.sfxManager.playEngine1();
    }

    private function playMovingSound():void {
        App.sfxManager.playEngine2();
    }

    private function stopSound():void {
        App.sfxManager.stop();
    }

    //ITank

    override public function getLevel():uint {
        return tankLevel;
    }

    override public function getType():ActorType {
        return ActorType.PLAYER;
    }

    override public function getBulletCollisionTable():Array {
        return world.bulletCollisionMap;
    }

    private var _currentDirection:TankDirection;
    private var tankLevel:uint;

    private var world:Battleground;
    private var speed:uint;
    private var score:uint;
    private var stageResult:StageResult;
    private var animationKey:uint = 1;
    private var animationFramesPassed:Number = 0;
    private var visual:TileAsset;
    private var controller:PlayerTankController;
    private var currentCommand:String;
    private var paused:Boolean;


}

}