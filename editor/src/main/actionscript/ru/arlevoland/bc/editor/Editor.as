/**
 * @author arlechin
 * Date: 12.06.12
 * Time: 13:44
 */
package ru.arlevoland.bc.editor {
import flash.display.Sprite;

import ru.arlevoland.bc.editor.gui.Gui;

[SWF(width="512", height="448", frameRate="60"/*39?*/, backgroundColor="#333333")]
public class Editor extends Sprite {
    public function Editor() {
        trace("It Works!");
        scaleX = GameSettings.WORLD_SCALE;
        scaleY = GameSettings.WORLD_SCALE;
//        initializeGui();
        run();

    }

    private function initializeGui():void {
        _gui = new Gui();
        _gui.initialize();
        addChild(_gui);
    }

    private function run():void {
        _converter = new Converter();
        _converter.run();
    }

    private var _bcbDataFile:*;
    private var _converter:Converter;
    private var _gui:Gui;
}
}
