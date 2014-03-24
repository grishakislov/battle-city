package ru.codekittens.bc.game.sfx {
import flash.events.Event;
import flash.media.Sound;

import ru.codekittens.bc.game.GameSettings;
import ru.codekittens.bc.game.core.assets.SoundAssets;

public class SfxManager {


    public function initialize():void {
        mainChannel = new Channel();
        secondChannel = new Channel();
        loopChannel = new Channel();
    }

    public function playOnly(sound:Sound):void {
        onlySoundPlaying = true;
        loopChannel.toggleMute();
        mainChannel.stop();
        mainChannel.play(sound);
        mainChannel.getChannel().addEventListener(Event.SOUND_COMPLETE, onOnlySoundCompleted);
    }

    private function onOnlySoundCompleted(event:Event):void {
        loopChannel.toggleMute();
        mainChannel.stop();
        onlySoundPlaying = false;
    }

    public function play(sound:Sound, loop:int = SfxLoop.NO_LOOP, second:Boolean = false):void {

        if (!GameSettings.SOUND_ENABLED) return;

        if (onlySoundPlaying) {
            if (loop == SfxLoop.NO_LOOP) {
                return;
            }
        }

        switch (loop) {
            case SfxLoop.NO_LOOP:
                if (second) {
                    secondChannel.play(sound);
                } else {
                    mainChannel.play(sound);
                }
                break;

            case SfxLoop.INFINITE_LOOP:
            default:
                loopChannel.play(sound, loop)
                if (onlySoundPlaying) {
                    loopChannel.toggleMute();
                }
                break;
        }

    }


    private function stop():void {
        mainChannel.stop();
        secondChannel.stop();
        loopChannel.stop();
    }

    public function togglePause():void {
        mainChannel.togglePause();
        secondChannel.togglePause();
        loopChannel.togglePause();

        if (onlySoundPlaying && mainChannel.isPlaying()) {
            mainChannel.getChannel().addEventListener(Event.SOUND_COMPLETE, onOnlySoundCompleted);
        }
    }

    public function getSounds():SoundAssets {
        return sounds;
    }

    private var mainChannel:Channel;
    private var secondChannel:Channel;
    private var loopChannel:Channel;

    private var onlySoundPlaying:Boolean;
    private var sounds:SoundAssets = new SoundAssets();


}
}
