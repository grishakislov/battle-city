package ru.codekittens.bc.game.title {
import ru.codekittens.bc.game.core.animation.AnimatedObject;

public class TitleAnimation extends AnimatedObject {


    override protected function onAnimation(delta:uint):void {
        if (y > 0) {
            y-=delta;
        } else {
            y = 0;
            destroy();
        }
    }
}
}
