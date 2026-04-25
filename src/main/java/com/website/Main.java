package com.website;

import java.io.*;
import java.net.URL;
import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

public class Main {
    public static void main(String[] args) throws Exception {
        String port = System.getenv("PORT");
        if (port == null) port = "8080";

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));
        tomcat.getConnector();

        // Extract webapp from inside JAR to temp directory
        File tempDir = new File(System.getProperty("java.io.tmpdir"), "webapp");
        tempDir.mkdirs();
        extractWebapp(tempDir);

        System.out.println("Webapp extracted to: " + tempDir.getAbsolutePath());

        Context ctx = tomcat.addWebapp("", tempDir.getAbsolutePath());
        ctx.setReloadable(false);

        tomcat.start();
        tomcat.getServer().await();
    }

    private static void extractWebapp(File targetDir) throws Exception {
        URL resourceUrl = Main.class.getClassLoader().getResource("webapp");
        if (resourceUrl == null) {
            System.out.println("No webapp resource found in classpath!");
            return;
        }

        String jarPath = resourceUrl.getPath();
        System.out.println("Resource URL: " + jarPath);

        // Copy all webapp resources
        java.util.Enumeration<URL> resources = Main.class.getClassLoader()
            .getResources("webapp");
        while (resources.hasMoreElements()) {
            System.out.println("Found: " + resources.nextElement());
        }
    }
}