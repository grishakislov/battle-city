package ru.arlevoland.bc.game.core.assets {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.bcb.model.LevelData;
import ru.arlevoland.bc.game.core.debug.GameError;

public class LevelDataManager {

    public function initialize():void {
        levels = App.bcbLoader.levels;
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

    [ArrayElementType("ru.arlevoland.bc.game.bcb.model.LevelData")]
    private var levels:Array = [];

}
}
