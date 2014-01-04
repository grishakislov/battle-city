package ru.arlevoland.bc.game.keyboard.key {
public class KeyManager {

    public function initialize():void {
        bindings = DefaultBindings.getDefaultBindings();
    }

    public function getCommandByKey(keyCode:uint):KeyCommand {
        for each (var k:KeyBinding in bindings) {
            if (k.getKeys().indexOf(keyCode) > -1) return k.getCommand();
        }
        return null;
    }

    private var bindings:Object;

}
}
