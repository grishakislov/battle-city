package ru.codekittens.bc.game.core.animation {
import flash.display.Sprite;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.time.Ticker;
import ru.codekittens.bc.game.time.TickerEvent;

public class AnimatedObject extends Sprite {

    /*
    Анимированный объект с возможностью настройки скорости в пикселях/сек.
    Отдает целую дельту.
     */

    //Pixels per second
    private var pixelsPerSecond:uint;

    private var pixelsPerMilli:Number;
    private var currentPixels:Number = 0;

    private var timeElapsed:Number = 0;
    protected var lastDt:uint = 0;

    private var lastPixels:Number;
    private var pixelDelta:uint;

    private var callback:Function;

    private var paused:Boolean = false;

    public function AnimatedObject() {
        Ticker.addEventListener(TickerEvent.TICK, onTick);
        setPixelsPerSecond(GameSettings.DEFAULT_SPEED);
    }

    private function onTick(event:TickerEvent):void {
        currentPixels += pixelsPerMilli * event.dt;
        var delta:uint = Math.floor(currentPixels) - Math.floor(lastPixels);
        if (delta > 0) {
            onAnimation(delta);
            currentPixels -= delta;
        }

        lastPixels = currentPixels;
        timeElapsed += event.dt;
        lastDt = event.dt;
    }

    public final function addDestroyCallback(callback:Function):void {
        this.callback = callback;
    }

    public function pause():void {
        if (paused) {
            Ticker.addEventListener(TickerEvent.TICK, onTick);
        } else {
            Ticker.removeEventListener(TickerEvent.TICK, onTick);
        }
        paused = !paused;
    }

    protected function onAnimation(delta:uint):void {
        //Do nothing
//        trace(delta);
    }

    protected final function setAnimationEnabled(value:Boolean):void {
        if (value) {
            Ticker.addEventListener(TickerEvent.TICK, onTick);
        } else {
            Ticker.removeEventListener(TickerEvent.TICK, onTick);
        }
    }

    public function getPixelsPerSecond():uint {
        return pixelsPerSecond;
    }

    public function setPixelsPerSecond(value:uint):void {
        pixelsPerSecond = value;
        pixelsPerMilli = pixelsPerSecond / 1000;
    }

    public function destroy():void {
        Ticker.removeEventListener(TickerEvent.TICK, onTick);
        if (callback != null) {
            callback();
        }
    }


}
}
