package ru.codekittens.bc.game.battle_screen.bonus {
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.codekittens.bc.game.App;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.tank.PlayerTank;
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

    public function appearBonus(world:World):void {
        App.sfxManager.playBonusAppear();
        removeCurrentBonus();

        currentBonus = new Bonus();
        currentBonus.type = getRandomBonusType();

        var bonusCoords:Point = getBonusCoords();
        var intersect:Boolean = world.checkIntersectWithPlayerTanks(getRect(bonusCoords));

        while (intersect) {
            bonusCoords = getBonusCoords();
            intersect = world.checkIntersectWithPlayerTanks(getRect(bonusCoords));
        }

        currentBonus.coords = bonusCoords;
        currentBonus.view = getBonusView(currentBonus.type);

        currentBonus.view.x = currentBonus.coords.x;
        currentBonus.view.y = currentBonus.coords.y;

        currentBonus.worldCoords = new Point();
        currentBonus.worldCoords.x = currentBonus.coords.x / GameSettings.TILE_SIZE;
        currentBonus.worldCoords.y = currentBonus.coords.y / GameSettings.TILE_SIZE;
        layer.addChild(currentBonus.view);

        function getRect(coords:Point):Rectangle {
            return new Rectangle(coords.x, coords.y, GameSettings.TILE_SIZE * 2, GameSettings.TILE_SIZE * 2)
        }
    }

    private function removeCurrentBonus():void {
        if (layer != null && currentBonus != null && layer.contains(currentBonus.view)) {
            currentBonus.view.destroy();
            layer.removeChild(currentBonus.view);
        }
        currentBonus = null;
    }

    private function getBonusCoords():Point {
        var result:Point = new Point();
        result.setTo(generateCoord(), generateCoord());
        return result;
    }

    private function generateCoord():uint {
        return (Math.floor(4 * Math.random()) * 3 + 1) * GameSettings.MAP_TILE_SIZE + GameSettings.TILE_SIZE;
    }

    private function getRandomBonusType():BonusType {
        var index:uint = Math.floor((bonuses.length - 1) * Math.random());
        return bonuses[index];
    }

    private function getBonusView(type:BonusType):BonusView {
        var asset:TileAsset = getBonusAsset(type);
        var view:BonusView = new BonusView(asset);
        return view;
    }

    private function getBonusAsset(type:BonusType):TileAsset {
        return App.assetManager.getTileAsset("POWERUP_" + type.getId().toUpperCase());
    }

    public function bonusOnScreen():Boolean {
        return currentBonus != null;
    }

    public function getCurrentBonus():Bonus {
        return currentBonus;
    }

    public function applyBonus(tank:PlayerTank):void {
        if (currentBonus.type.getId() == BonusType.TANK.getId()) {
            App.sfxManager.playBonusLife();
        } else {
            App.sfxManager.playBonusTaken();
        }
        handleBonus(currentBonus, tank);
        removeCurrentBonus();
    }

    private function handleBonus(currentBonus:Bonus, tank:PlayerTank):void {
        //TODO:
    }
}
}
