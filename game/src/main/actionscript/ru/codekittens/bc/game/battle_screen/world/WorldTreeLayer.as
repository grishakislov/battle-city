package ru.codekittens.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.Sprite;

import ru.codekittens.bc.game.battle_screen.BattleStageDrawMode;
import ru.codekittens.bc.game.battle_screen.map_loader.MapLoader;

internal class WorldTreeLayer extends Sprite {

    public function initialize(levelId:uint):void {
        _visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.TREES);
        addChild(_visual);
    }

    private var _visual:Bitmap;

}
}
