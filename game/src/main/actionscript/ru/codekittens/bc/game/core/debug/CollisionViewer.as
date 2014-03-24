package ru.codekittens.bc.game.core.debug {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import ru.codekittens.bc.game.battle_screen.world.World;

public class CollisionViewer extends Sprite {


    public function CollisionViewer(tankLevel:uint, world:World) {

    }

    private var test1:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA00FF00));

    private var test2:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA0000BB));

}
}
