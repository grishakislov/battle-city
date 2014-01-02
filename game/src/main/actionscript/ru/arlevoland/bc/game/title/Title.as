/**
 * @author arlechin
 * Date: 31.05.12
 * Time: 22:59
 */
package ru.arlevoland.bc.game.title {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.controller.ScreenMessage;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class Title extends GameScreen {

    private const HEAD:String = "-    00 HI- 20000";
    private const ONE_PLAYER:String = "1 PLAYER";
    private const TWO_PLAYER:String = "2 PLAYERS";
    private const CONSTRUCTION:String = "CONSTRUCTION";
    private const FOOT1:String = "© 1980 1985 NAMCO LTD.";
    private const FOOT2:String = "ALL RIGHTS RESERVED";

    private const PLAYER_MARK_COORDS:Point = new Point(2, 2);
    private const HEAD_COORDS:Point = new Point(3, 2);
    private const LOGO_COORDS:Point = new Point(3, 5);
    private const ONE_PLAYER_COORDS:Point = new Point(11, 16);
    private const TWO_PLAYER_COORDS:Point = new Point(11, 18);
    private const CONSTRUCTION_COORDS:Point = new Point(11, 20);
    private const NAMCOT_COORDS:Point = new Point(11, 22);
    private const COPY_COORDS:Point = new Point(4, 24);
    private const ARR_COORDS:Point = new Point(6, 26);

    override public function initialize():void {
        //draw sprites etc
        content = new Sprite();
        tileSize = GameSettings.TILE_SIZE;

        var playerMark:Bitmap = App.assetManager.getTileAsset("SYM_I").getBitmap();
        var head:Bitmap = FontTool.drawLine(HEAD);
        var logo:Bitmap = App.assetManager.getTileAsset("LOGO").getBitmap();
        var onePlayer:Bitmap = FontTool.drawLine(ONE_PLAYER);
        var twoPlayer:Bitmap = FontTool.drawLine(TWO_PLAYER);
        var construction:Bitmap = FontTool.drawLine(CONSTRUCTION);
        var namcot:Bitmap = App.assetManager.getTileAsset("SPRITE_NAMCOT").getBitmap();
        var foot1:Bitmap = FontTool.drawLine(FOOT1);
        var foot2:Bitmap = FontTool.drawLine(FOOT2);

        applyCoords(playerMark, PLAYER_MARK_COORDS);
        applyCoords(head, HEAD_COORDS);
        applyCoords(logo, LOGO_COORDS);
        applyCoords(onePlayer, ONE_PLAYER_COORDS);
        applyCoords(twoPlayer, TWO_PLAYER_COORDS);
        applyCoords(construction, CONSTRUCTION_COORDS);
        applyCoords(namcot, NAMCOT_COORDS);
        applyCoords(foot1, COPY_COORDS);
        applyCoords(foot2, ARR_COORDS);

        content.addChild(playerMark);
        content.addChild(head);
        content.addChild(logo);
        content.addChild(onePlayer);
        content.addChild(twoPlayer);
        content.addChild(construction);
        content.addChild(namcot);
        content.addChild(foot1);
        content.addChild(foot2);

        content.y = GameSettings.NATIVE_NES_SCREEN_SIZE.y;
        content.cacheAsBitmap = true;
        addChild(content);
    }

    private function applyCoords(bitmap:Bitmap, coords:Point):void {
        bitmap.x = coords.x * tileSize;
        bitmap.y = coords.y * tileSize;
    }

    override public function run(data:* = undefined):void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
        Ticker.addEventListener(TickerEvent.TICK, onTick);
    }

    override public function pause():void {
        if (_paused) {
            if (!animationCompleted) Ticker.addEventListener(TickerEvent.TICK, onTick);
        } else {
            if (!animationCompleted) Ticker.removeEventListener(TickerEvent.TICK, onTick);
        }
        if (tankCursor != null) tankCursor.pause();
        super.pause();
    }

    override public function destroy():* {
        tankCursor.removeEventListener(TitleEvent.MENU_SELECTED, onMenuSelected);
        parent.removeChild(this);
        return selectedPosition;
    }

    private function onTick(e:Event):void {
        if (content.y > 0) {
            content.y--;
        } else {
            stopAnimation();
        }

    }

    private function stopAnimation():void {
        content.y = 0;
        animationCompleted = true;
        Ticker.removeEventListener(TickerEvent.TICK, onTick);
        addTankCursor();
    }

    private function onKeyDown(event:KeyboardManagerEvent):void {
        if (event.getCommand() == KeyCommand.ENTER && !animationCompleted) {
            App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
            stopAnimation();
        }
    }

    private function addTankCursor():void {
        tankCursor = new TankCursor();
        addChild(tankCursor);
        tankCursor.addEventListener(TitleEvent.MENU_SELECTED, onMenuSelected);
    }

    private function onMenuSelected(e:TitleEvent):void {
        selectedPosition = e.position;
        App.pipelineManager.dispatchGameEvent(ScreenMessage.FINISHED, this);
    }

    private var tileSize:uint;
    private var animationCompleted:Boolean;
    private var tankCursor:TankCursor;
    private var content:Sprite;
    private var selectedPosition:uint;


}
}
