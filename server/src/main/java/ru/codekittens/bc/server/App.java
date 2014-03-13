package ru.codekittens.bc.server;

import com.google.inject.Injector;
import org.apache.commons.configuration.PropertiesConfiguration;
import ru.codekittens.bc.server.conf.Settings;

public class App {
    public static enum RunMode {local, test, prod, locked}

    public static PropertiesConfiguration config;
    public static Settings settings;
    public static RunMode runMode;
    public static RunMode startMode;
    public static Injector injector;
}
