package ru.codekittens.bc.game {
import flash.display.Sprite;
import flash.events.Event;

import ru.codekittens.bc.game.time.Ticker;

public class GameObject extends Sprite {

    private var callback:Function;
    protected var paused:Boolean;

    public function GameObject() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }

    protected function onAddedToStage(e:Event):void {
        //Do nothing
    }

    protected function onRemovedFromStage(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }

    public function togglePause():void {
        paused = !paused;
    }

    protected final function setTickListening(value:Boolean):void {
        if (value) {
            Ticker.addTickListener(onTick);
        } else {
            Ticker.removeTickListener(onTick);
        }
    }

    protected function onTick(dt:uint):void {

    }

    public final function addDestroyCallback(callback:Function):void {
        this.callback = callback;
    }

    public function destroy():* {
        if (callback != null) {
            callback();
        }
    }
}
}
