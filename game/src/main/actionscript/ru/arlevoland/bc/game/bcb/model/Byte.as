/**
 * @author arlechin
 * Date: 02.07.12
 * Time: 23:46
 */
package ru.arlevoland.bc.game.bcb.model {
public class Byte {

    private var _value:uint;

    public function Byte(value:uint) {
        this._value = value;
    }

    public function get low():uint {
        return (_value & 0x0F);
    }

    public function get high():uint {
        return (_value & 0xF0) >> 4;
    }

    public function set value(value:uint):void {
        _value = value;
    }

    public function get value():uint {
        return _value;
    }
}
}
