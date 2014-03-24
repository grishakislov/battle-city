package ru.codekittens.bc.game.battle_screen.bullet {
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.explode.SmallExplode;
import ru.codekittens.bc.game.battle_screen.tank.*;
import ru.codekittens.bc.game.battle_screen.world.Actor;
import ru.codekittens.bc.game.battle_screen.world.ActorType;
import ru.codekittens.bc.game.battle_screen.world.World;
import ru.codekittens.bc.game.core.animation.AnimatedObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.settings.model.FrameSpeed;

public class Bullet extends AnimatedObject implements Actor {

    private var world:World;
    private var tank:BaseTank;
    private var direction:ActorDirection;
    private var level:uint;
    private var tankCoords:Point;
    private var movement:ActorDirection;
    private var visual:TileAsset;


    public function Bullet(tank:BaseTank, speed:FrameSpeed, world:World) {
        this.world = world;
        this.direction = tank.getDirection();
        this.tankCoords = tank.getPosition();
        this.tank = tank;
        this.level = tank.getLevel();
        playShootSound();
        initialize();
        run(speed);
    }

    private function applyStartCoordsForBullet():void {
        /*
         Спрайт пули независимо от направления имеет размер 1x2
         */
        switch (direction) {
            case ActorDirection.UP:
                x = tankCoords.x + 3;
                y = tankCoords.y - 7;
                break;
            case ActorDirection.RIGHT:
                x = tankCoords.x + GameSettings.TANK_SIZE - 5;
                y = tankCoords.y;
                break;
            case ActorDirection.DOWN:
                x = tankCoords.x + 3;
                y = tankCoords.y + 7;
                break;
            case ActorDirection.LEFT:
                x = tankCoords.x - 3;
                y = tankCoords.y;
                break;
        }
    }

    private function applyStartCoordsForExplode():void {
        switch (direction) {
            case ActorDirection.UP:
                x -= 4;
                y -= 2;
                break;
            case ActorDirection.RIGHT:
                y -= 1;
                x -= 2;
                break;
            case ActorDirection.DOWN:
                x -= 3;
                y += 2;
                break;
            case ActorDirection.LEFT:
                x -= 5;
                break;
        }
    }


    override protected function onAnimation(delta:uint):void {
        super.onAnimation(delta);
        if (isMoving()) {
            move(delta);
        }
    }

    private function move(delta:uint):void {
        if (world.isBarrierAhead(this)) {
            explode();
            stopMovement();
            return;
        }

        switch (movement) {
            case ActorDirection.UP:
                y -= delta;
                break;
            case ActorDirection.RIGHT:
                x += delta;
                break;
            case ActorDirection.DOWN:
                y += delta;
                break;
            case ActorDirection.LEFT:
                x -= delta;
                break;
        }
    }

    private function getForwardBound():Point {
        var result:Point = new Point();
        switch (movement) {
            case ActorDirection.UP:
                result.x = x;
                result.y = y + 6;
                break;
            case ActorDirection.RIGHT:
                result.x = x - 10;
                result.y = y;
                break;
            case ActorDirection.DOWN:
                result.x = x;
                result.y = y - 6;
                break;
            case ActorDirection.LEFT:
                result.x = x + 2;
                result.y = y;
                break;
        }
        return result;
    }

    private function explode():void {
        removeChild(visual);
        applyStartCoordsForExplode();
        var explode:SmallExplode = new SmallExplode();
        explode.addDestroyCallback(destroy);
        addChild(explode);
    }

    private function playShootSound():void {
        App.sfxManager.playShoot();
    }

    private function initialize():void {
        applyStartCoordsForBullet();
        var visualName:String;
        movement = direction;
        switch (direction) {
            case ActorDirection.UP:
                visualName = "BULLET_U";
                break;
            case ActorDirection.RIGHT:
                visualName = "BULLET_R";
                break;
            case ActorDirection.DOWN:
                visualName = "BULLET_D";
                break;
            case ActorDirection.LEFT:
                visualName = "BULLET_L";
                break;
        }
        visual = App.assetManager.copyTileAsset(visualName);
        addChild(visual);
    }


    private function stopMovement():void {
        movement = null;
    }

    private function isMoving():Boolean {
        return movement != null;
    }

    override public function destroy():* {
        super.destroy();
        parent.removeChild(this);
        visual.getBitmap().bitmapData.dispose();
    }

    //Actor

    public function getLevel():uint {
        return level;
    }

    public function getType():ActorType {
        return ActorType.BULLET;
    }

    public function getPosition():Point {
        return getForwardBound();
    }

    public function getDirection():ActorDirection {
        return movement;
    }

    public function getTank():BaseTank {
        return tank;
    }

}
}
