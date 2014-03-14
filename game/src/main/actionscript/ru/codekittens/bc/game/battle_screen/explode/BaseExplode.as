package ru.codekittens.bc.game.battle_screen.explode {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.time.Ticker;

public class BaseExplode extends GameObject {

    protected var explodeSequence:Array;
    protected var visual:TileAsset;
    protected var explodeSequenceIndex:uint = 0;

    private var explodeSequenceFramesSkip:uint = 4;
    private var framesSkipped:uint = 0;

    public function BaseExplode() {
        framesSkipped = explodeSequenceFramesSkip;
        Ticker.addTickListener(onTick);
    }


    override public function togglePause():void {
        super.togglePause();
        if (paused) {
            Ticker.removeTickListener(onTick);
        } else {
            Ticker.addTickListener(onTick);
        }
    }

    protected function onTick(dt:uint):void {
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
        clearVisual();
        visual = App.assetManager.getTileAsset(explodeSequence[index]).getClone();
        addChild(visual);
    }

    private function clearVisual():void {
        if (visual != null) {
            if (contains(visual)) removeChild(visual);
            visual.getBitmap().bitmapData.dispose();
        }
    }

    private function onExploded():void {
        Ticker.removeTickListener(onTick);
        clearVisual();
        destroy();
    }
}
}
