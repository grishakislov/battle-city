package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.geom.Point;

import ru.arlevoland.bc.game.battle_screen.world.Actor;
import ru.arlevoland.bc.game.battle_screen.world.World;

public class BulletData {

    public function BulletData(tank:Actor, world:World) {
        this.tank = tank;
        this.world = world;
    }

    public function getTank():Actor {
        return tank;
    }

    public function getWorld():World {
        return world;
    }

    private var tank:Actor;
    private var world:World;

}
}
