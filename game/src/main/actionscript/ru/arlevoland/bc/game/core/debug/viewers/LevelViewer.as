package ru.arlevoland.bc.game.core.debug.viewers {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.Colors;
import ru.arlevoland.bc.game.battle_screen.BattleStageDrawMode;
import ru.arlevoland.bc.game.battle_screen.map_loader.MapLoader;
import ru.arlevoland.bc.game.battle_screen.world.WorldWaterLayer;
import ru.arlevoland.bc.game.core.assets.FontTool;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class LevelViewer extends BaseScreen {

    public static const LEVEL_X:uint = 2;
    public static const LEVEL_Y:uint = 1;
    public static const LEVEL_ID_X:uint = 29;
    public static const LEVEL_ID_Y:uint = 1;
    private static const GRID_THICKNESS:uint = 1;

    public function initialize():void {
        screenSize = GameSettings.NATIVE_NES_SCREEN_SIZE;
        tileSize = GameSettings.TILE_SIZE;
        mapTileSize = GameSettings.MAP_TILE_SIZE;
        grid = new Bitmap(new BitmapData(mapTileSize * GameSettings.WORLD_WIDTH, mapTileSize * GameSettings.WORLD_HEIGHT, true, 0x00FF0000));
        totalLevels = App.levelDataManager.getLevelsTotal();

        background = new Bitmap(new BitmapData(screenSize.x, screenSize.y, false, Colors.MAIN_BG));
        levelBackground = new Bitmap(new BitmapData(mapTileSize * GameSettings.WORLD_WIDTH, mapTileSize * GameSettings.WORLD_HEIGHT, false, Colors.SCENE_BG));
        levelBackground.x = LEVEL_X * tileSize;
        levelBackground.y = LEVEL_Y * tileSize;

        level = new Bitmap(new BitmapData(mapTileSize * GameSettings.WORLD_WIDTH, mapTileSize * GameSettings.WORLD_HEIGHT, true, Colors.SCENE_BG));
        water = new WorldWaterLayer();

        levelId = new Bitmap(new BitmapData(tileSize * 2, tileSize, false, 0x000000));

        drawGrid();
        grid.visible = false;
        grid.x = LEVEL_X * tileSize;
        grid.y = LEVEL_Y * tileSize;
        addChild(background);
        addChild(levelBackground);

        addChild(level);
        addChild(water);
        addChild(levelId);
        addChild(grid);
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
                currentLevel--;
                if (currentLevel < 1) currentLevel = totalLevels;
                updateScreen();
                break;
            case KeyCommand.RIGHT:
                currentLevel++;
                if (currentLevel > totalLevels) currentLevel = 1;
                updateScreen();
                break;
            case KeyCommand.GRID_TRIGGER:
                gridTrigger ? grid.visible = true : grid.visible = false;
                gridTrigger = !gridTrigger;
                updateScreen();
                break;
        }
    }

    private function updateScreen():void {
        clear();
        level.bitmapData.dispose();
        level = MapLoader.drawStageToBitmap(currentLevel, BattleStageDrawMode.NO_WATER);
        water.initialize(currentLevel);
        var line:String = currentLevel < 10 ? "0" + currentLevel.toString() : currentLevel.toString();
        levelId = FontTool.drawLine(line);

        water.x = level.x = LEVEL_X * tileSize;
        water.y = level.y = LEVEL_Y * tileSize;
        levelId.x = LEVEL_ID_X * tileSize;
        levelId.y = LEVEL_ID_Y * tileSize;

        addChild(level);
        addChild(levelId);
        addChild(grid);
    }

    private function clear():void {
        removeChild(level);
        removeChild(levelId);
        removeChild(grid);
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
            var rect:Rectangle = new Rectangle(0, y, GameSettings.MAP_TILE_SIZE * mapTileSize, GRID_THICKNESS);
            grid.bitmapData.fillRect(rect, Colors.GRID);
        }

        function drawVertLine(x:uint):void {
            var rect:Rectangle = new Rectangle(x, 0, GRID_THICKNESS, GameSettings.MAP_TILE_SIZE * mapTileSize);
            grid.bitmapData.fillRect(rect, Colors.GRID);
        }

        addChild(grid);
    }

    private var screenSize:Point;
    private var tileSize:uint;
    private var mapTileSize:uint;
    private var currentLevel:int = 1;
    private var totalLevels:uint;

    private var level:Bitmap;
    private var water:WorldWaterLayer;

    private var levelId:Bitmap;
    private var background:Bitmap;
    private var levelBackground:Bitmap;
    private var grid:Bitmap = new Bitmap();
    private var gridTrigger:Boolean = true;


}
}
