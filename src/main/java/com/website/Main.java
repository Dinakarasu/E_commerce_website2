package com.website;

import java.io.*;
import java.util.Enumeration;
import java.util.jar.*;
import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

public class Main {
    public static void main(String[] args) throws Exception {
        String port = System.getenv("PORT");
        if (port == null) port = "8080";

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));
        tomcat.getConnector();

        // Extract webapp from JAR to temp directory
        File tempDir = new File(System.getProperty("java.io.tmpdir"), "webapp");
        if (tempDir.exists()) deleteDir(tempDir);
        tempDir.mkdirs();

        // Create WEB-INF/classes directory
        File webInfClasses = new File(tempDir, "WEB-INF/classes");
        webInfClasses.mkdirs();

        String jarPath = Main.class.getProtectionDomain()
            .getCodeSource().getLocation().toURI().getPath();

        JarFile jar = new JarFile(jarPath);
        Enumeration<JarEntry> entries = jar.entries();
        while (entries.hasMoreElements()) {
            JarEntry entry = entries.nextElement();
            String name = entry.getName();

            File outFile = null;

            if (name.startsWith("webapp/")) {
                // JSP and web files
                outFile = new File(tempDir, name.substring("webapp/".length()));
            } else if (name.endsWith(".class") && !name.startsWith("org/")
                    && !name.startsWith("com/mysql")
                    && !name.startsWith("javax/")
                    && !name.startsWith("com/sun/")) {
                // App class files → WEB-INF/classes
                outFile = new File(webInfClasses, name);
            }

            if (outFile != null) {
                if (entry.isDirectory()) {
                    outFile.mkdirs();
                } else {
                    outFile.getParentFile().mkdirs();
                    try (InputStream in = jar.getInputStream(entry);
                         FileOutputStream out = new FileOutputStream(outFile)) {
                        byte[] buf = new byte[4096];
                        int len;
                        while ((len = in.read(buf)) > 0)
                            out.write(buf, 0, len);
                    }
                }
            }
        }
        jar.close();
        System.out.println("Webapp ready at: " + tempDir.getAbsolutePath());

        Context ctx = tomcat.addWebapp("", tempDir.getAbsolutePath());
        ctx.setReloadable(false);

        tomcat.start();
        tomcat.getServer().await();
    }

    private static void deleteDir(File dir) {
        if (dir.isDirectory())
            for (File f : dir.listFiles()) deleteDir(f);
        dir.delete();
    }
}