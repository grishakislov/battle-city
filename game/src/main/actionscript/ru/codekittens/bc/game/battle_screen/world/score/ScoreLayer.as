package ru.codekittens.bc.game.battle_screen.world.score {
import flash.display.Sprite;
import flash.geom.Point;

import ru.codekittens.bc.game.App;

import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.core.debug.GameError;

public class ScoreLayer extends Sprite {
    public function ScoreLayer() {
    }

    public function showScore(value:uint, point:Point):void {
        var asset:TileAsset = App.assetManager.copyTileAsset("BONUS_" + value);
        if (asset == null) {
            GameError.invalidAssetId("BONUS_" + value);
        }
        var score:ScoreView = new ScoreView(asset);
        score.x = point.x;
        score.y = point.y;
        addChild(score);
    }
}
}
