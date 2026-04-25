package com.website;

import java.io.*;
import java.net.URL;
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

        // Get the JAR file path
        String jarPath = Main.class.getProtectionDomain()
            .getCodeSource().getLocation().toURI().getPath();
        System.out.println("JAR path: " + jarPath);

        // Extract all webapp/* files from JAR
        JarFile jar = new JarFile(jarPath);
        Enumeration<JarEntry> entries = jar.entries();
        while (entries.hasMoreElements()) {
            JarEntry entry = entries.nextElement();
            String name = entry.getName();
            if (name.startsWith("webapp/")) {
                File outFile = new File(tempDir,
                    name.substring("webapp/".length()));
                if (entry.isDirectory()) {
                    outFile.mkdirs();
                } else {
                    outFile.getParentFile().mkdirs();
                    try (InputStream in = jar.getInputStream(entry);
                         FileOutputStream out = new FileOutputStream(outFile)) {
                        byte[] buf = new byte[4096];
                        int len;
                        while ((len = in.read(buf)) > 0) {
                            out.write(buf, 0, len);
                        }
                    }
                }
            }
        }
        jar.close();
        System.out.println("Extracted to: " + tempDir.getAbsolutePath());
        System.out.println("Files: " + tempDir.listFiles().length);

        Context ctx = tomcat.addWebapp("", tempDir.getAbsolutePath());
        ctx.setReloadable(false);

        tomcat.start();
        tomcat.getServer().await();
    }

    private static void deleteDir(File dir) {
        if (dir.isDirectory()) {
            for (File f : dir.listFiles()) deleteDir(f);
        }
        dir.delete();
    }
}