package ru.arlevoland.bc.game.battle_screen.bullet {
import ru.arlevoland.bc.game.battle_screen.tank.*;

import flash.display.Sprite;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.battle_screen.bullet.Bullet;
import ru.arlevoland.bc.game.battle_screen.bullet.BulletData;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.battle_screen.world.IActor;

public class BulletManager {
    public function BulletManager() {
    }

    public function shoot(tank:IActor):void {

        switch (tank.getType()) {
            case ActorType.PLAYER:
                var bullet:Bullet = createPlayerBullet(tank);
                if (bullet)
                    bulletLayer.addChild(bullet);
                playerBullets++;
                break;
        }

    }

    private function createPlayerBullet(tank:IActor):Bullet {
        var bullet:Bullet;
        var data:BulletData;
        switch (tank.getLevel()) {
            case PlayerTankLevel.LEVEL_1:
                if (playerBullets < GameSettings.LEVEL_1_BULLETS) {
                    data = new BulletData(tank.getDirection(), tank.getPosition(), tank.getLevel());
                    bullet = new Bullet(data);
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
    private var player:IActor;
    private var ai:IActor;
    private var playerBullets:uint = 0;
}
}
