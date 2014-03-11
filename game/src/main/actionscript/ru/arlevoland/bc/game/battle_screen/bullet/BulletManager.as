package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.display.Sprite;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.battle_screen.bullet.Bullet;
import ru.arlevoland.bc.game.battle_screen.bullet.BulletData;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.Actor;
import ru.arlevoland.bc.game.battle_screen.world.World;

public class BulletManager {
    public function BulletManager() {
    }

    public function shoot(tank:BaseTank, world:World):void {

        switch (tank.getType()) {
            case ActorType.PLAYER:
                var bullet:Bullet = createPlayerBullet(tank, world);
                if (bullet)
                    bulletLayer.addChild(bullet);
                playerBullets++;
                break;
        }

    }

    private function createPlayerBullet(tank:BaseTank, world:World):Bullet {
        var bullet:Bullet;
        switch (tank.getLevel()) {
            case PlayerTankLevel.LEVEL_1:
                if (playerBullets < GameSettings.LEVEL_1_BULLETS) {
                    bullet = new Bullet(tank, world);
                    return bullet;
                }
                break;
            case PlayerTankLevel.LEVEL_2:
            case PlayerTankLevel.LEVEL_3:
            case PlayerTankLevel.LEVEL_4:
                break;
        }

        return null;
    }

    public static function getBulletLayer():Sprite {
        return bulletLayer;
    }

    private static var bulletLayer:Sprite = new Sprite();
    private var player:Actor;
    private var ai:Actor;
    private var playerBullets:uint = 0;
}
}
