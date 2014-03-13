package ru.codekittens.bc.server.conf;

public class ImpactData {
    private String name;
    private byte brushIndex;
    private boolean passable;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte getBrushIndex() {
        return brushIndex;
    }

    public void setBrushIndex(byte brushIndex) {
        this.brushIndex = brushIndex;
    }

    public boolean isPassable() {
        return passable;
    }

    public void setPassable(boolean passable) {
        this.passable = passable;
    }
}
