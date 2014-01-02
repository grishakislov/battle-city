/**
 * @author arlechin
 * Date: 14.07.12
 * Time: 15:49
 */
package ru.arlevoland.bc.game.core.debug.viewers {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.Colors;
import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.battlestage.BattleStageDrawMode;
import ru.arlevoland.bc.game.battlestage.BattleStageLoader;
import ru.arlevoland.bc.game.battlestage.battleground.WorldWaterLayer;
import ru.arlevoland.bc.game.core.assets.model.TilePalette;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class LevelViewer extends BaseScreen {

    public static const LEVEL_X:uint = 2;
    public static const LEVEL_Y:uint = 1;
    public static const LEVEL_ID_X:uint = 29;
    public static const LEVEL_ID_Y:uint = 1;
    private static const GRID_THICKNESS:uint = 1;

    public function initialize():void {
        _screenSize = GameSettings.NATIVE_NES_SCREEN_SIZE;
        _tileSize = GameSettings.TILE_SIZE;
        _mapTileSize = GameSettings.MAP_TILE_SIZE;
        _grid = new Bitmap(new BitmapData(_mapTileSize * GameSettings.WORLD_WIDTH, _mapTileSize * GameSettings.WORLD_HEIGHT, true, 0x00FF0000));
        _totalLevels = App.levelDataManager.getLevelsTotal();

        _background = new Bitmap(new BitmapData(_screenSize.x, _screenSize.y, false, Colors.MAIN_BG));
        _levelBackground = new Bitmap(new BitmapData(_mapTileSize * GameSettings.WORLD_WIDTH, _mapTileSize * GameSettings.WORLD_HEIGHT, false, Colors.SCENE_BG));
        _levelBackground.x = LEVEL_X * _tileSize;
        _levelBackground.y = LEVEL_Y * _tileSize;

        _level = new Bitmap(new BitmapData(_mapTileSize * GameSettings.WORLD_WIDTH, _mapTileSize * GameSettings.WORLD_HEIGHT, true, Colors.SCENE_BG));
        _water = new WorldWaterLayer();

        _levelId = new Bitmap(new BitmapData(_tileSize * 2, _tileSize, false, 0x000000));

        drawGrid();
        _grid.visible = false;
        _grid.x = LEVEL_X * _tileSize;
        _grid.y = LEVEL_Y * _tileSize;
        addChild(_background);
        addChild(_levelBackground);

        addChild(_level);
        addChild(_water);
        addChild(_levelId);
        addChild(_grid);
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
                _currentLevel--;
                if (_currentLevel < 1) _currentLevel = _totalLevels;
                updateScreen();
                break;
            case KeyCommand.RIGHT:
                _currentLevel++;
                if (_currentLevel > _totalLevels) _currentLevel = 1;
                updateScreen();
                break;
            case KeyCommand.GRID_TRIGGER:
                _gridTrigger ? _grid.visible = true : _grid.visible = false;
                _gridTrigger = !_gridTrigger;
                updateScreen();
                break;
        }
    }


    private function updateScreen():void {
        clear();
        _level.bitmapData.dispose();
        _level = BattleStageLoader.drawStageToBitmap(_currentLevel, BattleStageDrawMode.NO_WATER);
        _water.initialize(_currentLevel);
        var line:String = _currentLevel < 10 ? "0" + _currentLevel.toString() : _currentLevel.toString();
        _levelId = FontTool.drawLine(line);

        _water.x = _level.x = LEVEL_X * _tileSize;
        _water.y = _level.y = LEVEL_Y * _tileSize;
        _levelId.x = LEVEL_ID_X * _tileSize;
        _levelId.y = LEVEL_ID_Y * _tileSize;

        addChild(_level);
        addChild(_levelId);
        addChild(_grid);
    }

    private function clear():void {
        removeChild(_level);
        removeChild(_levelId);
        removeChild(_grid);
    }

    private function drawGrid():void {
        var i:uint;
        for (i = 1; i < GameSettings.WORLD_HEIGHT; i++) {
            drawHorLine(i * GameSettings.MAP_TILE_SIZE);
        }

        for (i = 1; i < GameSettings.WORLD_WIDTH; i++) {
            drawVertLine(i * GameSettings.MAP_TILE_SIZE);
        }

        function drawHorLine(y:uint):void {
            var rect:Rectangle = new Rectangle(0, y, GameSettings.MAP_TILE_SIZE * _mapTileSize, GRID_THICKNESS);
            _grid.bitmapData.fillRect(rect, Colors.GRID);
        }

        function drawVertLine(x:uint):void {
            var rect:Rectangle = new Rectangle(x, 0, GRID_THICKNESS, GameSettings.MAP_TILE_SIZE * _mapTileSize);
            _grid.bitmapData.fillRect(rect, Colors.GRID);
        }

        addChild(_grid);
    }

    private var _screenSize:Point;
    private var _tileSize:uint;
    private var _mapTileSize:uint;
    private var _currentLevel:int = 1;
    private var _totalLevels:uint;

    private var _level:Bitmap;
    private var _water:WorldWaterLayer;

    private var _levelId:Bitmap;
    private var _background:Bitmap;
    private var _levelBackground:Bitmap;
    private var _grid:Bitmap = new Bitmap();
    private var _gridTrigger:Boolean = true;


}
}
