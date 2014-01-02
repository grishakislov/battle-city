package ru.arlevoland.bc.game.battlestage.tank.sequencer {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.Main;
import ru.arlevoland.bc.game.battlestage.tank.*;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;

public class TankSpriteSequencer {

    private static const PLAYER_SPRITE_PREFIX:String = "PT";
    private static const AI_SPRITE_PREFIX:String = "AI";
    private static const DELIMITER:String = "_";

    public static function getSprite(request:SequencerRequest):TileAsset {

        if (request.tankType == ActorType.PLAYER) return getPlayerTankSprite(request);
        if (request.tankType == ActorType.AI) return getPlayerTankSprite(request);
        return null;

    }

    private static function getPlayerTankSprite(request:SequencerRequest):TileAsset {
        var tileName:String = PLAYER_SPRITE_PREFIX + request.level + DELIMITER + request.direction.getDirectionId() + request.animationKey;
        return App.assetManager.getTileAsset(tileName);
    }

    private static function getAITankSprite(request:SequencerRequest):TileAsset {
        return null;
    }

}
}
