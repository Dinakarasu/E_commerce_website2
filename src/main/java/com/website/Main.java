package com.website;

import java.io.File;
import org.apache.catalina.Context;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;

public class Main {
    public static void main(String[] args) throws Exception {
        String port = System.getenv("PORT");
        if (port == null) port = "8080";

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));
        tomcat.getConnector();

        // Try multiple webapp locations
        String[] possiblePaths = {
            "src/main/webapp",
            "webapp",
            "WebContent",
            "web"
        };

        File webappDir = null;
        for (String path : possiblePaths) {
            File f = new File(path);
            if (f.exists()) {
                webappDir = f;
                System.out.println("Found webapp at: " + f.getAbsolutePath());
                break;
            }
        }

        if (webappDir == null) {
            webappDir = new File("webapp");
            webappDir.mkdirs();
            System.out.println("No webapp found! Created empty at: " + webappDir.getAbsolutePath());
        }

        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());

        File classes = new File("target/classes");
        if (classes.exists()) {
            WebResourceRoot resources = new StandardRoot(ctx);
            resources.addPreResources(new DirResourceSet(
                resources, "/WEB-INF/classes",
                classes.getAbsolutePath(), "/"));
            ctx.setResources(resources);
        }

        tomcat.start();
        tomcat.getServer().await();
    }
}