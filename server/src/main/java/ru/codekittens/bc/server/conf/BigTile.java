package ru.codekittens.bc.server.conf;

import java.util.List;

public class BigTile {

    private byte id;
    private String name;
    private List<String> tiles;

    public byte getId() {
        return id;
    }

    public void setId(byte id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getTiles() {
        return tiles;
    }

    public void setTiles(List<String> tiles) {
        this.tiles = tiles;
    }
}
