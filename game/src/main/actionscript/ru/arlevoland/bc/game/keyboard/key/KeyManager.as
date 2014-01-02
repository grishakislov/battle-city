package ru.arlevoland.bc.game.keyboard.key {
public class KeyManager {

    public function initialize():void {
        _bindings = DefaultBindings.getDefaultBindings();
    }

    public function getCommandByKey(keyCode:uint):KeyCommand {
        for each (var k:KeyBinding in _bindings) {
            if (k.getKeys().indexOf(keyCode) > -1) return k.getCommand();
        }
        return null;
    }

    private var _bindings:Object;

}
}
