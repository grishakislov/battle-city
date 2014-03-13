package ru.codekittens.bc.server.conf;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.JavaType;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Settings {

    private List<LevelData> levels;
    private List<BigTile> bigTiles;
    private List<ImpactData> impactData;
    private Map<String, ImpactData> impactDataMap;

    public List<LevelData> getLevels() {
        return levels;
    }

    public void setLevels(List<LevelData> levels) {
        this.levels = levels;
    }

    public List<BigTile> getBigTiles() {
        return bigTiles;
    }

    public void setBigTiles(List<BigTile> bigTiles) {
        this.bigTiles = bigTiles;
    }

    public List<ImpactData> getImpactData() {
        return impactData;
    }

    public ImpactData getImpactData(String name) {
        return impactDataMap.get(name);
    }

    public void setImpactData(List<ImpactData> impactData) {
        this.impactData = impactData;
    }

    private void indexData() {
        impactDataMap = new HashMap<>();


        for (ImpactData data : impactData) {
            impactDataMap.put(data.getName(), data);
        }
    }

    public static Settings load() {

        Settings settings = new Settings();

        settings.setLevels(settings.read("levels.json", LevelData.class));
        settings.setBigTiles(settings.read("big_tiles.json", BigTile.class));
        settings.setImpactData(settings.read("impact_data.json", ImpactData.class));

        settings.indexData();

        return settings;
    }

    private <T> ArrayList<T> read(String fileName, Class<T> targetClass) {

        ObjectMapper mapper = new ObjectMapper();
        ArrayList<T> result;
        JavaType type = mapper.getTypeFactory().constructParametricType(ArrayList.class, targetClass);
        try {
            result = mapper.readValue(getClass().getResourceAsStream("/json/" + fileName), type);
        } catch (IOException e) {
            throw new Error(e);
        }
        return result;
    }

}
