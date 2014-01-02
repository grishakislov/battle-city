/**
 * @author arlechin
 * Date: 08.07.12
 * Time: 20:04
 */
package ru.arlevoland.bc.game {
import flash.display.Sprite;
import flash.events.Event;

public class GameObject extends Sprite {
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

    public function pause():void {
        _paused = !_paused;
    }

    protected var _paused:Boolean;
}
}
