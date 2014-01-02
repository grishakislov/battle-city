/**
 * @author arlechin
 * Date: 31.05.12
 * Time: 22:49
 */
package ru.arlevoland.bc.game.model {
import ru.arlevoland.bc.game.battlestage.tank.PlayerTankLevel;

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
