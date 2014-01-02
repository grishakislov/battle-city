package ru.arlevoland.bc.game.battlestage.battle_stage_preloader {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.animation.AnimatedObject;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.core.assets.model.TilePalette;

internal class BattlestagePreloaderView extends AnimatedObject {

    public function BattlestagePreloaderView() {
        super();
        var screenSize:Point = GameSettings.NATIVE_NES_SCREEN_SIZE;

        top = drawHalfScreenRect();
        top.y -= top.height;
        addChild(top);

        bottom = drawHalfScreenRect();
        bottom.y = screenSize.y;
        addChild(bottom);

        setPixelsPerSecond(GameSettings.PRELOADER_SPEED);
    }

    private function drawHalfScreenRect():Bitmap {
        var result:Bitmap = new Bitmap();
        var screenSize:Point = GameSettings.NATIVE_NES_SCREEN_SIZE;
        var halfHeight:uint = screenSize.y / 2;
        result.bitmapData = new BitmapData(screenSize.x, halfHeight, false, TilePalette.KEY_COLOR_0);
        return result;
    }

    public function setLevel(value:int):void {
        var stringValue:String = value < 10 ? (" " + value) : value.toString()
        text = FontTool.drawLine("STAGE" + " " + stringValue, TilePalette.PRELOADER_FONT);
        centerText();
        addChild(text);
        text.visible = false;
    }

    private function centerText():void {
        var textWidth:uint = text.width;
        var textHeight:uint = text.height;
        var screenSize:Point = GameSettings.NATIVE_NES_SCREEN_SIZE;
        var xCoord:uint = Math.round(screenSize.x / 2 - textWidth / 2);
        var yCoord:uint = Math.round(screenSize.y / 2 - textHeight / 2);
        text.x = xCoord;
        text.y = yCoord;
    }

    override protected function onAnimation(delta:uint):void {
        super.onAnimation(delta);
        if (isPreloaderAnimationInProgress(delta)) {
            top.y += delta;
            bottom.y -= delta;
        } else {
            top.y = 0;
            bottom.y = bottom.height;
            text.visible = true;
        }
    }

    private function isPreloaderAnimationInProgress(delta:uint):Boolean {
        return top.y + delta < 0;
    }

    override public function getPixelsPerSecond():uint {
        return super.getPixelsPerSecond();
    }

    override public function destroy():void {
        super.destroy();
    }

    private var top:Bitmap;
    private var bottom:Bitmap;
    private var text:Bitmap;

}
}
