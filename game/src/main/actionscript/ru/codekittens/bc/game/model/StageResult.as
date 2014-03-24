package ru.codekittens.bc.game.model {
import ru.codekittens.bc.game.battle_screen.tank.PlayerTankLevel;

public class StageResult {

    public var score:uint;
    public var playerLevel:uint;
    public var finishedStageId:uint;

    public function getNextLevelId():uint {
        //TODO: cycle levels
        return finishedStageId + 1;
    }

    public static function createBlankStageResult():StageResult {
        var result:StageResult = new StageResult();
        result.score = 0;
        result.playerLevel = PlayerTankLevel.LEVEL_1;
        result.finishedStageId = 0;
        return result;
    }

}
}
