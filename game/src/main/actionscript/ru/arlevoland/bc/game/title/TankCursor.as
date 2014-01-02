/**
 * @author arlechin
 * Date: 01.07.12
 * Time: 12:32
 */
package ru.arlevoland.bc.game.title {
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.BaseScreen;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.keyboard.KeyboardManagerEvent;
import ru.arlevoland.bc.game.keyboard.key.KeyCommand;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

internal class TankCursor extends BaseScreen {

    private static const STATE_1:String = "PT1_R1";
    private static const STATE_2:String = "PT1_R2";

    private const DEFAULT_POSITION:int = 0;

    [ArrayElementType("flash.geom.Point")]
    private const POSITIONS:Array = [
        new Point(64, 124),
        new Point(64, 140),
        new Point(64, 156)
    ];

    private const SKIP_FRAMES:uint = 4;

    public function TankCursor() {

        _body = new Sprite();
        _state1 = App.assetManager.copyTileAsset(STATE_1);
        _state2 = App.assetManager.copyTileAsset(STATE_2);
        _state2.visible = false;
        _body.addChild(_state1);
        _body.addChild(_state2);
        addChild(_body);

        x = POSITIONS[DEFAULT_POSITION].x;
        y = POSITIONS[DEFAULT_POSITION].y;
        _position = DEFAULT_POSITION;

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    override protected function onAddedToStage(e:Event):void {
        super.onAddedToStage(e);
        Ticker.addEventListener(TickerEvent.TICK, onTick);
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private function onTick(e:Event):void {

        if (_currentFrame == SKIP_FRAMES) {
            _currentFrame = 0;
            _state1.visible = (!_state1.visible);
            _state2.visible = (!_state2.visible);
        }

        _currentFrame++;
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        switch (e.getCommand()) {
            case KeyCommand.UP:
                _position--;
                if (_position < 0) _position = 2;
                applyPosition();
                break;
            case KeyCommand.DOWN:
                _position++;
                if (_position > 2) _position = 0;
                applyPosition();
                break;
            case KeyCommand.ENTER:
                selectMenu();
                break;
        }
    }

    private function applyPosition():void {
        x = POSITIONS[_position].x;
        y = POSITIONS[_position].y;
    }

    private function selectMenu():void {
        dispatchEvent(new TitleEvent(TitleEvent.MENU_SELECTED, _position));
        removeEventListener(Event.ENTER_FRAME, onTick);
        App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private var _position:int;
    private var _currentFrame:uint = 0;
    private var _body:Sprite;
    private var _state1:Sprite;
    private var _state2:Sprite;

}
}
