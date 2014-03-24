package ru.codekittens.bc.game.core.animation {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.settings.model.FrameSpeed;
import ru.codekittens.bc.game.time.Ticker;

public class AnimatedObject extends GameObject {

    private var speed:FrameSpeed;
    private var millisPerStep:uint;
    private var currentStep:uint = 0;
    private var currentStepMillis:uint = 0;
    protected var lastDt:uint = 0;

    public function run(speed:FrameSpeed = null):void {
        this.speed = speed;
        if (speed == null) {
            this.speed = App.settingsManager.getFrameSpeedById("DEFAULT");
        }
        millisPerStep = 1000 / 64;
        Ticker.addTickListener(onTick);
    }

    override protected function onTick(dt:uint):void {
        if (currentStep == speed.sequence.length) {
            currentStep = 0;
        }
        currentStepMillis += dt;
        if (currentStepMillis > millisPerStep) {
            onAnimation(speed.sequence[currentStep] ? speed.pixelsPerFrame : 0);
            currentStepMillis -= millisPerStep;
        }

        currentStep++;
        lastDt = dt;
    }

    override public function togglePause():void {
        super.togglePause();
        if (paused) {
            Ticker.removeTickListener(onTick);
        } else {
            Ticker.addTickListener(onTick);
        }
    }

    public function pause():void {
        if (paused) {
            Ticker.addTickListener(onTick);
        } else {
            Ticker.removeTickListener(onTick);
        }
        paused = !paused;
    }

    protected function onAnimation(delta:uint):void {
        //Do nothing
    }

    override public function destroy():* {
        super.destroy();
        Ticker.removeTickListener(onTick);
    }
}
}
