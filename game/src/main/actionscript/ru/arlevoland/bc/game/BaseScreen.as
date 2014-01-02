package ru.arlevoland.bc.game {
import flash.display.Sprite;
import flash.events.Event;

public class BaseScreen extends Sprite {

    public function BaseScreen() {
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }

    protected function onAddedToStage(e:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        //Do nothing
    }

    protected function onRemovedFromStage(e:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }

    public function pause():void {
        _paused = !_paused;
    }

    protected var _paused:Boolean;

}
}
