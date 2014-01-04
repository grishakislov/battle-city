package ru.arlevoland.bc.game.battle_screen.tank {
import flash.geom.Point;

public interface ITank extends IActor {

    function getLevel():uint;

    [Deprecated] function getWorldPosition():Point;

    function getBulletCollisionTable():Array;
}
}
