package ru.arlevoland.bc.game.battle_screen.world {
import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.tank.*;

public interface Actor {

    function getLevel():uint;

    function getType():ActorType;

    function getPosition():Point;

    function getDirection():ActorDirection;

}
}
