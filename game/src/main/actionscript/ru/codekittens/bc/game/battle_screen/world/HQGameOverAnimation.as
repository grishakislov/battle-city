package ru.codekittens.bc.game.battle_screen.world {
import ru.codekittens.bc.game.App;
import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.battle_screen.explode.BigExplode;
import ru.codekittens.bc.game.core.animation.AnimatedObject;
import ru.codekittens.bc.game.core.assets.model.TileAsset;

public class HQGameOverAnimation extends AnimatedObject {

    private var smbGameOver:TileAsset;
    private var bigExplode:BigExplode;
    private var animateGameOver:Boolean;
    private var timer:uint = 0;

    public function HQGameOverAnimation() {
        smbGameOver = App.assetManager.getTileAsset("GAME_OVER_SMALL");
        bigExplode = new BigExplode();
        bigExplode.x = 96;
        bigExplode.y = 191;
        addChild(bigExplode);
        bigExplode.addDestroyCallback(onExplodeCompleted)
    }

    private function onExplodeCompleted():void {
        removeChild(bigExplode);
        addChild(smbGameOver);
        smbGameOver.x = 88;
        smbGameOver.y = GameSettings.NATIVE_NES_SCREEN_SIZE.y + smbGameOver.height;
        animateGameOver = true;
    }


    override public function pause():void {
        super.pause();
        bigExplode.pause();
    }

    override protected function onAnimation(delta:uint):void {
        if (animateGameOver) {
            if (smbGameOver.y < GameSettings.NATIVE_NES_SCREEN_SIZE.y / 2 - 20) {
                timer++;
                if (timer == 200) {
                    destroy();
                }
                return;
            } else {
                smbGameOver.y -= 1;
            }
        }
    }
}
}
