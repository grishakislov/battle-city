/**
 * @author arlechin
 * @author antivoland
 */
package ru.arlevoland.bc.game.power_on {
import flash.display.Bitmap;
import flash.display.BitmapData;

import ru.arlevoland.bc.game.App;

import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.game.GameSettings;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.controller.ScreenMessage;
import ru.arlevoland.bc.game.controller.PipelineChannel;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class PowerOnEffect extends GameScreen {
    private static const Y_OFFSET:uint = 5;
    private static const MAX_LINES:uint = 3;
    private static const MIN_LINES:uint = 1;
    private static const MIN_LINE_THICKNESS:int = 1;
    private static const MAX_LINE_THICKNESS:int = 8;
    private static const SHORT_LINE_LENGTH:int = 24;
    private static const WAIT_BEFORE:Number = 500;
    private static const WAIT_AFTER:Number = 500;
    private static const SHOW_TIME:Number = 70;

    override public function run(data:* = undefined):void {
        _frameLength = Math.round(1000 / stage.frameRate);
        _bitmap = generateBitmap();
        Ticker.addEventListener(TickerEvent.TICK, onTick);
    }

    override public function destroy():* {
        Ticker.removeEventListener(TickerEvent.TICK, onTick);
        parent.removeChild(this);
    }

    private function onTick(e:TickerEvent):void {
        switch (_currentFrame) {
            case getFramesForDelay(WAIT_BEFORE):
//                    trace(_currentFrame);
                App.sfxManager.playClick();
                showEffect();
                break;
            case getFramesForDelay(SHOW_TIME + WAIT_BEFORE):
                hideEffect();
                break;
            case getFramesForDelay(WAIT_AFTER + SHOW_TIME + WAIT_BEFORE):
                App.pipelineManager.getPipeLine(PipelineChannel.SCREEN).push(new ScreenMessage(ScreenMessage.FINISHED, this));
                break;
        }

        _currentFrame++;
    }

    private function showEffect():void {
        addChild(_bitmap);
    }

    private function hideEffect():void {
        removeChild(_bitmap);

    }

    private function generateBitmap():Bitmap {
        var width:int = GameSettings.NATIVE_NES_SCREEN_SIZE.x;
        var height:int = GameSettings.NATIVE_NES_SCREEN_SIZE.y;
        var result:Bitmap = new Bitmap(new BitmapData(width, height, false, 0x000000));
        var yCoord:int;
        var linesNumber:int = Math.floor(Math.random() * (1 + MAX_LINES - MIN_LINES) + MIN_LINES);

        for (var i:int = 0; i < linesNumber; i++) {
            yCoord = Math.floor(Math.random() * (height - Y_OFFSET) + Y_OFFSET);
            var lineThickness:int = Math.floor(Math.random() * (1 + MAX_LINE_THICKNESS - MIN_LINE_THICKNESS) + MIN_LINE_THICKNESS);
            for (var y:int = yCoord; y < yCoord + lineThickness; y++) {
                drawLine(y, width);
            }
            //Неполные линии. Такое действительно было на некоторых версиях Фамикома.
            drawLine(y, SHORT_LINE_LENGTH);
            drawLine(y++, SHORT_LINE_LENGTH);
            drawLine(y++, SHORT_LINE_LENGTH);
            drawLine(y++, SHORT_LINE_LENGTH);
        }

        return result;

        function drawLine(y:int, w:int):void {
            for (var x:int = 0; x < w; x++) {
                result.bitmapData.setPixel32(x, y, 0xFFFFFFFF);
            }
        }
    }

    private function getFramesForDelay(delay:Number):int {
        return Math.round(delay / _frameLength);
    }

    override public function pause():void {
        if (_paused) {
            Ticker.addEventListener(TickerEvent.TICK, onTick);
        } else {
            Ticker.removeEventListener(TickerEvent.TICK, onTick);
        }
        super.pause();
    }

    private var _currentFrame:Number = 0;
    private var _frameLength:Number;
    private var _bitmap:Bitmap;
}
}
