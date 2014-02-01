package ru.arlevoland.bc.game.core.assets {
import ru.arlevoland.bc.game.core.debug.GameError;
import ru.arlevoland.bc.game.json.JsonHelper;
import ru.arlevoland.bc.game.json.model.LevelData;

public class LevelDataManager {

    public function initialize():void {
        levels = JsonHelper.getLevels();
        parseData();
    }

    private function parseData():void {
        for each (var data:LevelData in levels) {
            data.levelData = [];
            for (var i:int = 0; i < data.data.length; i++) {
                data.levelData.push(AssetHelper.convertStringToHex(data.data.charAt(i)))
            }
        }
    }

    public function getLevelDataByID(levelID:uint):LevelData {
        if (levelID > levels.length) {
            GameError.invalidLevelId(levelID);
        }
        return levels[levelID - 1];
    }

    public function getLevelsTotal():uint {
        return levels.length;
    }

    [ArrayElementType("ru.arlevoland.bc.game.json.model.LevelData")]
    private var levels:Array = [];

}
}
