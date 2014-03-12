package ru.codekittens.bc.game.core.debug {
import flash.display.Bitmap;
import flash.display.BitmapData;

import ru.codekittens.bc.game.battle_screen.tank.PlayerTank;
import ru.codekittens.bc.game.battle_screen.world.World;

public class CollisionViewer extends PlayerTank {


    public function CollisionViewer(tankLevel:uint, world:World) {
        super(tankLevel, world);
    }

    private var test1:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA00FF00));

    private var test2:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA0000BB));

}
}
