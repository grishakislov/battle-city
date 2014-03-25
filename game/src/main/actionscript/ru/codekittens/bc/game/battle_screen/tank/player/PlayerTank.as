package ru.codekittens.bc.game.battle_screen.tank.player {
import ru.codekittens.bc.game.battle_screen.tank.*;
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.tank.sequencer.SequencerRequest;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.battle_screen.world.World;

public class PlayerTank extends BaseTank {

    private static const DEFAULT_DIRECTION:ActorDirection = ActorDirection.UP;

    private var tankLevel:uint;

    private var score:uint;
    private var lives:uint;


    override public function setMovement(direction:ActorDirection):void {
        super.setMovement(direction);
        playMovingSound();
    }

    override protected function stopMovement():void {
        super.stopMovement();
        playIdleSound();
    }

    public function PlayerTank(tankLevel:uint, score:uint, lifes:uint, world:World) {
        this.tankLevel = tankLevel;
        this.score = score;
        this.lives = lifes;
        this.world = world;
    }

    override protected function getSequencerRequest():SequencerRequest {
        request.direction = direction;
        request.tankType = ActorType.PLAYER;
        request.level = tankLevel;
        request.animationKey = animationKey;
        return request;
    }

    public function initialize():void {
        setController(new PlayerTankController());
        setDirection(DEFAULT_DIRECTION);
//        addChild(visual);
        moveTo(GameSettings.PLAYER_TANK_1_INITIAL_COORDS);
        run(App.settingsManager.getFrameSpeedById("PLAYER_TANK"));
        playIdleSound();
    }

    override protected function processMovement(delta:uint):void {
        super.processMovement(delta);
        world.checkBonus(this);
    }


    override public function togglePause():void {
        super.togglePause();
        if (!paused) {
            playIdleSound();
        }
    }

    private function playIdleSound():void {
        App.sfxManager.playEngine1();
    }

    private function playMovingSound():void {
        App.sfxManager.playEngine2();
    }

    override public function getLevel():uint {
        return tankLevel;
    }

    override public function getType():ActorType {
        return ActorType.PLAYER;
    }

    public function upgrade():void {
        if (tankLevel < PlayerTankLevel.LEVEL_4) {
            tankLevel++;
        }
    }

    public function scoreUp(score:uint):void {
        this.score += score;
        if (this.score >= GameSettings.SCORE_TO_LIFE) {
            extraLife();
        }
    }

    public function extraLife():void {
        lives++;
    }
}

}