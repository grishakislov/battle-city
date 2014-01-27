package ru.arlevoland.bc.bcb - model {
import ru.arlevoland.bc.GameSettings;

public class LevelData {

    public function LevelData(id:uint):void {
        levelId = id;
    }

    public function getDataAt(x:uint, y:uint):uint {
        return levelData[x + y * GameSettings.WORLD_WIDTH];
    }

    public function getLevelData():Array {
        return levelData;
    }

    public function setLevelData(value:Array):void {
        levelData = value;
    }

    public function getLevelId():uint {
        return levelId;
    }

    private var levelId:uint;
    private var levelData:Array = [];
}
}
