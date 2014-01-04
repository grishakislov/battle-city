package ru.arlevoland.bc.game.time {
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

public class Ticker extends EventDispatcher {

    public static const HIGH_TICK_INTERVAL:int = 15;
    public static const SLOW_TICK_INTERVAL:int = 500;

    public static function initialize(_stage:Stage):void {
        _stage = _stage;
        _stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private static function onEnterFrame(event:Event):void {
        var timeStamp:int = getTimer();
        var dt:int = timeStamp - lastTickTimestamp;
        if (dt >= tickInterval) {
            lastTickTimestamp = timeStamp;
            instance.dispatchEvent(new TickerEvent(TickerEvent.TICK, dt));
        }

        ++frames;
    }


    public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
        instance.removeEventListener(type, listener, useCapture);
    }

    private static var stage:Stage;
    private static var tickInterval:int = HIGH_TICK_INTERVAL;
    private static var lastTickTimestamp:int = getTimer();
    private static var frames:int = 0;

    private static var instance:Ticker = new Ticker();

}
}
