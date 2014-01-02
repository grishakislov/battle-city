/**
 * @author arlechin
 * Date: 30.09.12
 * Time: 23:11
 */
package ru.arlevoland.bc.game.battlestage.tank {
import flash.geom.Point;

public interface ITank extends IActor {

    function getLevel():uint;

    [Deprecated] function getWorldPosition():Point;

    function getBulletCollisionTable():Array;
}
}
