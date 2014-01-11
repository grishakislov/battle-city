package ru.arlevoland.bc.game.battle_screen.world {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

public interface IActor {

    function getLevel():uint;

    function getType():ActorType;

    function getPosition():Point;

    function getDirection():ActorDirection;

}
}
