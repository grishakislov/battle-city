/**
 * @author antivoland
 */
package ru.arlevoland.bc.game.controller {
public class PipelineManager {
    private var channels:Object = {};

    public function getPipeLine(channelName:String):PipelineChannel {
        var channel:PipelineChannel = channels[channelName];
        if (channel == null) {
            channel = new PipelineChannel();
            channels[channelName] = channel;
        }
        return channel;
    }
}
}
