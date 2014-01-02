/**
 * @author arlechin
 * Date: 15.07.12
 * Time: 3:50
 */
package ru.arlevoland.bc.game.battlestage.battle_stage_preloader {
import ru.arlevoland.bc.game.GameScreen;

public class BattleStagePreloader extends GameScreen {

    override public function initialize():void {
        animation = new BattlestagePreloaderView();
        addChild(animation);
//        animation.
    }

    override public function run(data:* = undefined):void {
        this.level = uint(data);
        animation.setLevel(uint(data));
    }


    override public function destroy():* {
        return super.destroy();
    }

    public function stop():void {

    }

    private var animation:BattlestagePreloaderView;
    private var level:uint;

}
}
