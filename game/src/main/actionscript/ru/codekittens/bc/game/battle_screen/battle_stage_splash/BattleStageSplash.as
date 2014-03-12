package ru.codekittens.bc.game.battle_screen.battle_stage_splash {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.BaseScreen;
import ru.codekittens.bc.game.events.BattleScreenEvent;

public class BattleStageSplash extends BaseScreen {

    public function start(level:uint):void {
        animation = new SplashView(this);
        addChild(animation);
        this.level = level;
        animation.setLevel(level);
    }


    public function destroy():void {
        removeChild(animation);
        App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.SPLASH_DESTROYED));
    }

    internal function onComplete():void {
        App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.SPLASH_COMPLETED));
    }

    override public function pause():void {
        animation.pause();
    }

    private var animation:SplashView;
    private var level:uint;

}
}
