package ru.arlevoland.bc.editor.gui {
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.editor.GameSettings;

public class Gui extends Sprite {

    private static const SPRITE_IMAGE_X:int = GameSettings.NATIVE_NES_SCREEN_SIZE.x - 128 - 10;
    private static const SPRITE_IMAGE_Y:int = 20;

    public function initialize():void {
        _spriteImage = getSpriteImage();
        addChild(_spriteImage);

        initializeArea();
        _spriteImage.addChild(_spriteArea);
        showArea(new Point(0, 0), 4);
    }

    private function getSpriteImage():Image {
        var result:Image;
        result = new Image(SpriteImageType.DEFAULT);
        result.x = SPRITE_IMAGE_X;
        result.y = SPRITE_IMAGE_Y;
        return result;
    }

    private function initializeArea():void {
        _spriteArea = new SpriteArea();
    }

    private function showArea(start:Point, size:int):void {
        _spriteArea.drawArea(start, size);
    }

    private var _spriteImage:Image;
    private var _spriteArea:SpriteArea;
    private var _btnFitData:Button;
    private var _btnTilesSprite:Button;
    private var _btnTanksSprite:Button;
    private var _selectedSpriteFile:String;

}
}
