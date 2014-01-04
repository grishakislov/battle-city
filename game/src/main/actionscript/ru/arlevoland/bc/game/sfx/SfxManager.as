package ru.arlevoland.bc.game.sfx {
import flash.events.Event;
import flash.media.Sound;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.SoundAssets;

public class SfxManager {


    public function initialize():void {
        mainChannel = new Channel();
        loopChannel = new Channel();
    }

    public function playOnly(sound:Sound):void {
        onlySoundPlaying = true;
        loopChannel.mute();
        mainChannel.stop();
        mainChannel.play(sound);
        mainChannel.getChannel().addEventListener(Event.SOUND_COMPLETE, onOnlySoundCompleted);
    }

    private function onOnlySoundCompleted(event:Event):void {
        loopChannel.mute();
        mainChannel.stop();
        onlySoundPlaying = false;
    }

    public function play(sound:Sound, loop:int = SfxLoop.NO_LOOP):void {

        if (!GameSettings.SOUND_ENABLED) return;

        if (onlySoundPlaying) {
            if (loop == SfxLoop.NO_LOOP) {
                return;
            }
        }

        switch (loop) {
            case SfxLoop.NO_LOOP:
                mainChannel.play(sound);
                break;

            case SfxLoop.INFINITE_LOOP:
            default:
                loopChannel.play(sound, loop)
                if (onlySoundPlaying) {
                    loopChannel.mute();
                }
                break;
        }

    }

    public function playShoot():void {
        play(getSounds().SHOOT);
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

    public function playIntro():void {
        playOnly(getSounds().INTRO);
    }

    private function stop():void {
        mainChannel.stop();
        loopChannel.stop();
    }

    public function pause():void {
        mainChannel.pause();
        loopChannel.pause();
    }


    private function getSounds():SoundAssets {
        return sounds;
    }

    private var mainChannel:Channel;
    private var loopChannel:Channel;

    private var onlySoundPlaying:Boolean;
    private var sounds:SoundAssets = new SoundAssets();

}
}
