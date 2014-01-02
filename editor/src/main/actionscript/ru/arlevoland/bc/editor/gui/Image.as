package ru.arlevoland.bc.editor.gui {
import flash.display.Bitmap;
import flash.display.Sprite;

import ru.arlevoland.bc.editor.Resources;

internal class Image extends Sprite {

    public function Image(type:String):void {
        _type = type;
        switch (type) {
            case SpriteImageType.TILES:
                _bitmap = new Resources.TILES();
                addChild(_bitmap);
                break;
            case SpriteImageType.TANKS:
                _bitmap = new Resources.TANKS();
                addChild(_bitmap);
                break;
        }
    }

    private var _bitmap:Bitmap;
    private var _type:String;
}
}
