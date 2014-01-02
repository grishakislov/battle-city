package ru.arlevoland.bc.game.core.animation {
import flash.display.Sprite;

import ru.arlevoland.bc.GameSettings;

import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class AnimatedObject extends Sprite {

    /*
    Анимированный объект с возможностью настройки скорости в пикселях/сек.
    Отдает целую дельту.
     */

    //Pixels per second
    private var _pixelsPerSecond:uint;

    private var _pixelsPerMilli:Number;
    private var _currentPixels:Number = 0;

    private var _timeElapsed:Number = 0;

    private var _lastPixels:Number;
    private var _pixelDelta:uint;

    public function AnimatedObject() {
        Ticker.addEventListener(TickerEvent.TICK, onTick);
        setPixelsPerSecond(GameSettings.DEFAULT_SPEED);
    }

    private function onTick(event:TickerEvent):void {
        _currentPixels += _pixelsPerMilli * event.dt;
        var delta:uint = Math.floor(_currentPixels) - Math.floor(_lastPixels);
        if (delta > 0) {
            onAnimation(delta);
            _currentPixels -= delta;
        }

        _lastPixels = _currentPixels;
        _timeElapsed += event.dt;
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
        return _pixelsPerSecond;
    }

    public function setPixelsPerSecond(value:uint):void {
        _pixelsPerSecond = value;
        _pixelsPerMilli = _pixelsPerSecond / 1000;
    }

    public function destroy():void {
        Ticker.removeEventListener(TickerEvent.TICK, onTick);
    }


}
}
