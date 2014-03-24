package ru.codekittens.bc.game.battle_screen.bonus {
import ru.codekittens.bc.game.core.animation.FrameSkipObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;

public class BonusView extends FrameSkipObject {

    private var asset:TileAsset;

    public function BonusView(asset:TileAsset) {
        super(9);
        this.asset = asset;
        addChild(asset);
    }

    override protected function onAnimation():void {
        super.onAnimation();
        asset.visible = !asset.visible;
    }


}
}
