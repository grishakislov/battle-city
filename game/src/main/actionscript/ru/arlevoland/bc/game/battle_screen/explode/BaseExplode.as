package ru.arlevoland.bc.game.battle_screen.explode {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.core.animation.AnimatedObject;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;

public class BaseExplode extends AnimatedObject {

    protected var explodeSequence:Array;
    protected var visual:TileAsset;
    protected var explodeSequenceIndex:uint = 0;

    private var explodeSequenceFramesSkip:uint = 4;
    private var framesSkipped:uint = 0;

    public function BaseExplode() {
        framesSkipped = explodeSequenceFramesSkip;
    }


    override protected function onAnimation(delta:uint):void {
        if (framesSkipped >= explodeSequenceFramesSkip) {
            if (explodeSequenceIndex == explodeSequence.length) {
                onExploded();
                return;
            }
            framesSkipped = 0;
            updateExplodeVisualAsset(explodeSequenceIndex);
            explodeSequenceIndex++;
        }
        framesSkipped++;
    }

    private function updateExplodeVisualAsset(index:int):void {
        if (visual != null) {
            if (contains(visual)) removeChild(visual);
            visual.getBitmap().bitmapData.dispose();
        }
        visual = App.assetManager.getTileAsset(explodeSequence[index]).getClone();
        addChild(visual);
    }

    private function onExploded():void {
        destroy();
    }
}
}
