package ru.codekittens.bc.game.sfx {
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import ru.codekittens.bc.game.time.Ticker;

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
            Ticker.addTickListener(onEnterFrame)
        }
    }

    public function toggleMute():void {
        if (channel == null) {
            return;
        }
        muted = !muted;
        applyMute();

    }

    public function togglePause():void {

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
        applyMute();
    }

    public function stop():void {
        reset();
    }

    public function isPlaying():Boolean {
        return playing;
    }

    private function applyMute():void {
        channel.soundTransform = muted ? VOLUME_DOWN : VOLUME_UP;
    }

    private function playCurrentSound():void {
        var start:int = looped ? BEGIN : 0;
        channel = this.sound.play(start);

        playing = true;
    }

    private function reset():void {
        if (looped) {
            Ticker.removeTickListener(onEnterFrame);
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

    private function onEnterFrame(dt:uint):void {
        if (channel.position >= sound.length - END) {
            channel.stop();
            playCurrentSound();
            applyMute();
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
