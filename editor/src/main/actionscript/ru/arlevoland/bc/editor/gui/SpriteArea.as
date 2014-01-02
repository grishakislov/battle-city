/**
 * @author arlechin
 * Date: 01.07.12
 * Time: 14:19
 */
package ru.arlevoland.bc.editor.gui {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.editor.GameSettings;

public class SpriteArea extends Sprite {

    public static const COLOR:Number = 0x7859ff33;


    public function SpriteArea() {
        _bitmap = new Bitmap(new BitmapData(128, 128, true, 0x00000000));
        addChild(_bitmap);
    }

    public function drawArea(start:Point, size:int):void {
        clearArea();
        var tileSize:int = GameSettings.TILE_SIZE;
        for (var i:int = 0; i < size; i++) {
            _bitmap.bitmapData.fillRect(new Rectangle(start.x, start.y, tileSize, tileSize), COLOR);
            start.x += tileSize;
        }
    }

    private function clearArea():void {
        _bitmap.bitmapData = new BitmapData(128, 128, true, 0x00000000);
    }

    private var _bitmap:Bitmap;

}
}
