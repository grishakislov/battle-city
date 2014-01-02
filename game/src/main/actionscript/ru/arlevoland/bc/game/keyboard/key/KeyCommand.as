/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 16:20
 */
package ru.arlevoland.bc.game.keyboard.key {
public class KeyCommand {

    public static const UP:KeyCommand = new KeyCommand("UP");
    public static const RIGHT:KeyCommand = new KeyCommand("RIGHT");
    public static const DOWN:KeyCommand = new KeyCommand("DOWN");
    public static const LEFT:KeyCommand = new KeyCommand("LEFT");
    public static const FIRE:KeyCommand = new KeyCommand("FIRE");

    public static const ENTER:KeyCommand = new KeyCommand("ENTER");
    public static const PAUSE:KeyCommand = new KeyCommand("PAUSE");
    public static const MODE1:KeyCommand = new KeyCommand("MODE1");
    public static const MODE2:KeyCommand = new KeyCommand("MODE2");
    public static const MODE3:KeyCommand = new KeyCommand("MODE3");
    public static const GRID_TRIGGER:KeyCommand = new KeyCommand("GRID_TRIGGER");


    public function KeyCommand(command:String) {
        _command = command;
    }


    public function getCommandId():String {
        return _command;
    }

    private var _command:String;

}
}
