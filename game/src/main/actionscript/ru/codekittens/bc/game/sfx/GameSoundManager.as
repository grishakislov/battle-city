package ru.codekittens.bc.game.sfx {
public class GameSoundManager extends SfxManager {

    public function playShoot():void {
        play(getSounds().SHOOT, SfxLoop.NO_LOOP, true);
    }

    public function playEngine1():void {
        play(getSounds().ENGINE_1, SfxLoop.INFINITE_LOOP);
    }

    public function playEngine2():void {
        play(getSounds().ENGINE_2, SfxLoop.INFINITE_LOOP);
    }

    public function playClick():void {
        play(getSounds().CLICK);
    }

    public function playBorderRicochet():void {
        play(getSounds().RICOCHET_WALL);
    }

    public function playBrickRicochet():void {
        play(getSounds().RICOCHET_BRICK);
    }

    public function playEagleExplode():void {
        play(getSounds().BIG_EXPLODE);
    }

    public function playIntro():void {
        playOnly(getSounds().INTRO);
    }

    public function playBonusAppear():void {
        play(getSounds().BONUS_APPEAR);
    }

    public function playBonusTaken():void {
        play(getSounds().BONUS_TAKEN);
    }

    public function playBonusLife():void {
        play(getSounds().BONUS_LIFE);
    }


}
}
