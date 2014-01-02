package ru.arlevoland.bc.game.core.debug {
import flash.display.Bitmap;
import flash.display.Sprite;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;

public class DevTools extends Sprite {


    public function initialize():void {
        _devLayer = new Sprite();
        addChild(_devLayer);
    }

    public function testSpriteByName(spriteName:String):void {
        reset();
        var bitmap:Bitmap;
        var tileAsset:TileAsset = App.assetManager.getTileAsset(spriteName);
        bitmap = tileAsset.getBitmap();
        bitmap.x = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.x / 2 - tileAsset.getBitmap().width / 2);
        bitmap.y = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.y / 2 - tileAsset.getBitmap().height / 2);
        _devLayer.addChild(bitmap);
    }

    public function testSpriteByIndex(index:int):void {
        reset();
        var bitmap:Bitmap;
        var tileAsset:TileAsset = App.assetManager.getTileAssetByIndex(index);
        bitmap = tileAsset.getBitmap();
        bitmap.x = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.x / 2 - tileAsset.getBitmap().width / 2);
        bitmap.y = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.y / 2 - tileAsset.getBitmap().height / 2);
        _devLayer.addChild(bitmap);
    }


    public function testFont(string:String):void {
        reset();
        var bitmap:Bitmap;
        bitmap = FontTool.drawLine(string);
        bitmap.x = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.x / 2 - bitmap.width / 2);
        bitmap.y = Math.round(GameSettings.NATIVE_NES_SCREEN_SIZE.y / 2 - bitmap.height / 2);
        _devLayer.addChild(bitmap);
    }

    public function reset():void {
        while (_devLayer.numChildren > 0) {
            _devLayer.removeChildAt(0);
        }
    }

    /*
     kill
     godMode

     */

    private var _devLayer:Sprite;
}
}
