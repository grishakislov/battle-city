package ru.codekittens.bc.game.time {
import flash.display.Stage;
import flash.events.Event;
import flash.utils.Dictionary;
import flash.utils.getTimer;

public class Ticker  {

    public static const HIGH_TICK_INTERVAL:int = 15;
    public static const SLOW_TICK_INTERVAL:int = 500;

    public static function initialize(stage:Stage):void {
        stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private static function onEnterFrame(event:Event):void {
        var timeStamp:int = getTimer();
        var dt:int = timeStamp - lastTickTimestamp;
        if (dt >= tickInterval) {
            lastTickTimestamp = timeStamp;
            dispatchTick(dt);
        }

        ++frames;
    }

    private static function dispatchTick(dt:uint):void {
        for each (var c:Function in callbacks) {
            c.call(null, dt);
        }
    }

    public static function addTickListener(listener:Function):void {
        callbacks[listener] = listener;
    }

    public static function removeTickListener(listener:Function):void {
        delete callbacks[listener];
    }

    private static var callbacks:Dictionary = new Dictionary();
    private static var tickInterval:int = HIGH_TICK_INTERVAL;
    private static var lastTickTimestamp:int = getTimer();
    private static var frames:int = 0;


}
}
