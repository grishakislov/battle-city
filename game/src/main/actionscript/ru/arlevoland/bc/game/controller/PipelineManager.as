/**
 * @author antivoland
 */
package ru.arlevoland.bc.game.controller {
public class PipelineManager {
    private var channels:Object = {};

    public function getPipeLine(channelName:String):PipelineChannel {
        var channel:PipelineChannel = channels[channelName];
        if (channel == null) {
            channel = new PipelineChannel(this);
            channels[channelName] = channel;
        }
        return channel;
    }

    public function dispatchGameEvent(eventName:String, src:*):void {
        var message:ScreenMessage = new ScreenMessage(eventName, src);
        var channelName:String = PipelineChannel.SCREEN;  // TODO: move to signature
        getPipeLine(channelName).push(message);
    }
}
}
