package com.website;

import java.io.File;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.apache.catalina.Context;

public class Main {
    public static void main(String[] args) throws Exception {
        String port = System.getenv("PORT");
        if (port == null) port = "8080";

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));
        tomcat.getConnector();

        // Look for webapp in multiple locations
        String webappPath = "src/main/webapp";
        File webappDir = new File(webappPath);
        if (!webappDir.exists()) {
            webappPath = "webapp";
            webappDir = new File(webappPath);
        }
        if (!webappDir.exists()) {
            webappDir.mkdirs();
        }

        Context ctx = tomcat.addWebapp("", webappDir.getAbsolutePath());

        // Add classes
        File additionWebInfClasses = new File("target/classes");
        if (additionWebInfClasses.exists()) {
            WebResourceRoot resources = new StandardRoot(ctx);
            resources.addPreResources(new DirResourceSet(resources,
                "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
            ctx.setResources(resources);
        }

        tomcat.start();
        tomcat.getServer().await();
    }
}