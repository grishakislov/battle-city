package ru.codekittens.bc.game.core.debug.viewers {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.core.assets.FontTool;
import ru.codekittens.bc.game.core.assets.model.TileAsset;
import ru.codekittens.bc.game.keyboard.KeyboardManagerEvent;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;

public class TileViewer extends GameObject {

    private static const HEAD_Y_POSITION:uint = 10;
    private static const NAME_Y_POSITION:uint = 60;
    private static const VISUAL_Y_POSITION:uint = 100;

    public function initialize():void {
        screenSize = GameSettings.NATIVE_NES_SCREEN_SIZE;
        background = new Bitmap(new BitmapData(screenSize.x, screenSize.y, false, 0xFF000000));

        totalTiles = App.assetManager.getTileCollectionSize();

        head = FontTool.drawLine("TILE VIEWER");
        head.x = Math.round(screenSize.x / 2 - head.bitmapData.width / 2);
        head.y = HEAD_Y_POSITION;
        addChild(background);
        addChild(head);
        addChild(tileName);
        addChild(tileVisual);
        updateScreen();

    }

    public function stop():void {
        App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    public function start():void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }


    override protected function onAddedToStage(e:Event):void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        switch (e.getCommand()) {
            case KeyCommand.LEFT:
                currentTileNum--;
                if (currentTileNum < 0) currentTileNum = totalTiles - 1;
                break;
            case KeyCommand.RIGHT:
                currentTileNum++;
                if (currentTileNum == totalTiles) currentTileNum = 0;
                break;
        }

        updateScreen();
    }

    private function updateScreen():void {
        clear();
        tile = App.assetManager.getTileAssetByIndex(currentTileNum);
        tileName.bitmapData = FontTool.drawLine(tile.getName()).bitmapData.clone();
        tileName.x = Math.round(screenSize.x / 2 - tileName.bitmapData.width / 2);
        tileName.y = NAME_Y_POSITION;
        tileVisual.bitmapData = tile.getBitmap().bitmapData.clone();//TODO копировать надо в модели
        tileVisual.x = Math.round(screenSize.x / 2 - tileVisual.bitmapData.width / 2);
        tileVisual.y = VISUAL_Y_POSITION;
        addChild(tileName);
        addChild(tileVisual);
    }

    private function clear():void {
        removeChild(tileName);
        removeChild(tileVisual);  //TODO: иногда здесь ловится исключение
    }


    private var totalTiles:int;
    private var currentTileNum:int = 0;
    private var screenSize:Point;
    private var background:Bitmap;
    private var head:Bitmap;
    private var tileName:Bitmap = new Bitmap();
    private var tileVisual:Bitmap = new Bitmap();
    private var tile:TileAsset;

}
}
