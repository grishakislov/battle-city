package ru.codekittens.bc.game.keyboard.key {
import flash.ui.Keyboard;

public class DefaultBindings {

    public static function getDefaultBindings():Object {
        var result:Object = new Object();
        result[KeyCommand.UP.getCommandId()] = new KeyBinding(KeyCommand.UP, [Keyboard.UP, Keyboard.NUMPAD_8]);
        result[KeyCommand.RIGHT.getCommandId()] = new KeyBinding(KeyCommand.RIGHT, [Keyboard.RIGHT, Keyboard.NUMPAD_6]);
        result[KeyCommand.DOWN.getCommandId()] = new KeyBinding(KeyCommand.DOWN, [Keyboard.DOWN, Keyboard.NUMPAD_2]);
        result[KeyCommand.LEFT.getCommandId()] = new KeyBinding(KeyCommand.LEFT, [Keyboard.LEFT, Keyboard.NUMPAD_4]);
        result[KeyCommand.FIRE.getCommandId()] = new KeyBinding(KeyCommand.FIRE, [Keyboard.SPACE, Keyboard.CONTROL]);
        result[KeyCommand.ENTER.getCommandId()] = new KeyBinding(KeyCommand.ENTER, [Keyboard.ENTER]);

        result[KeyCommand.PAUSE.getCommandId()] = new KeyBinding(KeyCommand.PAUSE, ["p".charCodeAt(0),
            "P".charCodeAt(0),
            "з".charCodeAt(0),
            "З".charCodeAt(0)]);

        result[KeyCommand.MODE1.getCommandId()] = new KeyBinding(KeyCommand.MODE1, ["1".charCodeAt(0)]);
        result[KeyCommand.MODE2.getCommandId()] = new KeyBinding(KeyCommand.MODE2, ["2".charCodeAt(0)]);
        result[KeyCommand.MODE3.getCommandId()] = new KeyBinding(KeyCommand.MODE3, ["3".charCodeAt(0)]);

        result[KeyCommand.GRID_TRIGGER.getCommandId()] = new KeyBinding(KeyCommand.GRID_TRIGGER, ["G".charCodeAt(0),
            "g".charCodeAt(0),
            "П".charCodeAt(0),
            "п".charCodeAt(0)]);

        result[KeyCommand.IMPACT_TRIGGER.getCommandId()] = new KeyBinding(KeyCommand.IMPACT_TRIGGER, ["D".charCodeAt(0),
            "d".charCodeAt(0),
            "В".charCodeAt(0),
            "в".charCodeAt(0)]);
        return result;
    }

}
}
