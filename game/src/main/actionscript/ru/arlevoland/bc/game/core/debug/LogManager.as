/**
 * @author arlechin
 * Date: 30.05.12
 * Time: 7:57
 */
package ru.arlevoland.bc.game.core.debug {
import flash.utils.getTimer;

public class LogManager {

    public function showMessage(messageType:String):void {
        _milliseconds = getTimer();
        trace("[" + parseTime() + "] " + messageType);
    }

    private function parseTime():String {
        var seconds:Number = Math.floor(_milliseconds / 1000);
        var milliseconds:Number = _milliseconds - (seconds * 1000);
        var minutes:Number = Math.floor(seconds / 60);
        var hours:Number = Math.floor(minutes / 60);
        var sec:String = seconds < 10 ? "0" + seconds.toString() : seconds.toString();
        var min:String = minutes < 10 ? "0" + minutes.toString() : minutes.toString();
//        var hrs:String = hours < 10 ? "0" + hours.toString() : hours.toString();
        return hours.toString() + ":" + min + ":" + sec + "." + milliseconds.toString();
    }

    private var _milliseconds:Number;
}
}
