package ru.codekittens.bc.game.battle_screen.world.score {
import ru.codekittens.bc.game.core.animation.FrameSkipObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;

public class ScoreView extends FrameSkipObject {

    public function ScoreView(asset:TileAsset) {
        super (asset, 64);
        addChild(getAsset());
    }

    override protected function onAnimation():void {
        removeChild(getAsset());
        if (parent != null && parent.contains(this)) {
            parent.removeChild(this);
        }
        destroy();
    }
}
}
