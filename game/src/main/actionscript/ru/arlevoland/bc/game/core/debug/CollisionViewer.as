/**
 * @author arlechin
 * Date: 30.09.12
 * Time: 17:50
 */
package ru.arlevoland.bc.game.core.debug {
import flash.display.Bitmap;
import flash.display.BitmapData;

import ru.arlevoland.bc.game.battlestage.tank.PlayerTank;
import ru.arlevoland.bc.game.battlestage.battleground.Battleground;

public class CollisionViewer extends PlayerTank {


    public function CollisionViewer(tankLevel:uint, world:Battleground) {
        super(tankLevel, world);
    }

    private var _test1:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA00FF00));

    private var _test2:Bitmap = new Bitmap(new BitmapData(8, 8, true, 0xAA0000BB));

}
}
