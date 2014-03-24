package ru.codekittens.bc.game.battle_screen.bonus {
import ru.codekittens.bc.game.core.animation.FrameSkipObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;

public class BonusView extends FrameSkipObject {

    public function BonusView(asset:TileAsset) {
        super(asset, 9);
        addChild(asset);
    }

    override protected function onAnimation():void {
        super.onAnimation();
        getAsset().visible = !getAsset().visible;
    }


}
}
