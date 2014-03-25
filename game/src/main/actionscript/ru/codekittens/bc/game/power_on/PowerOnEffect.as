package ru.codekittens.bc.game.power_on {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameScreen;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.core.assets.Resources;
import ru.codekittens.bc.game.events.GameEvent;
import ru.codekittens.bc.game.time.Ticker;

public class PowerOnEffect extends GameScreen {

    private static const PAUSE:uint = 60;
    private static const PHASE_1:uint = 5;
    private static const PHASE_2:uint = 10;
    private static const PHASE_3:uint = 13;
    private static const PHASE_4:uint = 25;

    override public function run(data:* = undefined):void {
        var width:int = GameSettings.NATIVE_NES_SCREEN_SIZE.x;
        var height:int = GameSettings.NATIVE_NES_SCREEN_SIZE.y;

        frameLength = Math.round(1000 / stage.frameRate);
        bigBitmap = new Bitmap(new BitmapData(width, height, true, 0x77FFFFFF))
        smallBitmap = new Bitmap(new BitmapData(8, 8));
        var tanks:Bitmap = new Resources.TANKS();
        smallBitmap.bitmapData.copyPixels(tanks.bitmapData, new Rectangle(8,0,8,8), new Point (0,0));

        Ticker.addTickListener(onTick);
    }

    override public function destroy():* {
        Ticker.removeTickListener(onTick);
        parent.removeChild(this);
    }

    override protected function onTick(dt:uint):void {
        switch (currentFrame) {
            case PAUSE:
                App.sfxManager.playClick();
                removeChildren();
                addChild(bigBitmap);
                break;
            case PAUSE + PHASE_1:
                removeChildren();
                break;
            case PAUSE + PHASE_2:
                removeChildren();
                addChild(smallBitmap);
                break;
            case PAUSE + PHASE_3:
                removeChildren();
                break;
            case PAUSE + PHASE_4:
                App.dispatcher.dispatchEvent(new GameEvent(GameEvent.SCREEN_FINISHED, this));
                break;
        }

        currentFrame++;
    }

    private var currentFrame:Number = 0;
    private var frameLength:Number;
    private var bigBitmap:Bitmap;
    private var smallBitmap:Bitmap;
}
}
