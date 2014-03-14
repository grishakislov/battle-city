package ru.codekittens.bc.game.battle_screen.battle_stage_splash {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameObject;
import ru.codekittens.bc.game.events.BattleScreenEvent;

public class BattleStageSplash extends GameObject {

    public function start(level:uint):void {
        animation = new SplashView(this);
        addChild(animation);
        this.level = level;
        animation.setLevel(level);
    }


    override public function destroy():* {
        removeChild(animation);
        App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.SPLASH_DESTROYED));
    }

    internal function onComplete():void {
        App.dispatcher.dispatchEvent(new BattleScreenEvent(BattleScreenEvent.SPLASH_COMPLETED));
    }

    override public function togglePause():void {
        super.togglePause();
        animation.togglePause();
    }

    private var animation:SplashView;
    private var level:uint;

}
}
