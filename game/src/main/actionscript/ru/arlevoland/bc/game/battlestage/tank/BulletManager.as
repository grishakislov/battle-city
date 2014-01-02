/**
 * @author arlechin
 * Date: 30.09.12
 * Time: 20:48
 */
package ru.arlevoland.bc.game.battlestage.tank {
import flash.display.Sprite;

import ru.arlevoland.bc.game.GameSettings;

public class BulletManager {
    public function BulletManager() {
    }

    public function shoot(direction:TankDirection, tank:ITank):void {

        switch (tank.getType()) {
            case ActorType.PLAYER:
                player = tank;
                var bullet:Bullet = createPlayerBullet(direction, player);
                if (bullet)
                    bulletLayer.addChild(bullet);
                playerBullets++;
                break;
        }

    }

    private function createPlayerBullet(direction:TankDirection, tank:ITank):Bullet {
        var bullet:Bullet;
        var data:BulletData;
        switch (tank.getLevel()) {
            case PlayerTankLevel.LEVEL_1:
                if (playerBullets < GameSettings.LEVEL_1_BULLETS) {
                    data = new BulletData(direction, tank.getPosition(), tank.getBulletCollisionTable());
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
    private var player:ITank;
    private var ai:IActor;
    private var playerBullets:uint = 0;
}
}
