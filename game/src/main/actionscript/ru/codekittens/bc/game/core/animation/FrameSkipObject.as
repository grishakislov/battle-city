package ru.codekittens.bc.game.core.animation {
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.time.Ticker;

public class FrameSkipObject extends GameObject {

    private var framesToSkip:uint;
    private var framesSkipped:uint = 0;

    public function FrameSkipObject(framesToSkip:uint = 0) {
        this.framesToSkip = framesToSkip;
        Ticker.addTickListener(onTick);
    }

    override protected function onTick(dt:uint):void {
        framesSkipped++;
        if (framesSkipped >= framesToSkip) {
            framesSkipped = 0;
            onAnimation();
        }
    }

    protected function onAnimation():void {

    }

    override public function destroy():* {
        super.destroy();
        Ticker.removeTickListener(onTick);
    }


}
}
