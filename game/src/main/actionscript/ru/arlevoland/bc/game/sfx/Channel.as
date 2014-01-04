package ru.arlevoland.bc.game.sfx {
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import ru.arlevoland.bc.game.time.Ticker;
import ru.arlevoland.bc.game.time.TickerEvent;

public class Channel {

    private static const BEGIN:int = 46;
    private static const END:int = 75;
    private static const VOLUME_DOWN:SoundTransform = new SoundTransform(0);
    private static const VOLUME_UP:SoundTransform = new SoundTransform(1);

    public function play(sound:Sound, sfxLoop:int = SfxLoop.NO_LOOP):void {
        reset();

        this.sound = sound;
        looped = sfxLoop != SfxLoop.NO_LOOP;
        playCurrentSound();

        if (sfxLoop == SfxLoop.INFINITE_LOOP) {
            Ticker.addEventListener(TickerEvent.TICK, onEnterFrame)
        }
    }

    public function mute():void {
        if (channel == null) {
            return;
        }
        muted = !muted;
        setMute();

    }

    public function pause():void {

        if (channel == null || sound == null) {
            return;
        }

        paused = !paused;

        if (paused) {
            lastPosition = channel.position;
            channel.stop();
        } else {
            channel = sound.play(lastPosition);
        }

        playing = !paused;
        setMute();
    }

    public function stop():void {
        reset();
    }

    public function isPlaying():Boolean {
        return playing;
    }

    private function setMute():void {
        channel.soundTransform = muted ? VOLUME_DOWN : VOLUME_UP;
    }

    private function playCurrentSound():void {
        var start:int = looped ? BEGIN : 0;
        channel = this.sound.play(start);

        playing = true;
    }

    private function reset():void {
        if (looped) {
            Ticker.removeEventListener(TickerEvent.TICK, onEnterFrame);
        }
        if (channel != null) {
            channel.stop();
        }

        channel = null;
        sound = null;

        paused = false;
        playing = false;
        muted = false;
        lastPosition = 0;
    }

    private function onEnterFrame(e:TickerEvent):void {
        if (channel.position >= sound.length - END) {
            channel.stop();
            playCurrentSound();
            setMute();
        }
    }

    public function getChannel():SoundChannel {
        return channel;
    }

    private var playing:Boolean = false;
    private var paused:Boolean = false;
    private var muted:Boolean = false;
    private var looped:Boolean;

    private var sound:Sound;
    private var channel:SoundChannel;
    private var lastPosition:Number;

}
}
