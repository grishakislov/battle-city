package ru.codekittens.bc.game.battle_screen.tank {
import flash.events.EventDispatcher;

import ru.codekittens.bc.game.keyboard.key.KeyCommand;

public class BaseTankController extends EventDispatcher {

    public function initialize():void {

    }

    protected function start(command:KeyCommand):void {
        dispatchEvent(new TankControllerEvent(TankControllerEvent.START, command));
    }

    protected function stop(command:KeyCommand):void {
        dispatchEvent(new TankControllerEvent(TankControllerEvent.STOP, command));
    }


}
}
