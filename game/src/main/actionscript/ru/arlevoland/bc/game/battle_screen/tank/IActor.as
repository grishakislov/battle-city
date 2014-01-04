package ru.arlevoland.bc.game.battle_screen.tank {
import flash.geom.Point;

internal interface IActor {

    function getType():ActorType;

    function getPosition():Point;

    function getMovement():TankDirection;

}
}
