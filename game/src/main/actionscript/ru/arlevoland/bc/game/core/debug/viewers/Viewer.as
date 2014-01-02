/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game.core.debug.viewers {
import flash.events.Event;

import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;

public class Viewer extends BaseScreen {
    public function initialize():void {
        _tileViewer = new TileViewer();
        _tileViewer.initialize();
        _levelViewer = new LevelViewer();
        _levelViewer.initialize();
        showTileViewer();
    }

    override protected function onAddedToStage(e:Event):void {
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    public function stop():void {
        _tileViewer = null;
        _levelViewer = null;
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
        if (contains(_levelViewer)) {
            removeChild(_levelViewer);
            _levelViewer.stop();
        }
        if (!contains(_tileViewer)) {
            addChild(_tileViewer);
            _tileViewer.start();
        }
    }

    private function showLevelViewer():void {
        if (contains(_tileViewer)) {
            removeChild(_tileViewer);
            _tileViewer.stop();
        }
        if (!contains(_levelViewer)) {
            addChild(_levelViewer);
            _levelViewer.start();
        }
    }

    private var _tileViewer:TileViewer;
    private var _levelViewer:LevelViewer;
}
}
