package ru.codekittens.bc.game.battle_screen.bullet {
import ru.codekittens.bc.game.battle_screen.world.Actor;
import ru.codekittens.bc.game.battle_screen.world.World;

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
