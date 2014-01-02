package ru.arlevoland.bc.game.core.debug.viewers {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class TileViewer extends BaseScreen {


    private static const HEAD_Y_POSITION:uint = 10;
    private static const NAME_Y_POSITION:uint = 60;
    private static const VISUAL_Y_POSITION:uint = 100;

    public function initialize():void {
        _screenSize = GameSettings.NATIVE_NES_SCREEN_SIZE;
        _background = new Bitmap(new BitmapData(_screenSize.x, _screenSize.y, false, 0xFF000000));

        _totalTiles = App.assetManager.getTileCollectionSize();


        _head = FontTool.drawLine("TILE VIEWER");
        _head.x = Math.round(_screenSize.x / 2 - _head.bitmapData.width / 2);
        _head.y = HEAD_Y_POSITION;
        addChild(_background);
        addChild(_head);
        addChild(_tileName);
        addChild(_tileVisual);
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
                _currentTileNum--;
                if (_currentTileNum < 0) _currentTileNum = _totalTiles - 1;
                break;
            case KeyCommand.RIGHT:
                _currentTileNum++;
                if (_currentTileNum == _totalTiles) _currentTileNum = 0;
                break;
        }

        updateScreen();
    }

    private function updateScreen():void {
        clear();
        _tile = App.assetManager.getTileAssetByIndex(_currentTileNum);
        _tileName.bitmapData = FontTool.drawLine(_tile.getName()).bitmapData.clone();
        _tileName.x = Math.round(_screenSize.x / 2 - _tileName.bitmapData.width / 2);
        _tileName.y = NAME_Y_POSITION;
        _tileVisual.bitmapData = _tile.getBitmap().bitmapData.clone();//TODO копировать надо в модели
        _tileVisual.x = Math.round(_screenSize.x / 2 - _tileVisual.bitmapData.width / 2);
        _tileVisual.y = VISUAL_Y_POSITION;
        addChild(_tileName);
        addChild(_tileVisual);
    }

    private function clear():void {
        removeChild(_tileName);
        removeChild(_tileVisual);  //TODO: иногда здесь ловится исключение
    }


    private var _totalTiles:int;
    private var _currentTileNum:int = 0;
    private var _screenSize:Point;
    private var _background:Bitmap;
    private var _head:Bitmap;
    private var _tileName:Bitmap = new Bitmap();
    private var _tileVisual:Bitmap = new Bitmap();
    private var _tile:TileAsset;

}
}
