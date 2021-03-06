package ru.codekittens.bc.game.battle_screen.bullet {
import flash.display.Sprite;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.tank.*;
import ru.codekittens.bc.game.battle_screen.tank.player.PlayerTankLevel;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.events.TogglePauseEvent;

public class BulletManager {

    private static var bulletLayer:Sprite = new Sprite();
    private var playerBullets:uint = 0;

    public function shoot(tank:BaseTank, world:World):void {

        switch (tank.getType()) {
            case ActorType.PLAYER:
                if (isTankCanShoot(tank)) {
                    var bullet:Bullet = createPlayerBullet(tank, world);
                    bullet.addDestroyCallback(onPlayerBulletDestroyed);
                    bulletLayer.addChild(bullet);
                    playerBullets++;
                }
                break;
        }
    }

    private function isTankCanShoot(tank:BaseTank):Boolean {
        switch (tank.getType()) {
            case ActorType.PLAYER:
                    switch (tank.getLevel()) {
                        //TODO: To Json
                        case PlayerTankLevel.LEVEL_1:
                            return playerBullets < GameSettings.LEVEL_1_BULLETS;
                        case PlayerTankLevel.LEVEL_2:
                            return playerBullets < GameSettings.LEVEL_2_BULLETS;
                        case PlayerTankLevel.LEVEL_3:
                            return playerBullets < GameSettings.LEVEL_3_BULLETS;
                        case PlayerTankLevel.LEVEL_4:
                            return playerBullets < GameSettings.LEVEL_4_BULLETS;
                    }
                break;
        }
        return false;
    }

    private function onPlayerBulletDestroyed():void {
        playerBullets--;
    }

    private function createPlayerBullet(tank:BaseTank, world:World):Bullet {
        var bullet:Bullet;
        switch (tank.getLevel()) {
            case PlayerTankLevel.LEVEL_1:
                    bullet = new Bullet(tank, App.settingsManager.getFrameSpeedById("BULLET_SLOW"), world);
                    return bullet;
                break;
            case PlayerTankLevel.LEVEL_2:
            case PlayerTankLevel.LEVEL_3:
            case PlayerTankLevel.LEVEL_4:
                bullet = new Bullet(tank, App.settingsManager.getFrameSpeedById("BULLET_FAST"), world);
                return bullet;
        }
        return null;
    }

    public static function getBulletLayer():Sprite {
        return bulletLayer;
    }

}
}
