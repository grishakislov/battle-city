/**
 * @author arlechin
 * Date: 04.07.12
 * Time: 23:10
 */
package ru.arlevoland.bc.game.core.assets.model {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.core.debug.GameWarning;

public class TileAsset extends Sprite {

    public function TileAsset(name:String, data:Bitmap):void {
        _name = name;
        _bitmap = data;
        initialize();
    }

    private function initialize():void {
        addChild(_bitmap);
        _rectangle = new Rectangle(0, 0, width, height);
        _point = new Point(0, 0);
        _bitmap.bitmapData.threshold(_bitmap.bitmapData, _rectangle, _point, "==", TilePalette.KEY_COLOR_ALPHA, 0x00000000); //Делаем черный цвет прозрачным
        _currentKeyColors.push(TilePalette.KEY_COLOR_0, TilePalette.KEY_COLOR_1, TilePalette.KEY_COLOR_2);
    }

    public function setPalette(palette:TilePalette):void {
        if (_currentPalette != null && _currentPalette.name == palette.name) {
//            GameWarning.paletteAlreadyApplied(palette.name, _name);
            return;
        }
        _bitmap.bitmapData.threshold(_bitmap.bitmapData, _rectangle, _point, "==", _currentKeyColors[0], palette.color0);
        _bitmap.bitmapData.threshold(_bitmap.bitmapData, _rectangle, _point, "==", _currentKeyColors[1], palette.color1);
        _bitmap.bitmapData.threshold(_bitmap.bitmapData, _rectangle, _point, "==", _currentKeyColors[2], palette.color2);
        _currentPalette = palette;
        _currentKeyColors = [palette.color0, palette.color1, palette.color2];
    }

    public function getName():String {
        return _name;
    }

    public function getBitmap():Bitmap {
        return _bitmap;
    }

    public function getClone():TileAsset {
        var result:TileAsset;
        result = new TileAsset(_name, new Bitmap(_bitmap.bitmapData.clone()));
        result.setPalette(_currentPalette);
        return result;
    }

    private var _name:String;
    private var _currentKeyColors:Array = [];
    private var _bitmap:Bitmap;
    private var _currentPalette:TilePalette;
    private var _rectangle:Rectangle;
    private var _point:Point;

}
}
