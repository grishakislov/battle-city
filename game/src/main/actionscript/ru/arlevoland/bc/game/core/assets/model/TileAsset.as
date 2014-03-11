package ru.arlevoland.bc.game.core.assets.model {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

public class TileAsset extends Sprite {

    public function TileAsset(name:String, data:Bitmap):void {
        tileName = name;
        bitmap = data;
        initialize();
    }

    private function initialize():void {
        addChild(bitmap);
        rectangle = new Rectangle(0, 0, width, height);
        point = new Point(0, 0);
        bitmap.bitmapData.threshold(bitmap.bitmapData, rectangle, point, "==", TilePalette.KEY_COLOR_ALPHA, 0x00000000); //Делаем черный цвет прозрачным
        currentKeyColors.push(TilePalette.KEY_COLOR_0, TilePalette.KEY_COLOR_1, TilePalette.KEY_COLOR_2);
    }

    public function setPalette(palette:TilePalette):void {
        if (currentPalette != null && currentPalette.getName() == palette.getName()) {
//            GameWarning.paletteAlreadyApplied(palette.name, _name);
            return;
        }
        bitmap.bitmapData.threshold(bitmap.bitmapData, rectangle, point, "==", currentKeyColors[0], palette.getColor0());
        bitmap.bitmapData.threshold(bitmap.bitmapData, rectangle, point, "==", currentKeyColors[1], palette.getColor1());
        bitmap.bitmapData.threshold(bitmap.bitmapData, rectangle, point, "==", currentKeyColors[2], palette.getColor2());
        currentPalette = palette;
        currentKeyColors = [palette.getColor0(), palette.getColor1(), palette.getColor2()];
    }

    public function getName():String {
        return tileName;
    }

    public function getBitmap():Bitmap {
        return bitmap;
    }

    public function getClone():TileAsset {
        var result:TileAsset;
        result = new TileAsset(tileName, new Bitmap(bitmap.bitmapData.clone()));
        result.setPalette(currentPalette);
        return result;
    }

    private var tileName:String;
    private var currentKeyColors:Array = [];
    private var bitmap:Bitmap;
    private var currentPalette:TilePalette;
    private var rectangle:Rectangle;
    private var point:Point;

}
}
