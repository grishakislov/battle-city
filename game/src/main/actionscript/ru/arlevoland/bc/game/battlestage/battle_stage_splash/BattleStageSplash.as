package ru.arlevoland.bc.game.battlestage.battle_stage_splash {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.GameScreen;
import ru.arlevoland.bc.game.battlestage.BattleScreenEvent;

public class BattleStageSplash extends GameScreen {

    override public function initialize():void {
        animation = new SplashView(this);
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

    internal function onComplete() {
        App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.PRELOADER_COMPLETED));
    }

    public function stop():void {

    }

    private var animation:SplashView;
    private var level:uint;

}
}
