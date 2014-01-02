/**
 * @author arlechin
 * Date: 30.05.12
 * Time: 9:04
 */
package ru.arlevoland.bc.game.bcb.model {
import ru.arlevoland.bc.GameSettings;

public class LevelData {

    public function LevelData(id:uint):void {
        _levelId = id;
    }

    public function getDataAt(x:uint, y:uint):uint {
        return _levelData[x + y * GameSettings.WORLD_WIDTH];
    }

    public function get levelData():Array {
        return _levelData;
    }

    public function set levelData(value:Array):void {
        _levelData = value;
    }

    public function get levelId():uint {
        return _levelId;
    }

    private var _levelId:uint;
    private var _levelData:Array = [];
}
}
