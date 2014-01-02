/**
 * @author arlechin
 * Date: 30.09.12
 * Time: 20:50
 */
package ru.arlevoland.bc.game.battlestage.tank {
import flash.geom.Point;

internal interface IActor {

    function getType():ActorType;

    function getPosition():Point;

    function getMovement():TankDirection;

}
}
