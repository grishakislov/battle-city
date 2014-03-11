package ru.arlevoland.bc.game.battle_screen.tank.sequencer {
import ru.arlevoland.bc.game.App;
import ru.arlevoland.bc.game.battle_screen.world.ActorType;
import ru.arlevoland.bc.game.core.assets.model.TileAsset;

public class TankSpriteSequencer {

    private static const PLAYER_SPRITE_PREFIX:String = "P";
    private static const AI_SPRITE_PREFIX:String = "E";

    public static function getSprite(request:SequencerRequest):TileAsset {

        if (request.tankType == ActorType.PLAYER) return getPlayerTankSprite(request);
        if (request.tankType == ActorType.AI) return getPlayerTankSprite(request);
        return null;

    }

    private static function getPlayerTankSprite(request:SequencerRequest):TileAsset {
        var tileName:String = PLAYER_SPRITE_PREFIX + request.level + request.direction.getDirectionId() + request.animationKey;
        return App.assetManager.getTileAsset(tileName);
    }

    private static function getAITankSprite(request:SequencerRequest):TileAsset {
        return null;
    }

}
}
