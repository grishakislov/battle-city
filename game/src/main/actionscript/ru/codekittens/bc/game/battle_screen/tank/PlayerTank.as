package ru.codekittens.bc.game.battle_screen.tank {
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.tank.sequencer.SequencerRequest;
import ru.codekittens.bc.game.battle_screen.tank.sequencer.TankSpriteSequencer;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

public class PlayerTank extends BaseTank {

    private static const DEFAULT_DIRECTION:ActorDirection = ActorDirection.UP;
    private static const TRACK_FRAMES_SKIP:uint = 3;

    private var tankLevel:uint;

    private var world:World;
    private var animationKey:uint = 1;
    private var animationFramesPassed:Number = 0;
    private var visual:TileAsset;
    private var controller:PlayerTankController;
    private var barrier:Boolean;

    public function PlayerTank(tankLevel:uint, world:World) {
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
        run(App.settingsManager.getFrameSpeedById("PLAYER_TANK"));
        playIdleSound();
    }

    public function setMovement(direction:ActorDirection):void {
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

        if (movement != null) {
            animationFramesPassed++;
            if (animationFramesPassed >= TRACK_FRAMES_SKIP - 1) {
                changeAnimationKey();
            }
        }

        processMovement(delta);
    }

    private function processMovement(delta:uint):void {

        barrier = world.isBarrierAhead(this);
        if (barrier) {
            return;
        }
//        trace("Delta: " + delta + ", " + "last DT: " + lastDt);

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

    //TODO: Move to BaseTank
    private function alignTankToGrid():void {
        switch (movement) {
            case ActorDirection.UP:
            case ActorDirection.DOWN:
                x = Math.round(x / GameSettings.TANK_GRID_SIZE) * GameSettings.TANK_GRID_SIZE;
                break;
            case ActorDirection.RIGHT:
            case ActorDirection.LEFT:
                y = Math.round(y / GameSettings.TANK_GRID_SIZE) * GameSettings.TANK_GRID_SIZE + 1;
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
                    setDirection(ActorDirection.UP);
                    setMovement(ActorDirection.UP);
                    break;
                case KeyCommand.RIGHT:
                    setDirection(ActorDirection.RIGHT);
                    setMovement(ActorDirection.RIGHT);
                    break;
                case KeyCommand.DOWN:
                    setDirection(ActorDirection.DOWN);
                    setMovement(ActorDirection.DOWN);
                    break;
                case KeyCommand.LEFT:
                    setDirection(ActorDirection.LEFT);
                    setMovement(ActorDirection.LEFT);
                    break;
                case KeyCommand.FIRE:
                    world.shoot(this);
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

    override public function togglePause():void {
        super.togglePause();
        if (paused) {
            App.sfxManager.togglePause();
            playIdleSound();
            setAnimationEnabled(false);
            controller.removeEventListener(PlayerTankControllerEvent.START, onTankEvent);
            controller.removeEventListener(PlayerTankControllerEvent.STOP, onTankEvent);
        } else {
            movement = null;
            playIdleSound();
            setAnimationEnabled(true);
            controller.addEventListener(PlayerTankControllerEvent.START, onTankEvent);
            controller.addEventListener(PlayerTankControllerEvent.STOP, onTankEvent);
        }
    }

    private function setDirection(direction:ActorDirection):void {
        if (this.direction == direction) return;
        this.direction = direction;
        setSprite(TankSpriteSequencer.getSprite(getSequencerRequest()));
    }

    private function moveTo(coords:Point):void {
        x = coords.x * GameSettings.TANK_SIZE;
        y = coords.y * GameSettings.TANK_SIZE + 1;
    }

    //visual

    private function setSprite(sprite:TileAsset):void {
        if (visual != null) removeChild(visual);
        visual = sprite;
        addChild(visual);
    }

    private function getSequencerRequest():SequencerRequest {
        var result:SequencerRequest = new SequencerRequest();
        result.direction = direction;
        result.tankType = ActorType.PLAYER;
        result.level = tankLevel;
        result.animationKey = animationKey;
        return result;
    }

    //Sound
    private function playIdleSound():void {
        App.sfxManager.playEngine1();
    }

    private function playMovingSound():void {
        App.sfxManager.playEngine2();
    }

//    private function stopSound():void {
//        App.sfxManager.stop();
//    }

    override public function getLevel():uint {
        return tankLevel;
    }

    override public function getType():ActorType {
        return ActorType.PLAYER;
    }


}

}