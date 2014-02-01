package ru.arlevoland.bc.game.battle_screen.battle_stage_splash {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.core.animation.AnimatedObject;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.core.assets.model.TilePalette;

internal class SplashView extends AnimatedObject {

    public static const START:String = "start";
    public static const FINISH:String = "finish";
    public static const WAIT:String = "wait";
    public static const PLAY:String = "play";
    public static const WAIT_DELAY:uint = 1000;

    public function SplashView(preloader:BattleStageSplash) {
        super();

        this.preloader = preloader;

        var screenSize:Point = GameSettings.NATIVE_NES_SCREEN_SIZE;

        top = createHalfScreenRect();
        top.y -= top.height;
        addChild(top);

        bottom = createHalfScreenRect();
        bottom.y = screenSize.y;
        addChild(bottom);

        currentAnimation = START;

        setPixelsPerSecond(GameSettings.PRELOADER_SPEED);
    }

    private function createHalfScreenRect():Bitmap {
        var result:Bitmap = new Bitmap();
        var screenSize:Point = GameSettings.NATIVE_NES_SCREEN_SIZE;
        var halfHeight:uint = screenSize.y / 2;
        if (halfScreenBitmapData == null) {
            halfScreenBitmapData = new BitmapData(screenSize.x, halfHeight, false, TilePalette.KEY_COLOR_0);
        }
        result.bitmapData = halfScreenBitmapData;
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

        switch (currentAnimation) {

            case START:
                if (isStartAnimationInProgress(delta)) {
                    top.y += delta;
                    bottom.y -= delta;
                } else {
                    currentAnimation = WAIT;
                    top.y = 0;
                    bottom.y = bottom.height;
                    text.visible = true;

                }
                break;

            case WAIT:
                if (timePassed >= WAIT_DELAY) {
                    currentAnimation = FINISH;
                    text.visible = false;
                    App.sfxManager.playIntro();
                    preloader.onComplete();
                } else {
                    timePassed += lastDt;
                }

                break;

            case FINISH:
                if (isFinishAnimationInProgress(delta)) {
                    top.y -= delta;
                    bottom.y += delta;
                } else {
                    destroy();
                }
        }
    }

    private function isStartAnimationInProgress(delta:uint):Boolean {
        return top.y + delta < 0;
    }

    private function isFinishAnimationInProgress(delta:uint):Boolean {
        return top.y + top.height - delta > 0;
    }

    override public function getPixelsPerSecond():uint {
        return super.getPixelsPerSecond();
    }

    override public function destroy():void {
        super.destroy();
    }

    private var currentAnimation:String;
    private var timePassed:uint = 0;

    private var halfScreenBitmapData:BitmapData;
    private var top:Bitmap;
    private var bottom:Bitmap;
    private var text:Bitmap;
    private var preloader:BattleStageSplash;

}
}
