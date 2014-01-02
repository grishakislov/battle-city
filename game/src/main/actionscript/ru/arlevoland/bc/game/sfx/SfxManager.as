package ru.arlevoland.bc.game.sfx {
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;

import ru.arlevoland.bc.game.Main;

import ru.arlevoland.bc.GameSettings;
import ru.arlevoland.bc.game.core.assets.SoundAssets;
import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class SfxManager {

    private static const BEGIN:int = 46;
    private static const END:int = 75;

    public function initialize():void {

    }

    public function play(sound:Sound, loop:int = SfxLoop.NO_LOOP):void {
        if (!GameSettings.SOUND_ENABLED) return;

        if (backgroundPlays() && !soundIsBackground(sound)) {
            if (secondChannel != null) {
                secondChannel.stop();
                secondChannel = null;//TODO stop(channel)
            }
            secondSound = sound;
            secondChannel = secondSound.play();
            return;
        }

        stop();
        currentSound = sound;
        switch (loop) {
            case SfxLoop.NO_LOOP:

                channel = currentSound.play();
                channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
                break;
            case SfxLoop.INFINITE_LOOP:
                channel = currentSound.play(BEGIN);
                Ticker.addEventListener(TickerEvent.FPS, onEnterFrame);
                break;
            default:
                currentSound.play(0, loop);
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
        play(getSounds().INTRO);
    }


    private function soundIsBackground(sound:Sound):Boolean {
        return sound == getSounds().ENGINE_1 ||
                sound == getSounds().ENGINE_2;
    }

    private function backgroundPlays():Boolean {
        return currentSound == getSounds().ENGINE_1 ||
                currentSound == getSounds().ENGINE_2;
    }

    private function onSoundComplete(e:Event):void {
        channel = null;
        currentSound = null;
    }

    public function stop():void {
        Ticker.removeEventListener(TickerEvent.FPS, onEnterFrame);
        currentSound = null;
        if (channel != null) {
            channel.stop();
            channel = null;
        }
    }

    public function pause():void {
        if (!paused) {
            if (channel != null) {
                lastPosition = channel.position;
                channel.stop();
            }
            paused = true;
        } else {
            if (currentSound != null) {
                channel = currentSound.play(lastPosition);
            }
            paused = false;
        }
    }

    //TODO: Handle sound event
    private function onEnterFrame(e:TickerEvent):void {
        if (channel.position >= currentSound.length - END) {
            play(currentSound, SfxLoop.INFINITE_LOOP);
        }
    }

    private function getSounds():SoundAssets {
        return sounds;
    }

    private var lastPosition:Number;
    private var paused:Boolean = false;

    private var channel:SoundChannel;
    private var secondChannel:SoundChannel;
    private var currentSound:Sound;
    private var secondSound:Sound;

    private var sounds:SoundAssets = new SoundAssets();

}
}
