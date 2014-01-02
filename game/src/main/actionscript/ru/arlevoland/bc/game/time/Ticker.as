package ru.arlevoland.bc.game.time {
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

public class Ticker extends EventDispatcher {

    public static const HIGH_TICK_INTERVAL:int = 15;
    public static const SLOW_TICK_INTERVAL:int = 500;

    public static function initialize(stage:Stage):void {
        _stage = stage;
        _stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private static function onEnterFrame(event:Event):void {
        var timeStamp:int = getTimer();
        var dt:int = timeStamp - _lastTickTimestamp;
        if (dt >= _tickInterval) {
            _lastTickTimestamp = timeStamp;
            _instance.dispatchEvent(new TickerEvent(TickerEvent.TICK, dt));
        }

        ++_frames;
    }


    public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        _instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
        _instance.removeEventListener(type, listener, useCapture);
    }

    private static var _stage:Stage;
    private static var _tickInterval:int = HIGH_TICK_INTERVAL;
    private static var _slowTickInterval:int = SLOW_TICK_INTERVAL;
//    private static var _fps:int = 0;

    private static var _lastTickTimestamp:int = getTimer();
    private static var _lastSlowTickTimestamp:int = getTimer();
//    private static var _lastFpsTimestamp:int = getTimer();
    private static var _frames:int = 0;

    private static var _instance:Ticker = new Ticker();

}
}
