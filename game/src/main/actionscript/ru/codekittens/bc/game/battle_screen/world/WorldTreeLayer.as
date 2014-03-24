package ru.codekittens.bc.game.battle_screen.world {
import flash.display.Bitmap;
import flash.display.Sprite;

import ru.codekittens.bc.game.battle_screen.BattleStageDrawMode;
import ru.codekittens.bc.game.battle_screen.map_loader.MapLoader;

internal class WorldTreeLayer extends Sprite {

    public function initialize(levelId:uint):void {
        visual = MapLoader.drawStageToBitmap(levelId, BattleStageDrawMode.TREES);
        addChild(visual);
    }

    private var visual:Bitmap;

}
}
