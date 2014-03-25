package ru.codekittens.bc.game.battle_screen.tank {
import flash.geom.Point;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.tank.sequencer.SequencerRequest;
import ru.codekittens.bc.game.battle_screen.tank.sequencer.TankSpriteSequencer;
import ru.codekittens.bc.game.battle_screen.world.Actor;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.core.animation.AnimatedObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.core.debug.GameError;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

public class BaseTank extends AnimatedObject implements Actor {

    private static const TRACK_FRAMES_SKIP:uint = 3;

    protected var position:Point = new Point(0, 0)
    protected var movement:ActorDirection;
    protected var direction:ActorDirection;

    protected var animationKey:uint = 1;
    private var animationFramesPassed:Number = 0;
    private var controller:BaseTankController;
    private var barrier:Boolean;
    protected var visual:TileAsset;
    protected var world:World;

    protected final function setController(value:BaseTankController):void {
        controller = value;
        controller.initialize();
        controller.addEventListener(TankControllerEvent.START, onTankEvent);
        controller.addEventListener(TankControllerEvent.STOP, onTankEvent);
    }

    private function setSprite(sprite:TileAsset):void {
        if (visual != null) removeChild(visual);
        visual = sprite;
        addChild(visual);
    }

    public function getDirection():ActorDirection {
        return direction;
    }

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

    public function setMovement(direction:ActorDirection):void {
        if (movement == direction) return;
        movement = direction;
        alignTankToGrid();
    }

    protected function stopMovement():void {
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

    protected function processMovement(delta:uint):void {

        barrier = world.isBarrierAhead(this);
        if (barrier) {
            return;
        }

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

    private function changeAnimationKey():void {
        animationKey = animationKey == 1 ? 2 : 1;
        animationFramesPassed = 0;
        setSprite(TankSpriteSequencer.getSprite(getSequencerRequest()));
    }

    private function onTankEvent(e:TankControllerEvent):void {
        if (e.type == TankControllerEvent.START) {
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
                    stopMovement();
                    break;
            }
        }
    }

    override public function togglePause():void {
        super.togglePause();
        if (paused) {
            movement = null;
            controller.removeEventListener(TankControllerEvent.START, onTankEvent);
            controller.removeEventListener(TankControllerEvent.STOP, onTankEvent);
        } else {
            controller.addEventListener(TankControllerEvent.START, onTankEvent);
            controller.addEventListener(TankControllerEvent.STOP, onTankEvent);
        }
    }

    public function getPosition():Point {
        position.setTo(x, y);
        return position;
    }

    protected function setDirection(direction:ActorDirection):void {
        if (this.direction == direction) return;
        this.direction = direction;
        setSprite(TankSpriteSequencer.getSprite(getSequencerRequest()));
    }

    protected function moveTo(coords:Point):void {
        x = coords.x * GameSettings.TANK_SIZE;
        y = coords.y * GameSettings.TANK_SIZE;
    }

    protected var request:SequencerRequest = new SequencerRequest();

    protected function getSequencerRequest():SequencerRequest {
        GameError.notImplemented("getSequencerRequest()");
        return null;
    }

    public function getLevel():uint {
        GameError.notImplemented("getLevel()");
        return 0;
    }

    public function getType():ActorType {
        GameError.notImplemented("getType()");
        return null;
    }


}
}
