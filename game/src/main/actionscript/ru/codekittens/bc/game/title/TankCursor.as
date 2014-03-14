package ru.codekittens.bc.game.title {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.keyboard.KeyboardManagerEvent;
import ru.codekittens.bc.game.keyboard.key.KeyCommand;
import ru.codekittens.bc.game.time.Ticker;

internal class TankCursor extends MovieClip {

    private static const STATE_1:String = "P1R1";
    private static const STATE_2:String = "P1R2";

    private const DEFAULT_POSITION:int = 0;

    [ArrayElementType("flash.geom.Point")]
    private const POSITIONS:Array = [
        new Point(64, 124),
        new Point(64, 140),
        new Point(64, 156)
    ];

    private const SKIP_FRAMES:uint = 4;

    public function TankCursor() {

        body = new Sprite();
        state1 = App.assetManager.copyTileAsset(STATE_1);
        state2 = App.assetManager.copyTileAsset(STATE_2);
        state2.visible = false;
        body.addChild(state1);
        body.addChild(state2);
        addChild(body);

        x = POSITIONS[DEFAULT_POSITION].x;
        y = POSITIONS[DEFAULT_POSITION].y;
        position = DEFAULT_POSITION;

        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    protected function onAddedToStage(e:Event):void {
        Ticker.addTickListener(onTick);
        App.keyboardManager.addEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private function onTick(dt:uint):void {

        if (frame == SKIP_FRAMES) {
            frame = 0;
            state1.visible = (!state1.visible);
            state2.visible = (!state2.visible);
        }

        frame++;
    }

    private function onKeyDown(e:KeyboardManagerEvent):void {
        switch (e.getCommand()) {
            case KeyCommand.UP:
                position--;
                if (position < 0) position = 2;
                applyPosition();
                break;
            case KeyCommand.DOWN:
                position++;
                if (position > 2) position = 0;
                applyPosition();
                break;
            case KeyCommand.ENTER:
                selectMenu();
                break;
        }
    }

    private function applyPosition():void {
        x = POSITIONS[position].x;
        y = POSITIONS[position].y;
    }

    private function selectMenu():void {
        dispatchEvent(new TitleEvent(TitleEvent.MENU_SELECTED, position));
        removeEventListener(Event.ENTER_FRAME, onTick);
        App.keyboardManager.removeEventListener(KeyboardManagerEvent.KEY_DOWN, onKeyDown);
    }

    private var position:int;
    private var frame:uint = 0;
    private var body:Sprite;
    private var state1:Sprite;
    private var state2:Sprite;

}
}
