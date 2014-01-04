package ru.arlevoland.bc.game.core.debug.viewers {
import flash.events.Event;

import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class Viewer extends BaseScreen {

    public function initialize():void {
        tileViewer = new TileViewer();
        tileViewer.initialize();
        levelViewer = new LevelViewer();
        levelViewer.initialize();
        showTileViewer();
    }

    override protected function onAddedToStage(e:Event):void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    public function stop():void {
        tileViewer = null;
        levelViewer = null;
        App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private function onKeyDown(event:KeyboardManagerEvent):void {
        switch (event.getCommand()) {
            case KeyCommand.MODE1:
                showTileViewer();
                break;
            case KeyCommand.MODE2:
                showLevelViewer();
                break;
        }
    }

    private function showTileViewer():void {
        if (contains(levelViewer)) {
            removeChild(levelViewer);
            levelViewer.stop();
        }
        if (!contains(tileViewer)) {
            addChild(tileViewer);
            tileViewer.start();
        }
    }

    private function showLevelViewer():void {
        if (contains(tileViewer)) {
            removeChild(tileViewer);
            tileViewer.stop();
        }
        if (!contains(levelViewer)) {
            addChild(levelViewer);
            levelViewer.start();
        }
    }

    private var tileViewer:TileViewer;
    private var levelViewer:LevelViewer;
}
}
