/**
 * @author arlechin
 * Date: 30.05.12
 * Time: 8:03
 */
package ru.arlevoland.bc.game.battlestage.world {
import flash.display.Sprite;
import flash.geom.Point;

import ru.arlevoland.bc.game.battlestage.BattleStageLoader;
import ru.arlevoland.bc.game.battlestage.tank.BulletManager;
import ru.arlevoland.bc.game.battlestage.tank.PlayerTank;
import ru.arlevoland.bc.game.battlestage.tank.TankDirection;

public class Battleground extends Sprite {

    public function initialize(levelId:uint):void {

        _stageId = levelId;
        _bulletManager = new BulletManager();
        _collisionLayer = new WorldCollisionLayer();
        _collisionLayer.initialize(levelId);
        addChild(_collisionLayer);

        _waterLayer = new WorldWaterLayer();
        _waterLayer.initialize(levelId);
        addChild(_waterLayer);

        _tankLayer = new Sprite();
        addChild(_tankLayer);


        _bulletLayer = BulletManager.getBulletLayer();
        addChild(_bulletLayer);

        _treeLayer = new WorldTreeLayer();
        _treeLayer.initialize(levelId);
        addChild(_treeLayer);

        _tankCollisionMap = BattleStageLoader.fillTankCollisionMap(stageId);
        _bulletCollisionMap = BattleStageLoader.fillBulletCollisionMap(stageId);

    }

    public function initializePlayerTank(tankLevel:uint):void {
        _playerTank1 = new PlayerTank(tankLevel, this);
        _playerTank1.initialize();
        _tankLayer.addChild(_playerTank1);
    }

    public function pause():void {
        _playerTank1.pause();
    }


    public function get stageId():uint {
        return _stageId;
    }

    public function get tankCollisionMap():Array {
        return _tankCollisionMap;
    }

    public function get bulletCollisionMap():Array {
        return _bulletCollisionMap;
    }

    public function get bulletManager():BulletManager {
        return _bulletManager;
    }

    public function applyDestruction(worldPoint:Point, direction:TankDirection):void {
        _collisionLayer.applyDestruction(worldPoint, direction);
    }

    private var _tankCollisionMap:Array;
    private var _bulletCollisionMap:Array;

    private var _bulletManager:BulletManager;

    private var _stageId:uint;
    private var _tankLayer:Sprite;
    private var _playerTank1:PlayerTank;
    private var _player2:PlayerTank;
    private var _aiTanks:Array = [];
    private var _collisionLayer:WorldCollisionLayer;
    private var _waterLayer:WorldWaterLayer;
    private var _bulletLayer:Sprite;
    private var _effectsLayer:Sprite;
    private var _treeLayer:WorldTreeLayer;

}
}
