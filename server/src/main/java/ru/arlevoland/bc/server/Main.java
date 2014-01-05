package ru.arlevoland.bc.server;

import com.google.inject.Guice;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    public static void main(String[] args) throws Exception {
        App.config = new PropertiesConfiguration("server.properties");
        App.runMode = App.RunMode.valueOf(App.config.getString("runMode"));
        App.startMode = App.RunMode.valueOf(App.config.getString("runMode"));
        App.injector = Guice.createInjector();

        LoggerFactory.getLogger(Main.class).info("Hello, World!");
        LoggerFactory.getLogger(App.class).info("Hello, App!");
        LoggerFactory.getLogger(App.RunMode.class).info("Hello!");
    }
}
