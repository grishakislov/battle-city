package ru.codekittens.bc.game.core.animation {
import flash.display.Sprite;

import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.time.Ticker;

public class FrameSkipObject extends GameObject {

    private var framesToSkip:uint;
    private var framesSkipped:uint = 0;

    private var asset:Sprite;

    public function FrameSkipObject(asset:Sprite, framesToSkip:uint = 0) {
        this.asset = asset;
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

    override public function togglePause():void {
        super.togglePause();
        setTickListening(!paused);
    }

    protected function onAnimation():void {

    }

    override public function destroy():* {
        super.destroy();
        Ticker.removeTickListener(onTick);
    }

    public function getAsset():Sprite {
        return asset;
    }
}
}
