/**
 * @author arlechin
 * Date: 09.08.12
 * Time: 20:07
 */
package ru.arlevoland.bc.game.battlestage.battleground {
import flash.display.Bitmap;
import flash.display.Sprite;

import ru.arlevoland.bc.game.battlestage.BattleStageDrawMode;
import ru.arlevoland.bc.game.battlestage.BattleStageLoader;

internal class WorldTreeLayer extends Sprite {

    public function initialize(levelId:uint):void {
        _visual = BattleStageLoader.drawStageToBitmap(levelId, BattleStageDrawMode.TREES);
        addChild(_visual);
    }

    private var _visual:Bitmap;

}
}
