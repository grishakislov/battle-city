package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.world.IActor;
import ru.arlevoland.bc.game.battle_screen.world.World;

public class BulletData {

    public function BulletData(actor:IActor, world:World) {
        this.actor = actor;
        this.world = world;
    }

    public function getActor():IActor {
        return actor;
    }

    public function getWorld():World {
        return world;
    }

    private var actor:IActor;
    private var world:World;

}
}
