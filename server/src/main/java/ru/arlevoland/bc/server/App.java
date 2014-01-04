package ru.arlevoland.bc.server;

import com.google.inject.Injector;
import org.apache.commons.configuration.PropertiesConfiguration;

public class App {
    public static enum RunMode {local, test, prod, locked}

    public static PropertiesConfiguration config;
    public static RunMode runMode;
    public static RunMode startMode;
    public static Injector injector;
}
