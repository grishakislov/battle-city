package ru.codekittens.bc.game.battle_screen.bonus {
import flash.display.Sprite;
import flash.geom.Point;

import ru.codekittens.bc.game.App;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.core.assets.model.TileAsset;

public class BonusManager {

    private var bonuses:Vector.<BonusType>;
    private var currentBonus:Bonus;
    private var layer:Sprite;

    public function initialize():void {
        bonuses = new Vector.<BonusType>();
        bonuses.push(BonusType.HELMET);
        bonuses.push(BonusType.TIME);
        bonuses.push(BonusType.SHOVEL);
        bonuses.push(BonusType.STAR);
        bonuses.push(BonusType.STAR);
        bonuses.push(BonusType.BOMB);
        bonuses.push(BonusType.BOMB);
        bonuses.push(BonusType.TANK);
    }

    public function reset(layer:Sprite):void {
        removeCurrentBonus();
        this.layer = layer;
    }

    public function appearBonus():void {
        removeCurrentBonus();

        currentBonus = new Bonus();
        currentBonus.type = getRandomBonusType();
        currentBonus.coords = getBonusCoords();
        currentBonus.asset = getBonusAsset(currentBonus.type);

        currentBonus.asset.x = currentBonus.coords.x;
        currentBonus.asset.y = currentBonus.coords.y;
        layer.addChild(currentBonus.asset);
    }

    private function removeCurrentBonus():void {
        if (layer != null && currentBonus != null && layer.contains(currentBonus.asset)) {
            layer.removeChild(currentBonus.asset);
        }
        currentBonus = null;
    }

    private function getBonusCoords():Point {
        var result:Point = new Point();
        var x:uint = (Math.floor(4 * Math.random()) * 3 + 1) * GameSettings.MAP_TILE_SIZE + GameSettings.TILE_SIZE;
        var y:uint = (Math.floor(4 * Math.random()) * 3 + 1) * GameSettings.MAP_TILE_SIZE + GameSettings.TILE_SIZE;
        result.setTo(x,y);
        return result;
    }

    private function getRandomBonusType():BonusType {
        var index:uint = Math.floor((bonuses.length - 1) * Math.random());
        return bonuses[index];
    }

    private function getBonusAsset(type:BonusType):TileAsset {
        return App.assetManager.getTileAsset("POWERUP_" + type.getId().toUpperCase());
    }

}
}
