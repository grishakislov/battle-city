package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.world.Actor;
import ru.arlevoland.bc.game.battle_screen.world.World;

public class BulletData {

    public function BulletData(actor:Actor, world:World) {
        this.actor = actor;
        this.world = world;
    }

    public function getActor():Actor {
        return actor;
    }

    public function getWorld():World {
        return world;
    }

    private var actor:Actor;
    private var world:World;

}
}
