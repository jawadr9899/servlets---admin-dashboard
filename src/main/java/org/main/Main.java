package org.main;

import org.apache.catalina.Context;
import org.apache.catalina.Wrapper;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class Main {

    public static void main(String[] args) throws Exception {

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(3000);
        tomcat.getConnector();

        String webappDir = new File("src/main/webapp").getAbsolutePath();
        System.out.println(webappDir);
        Context context = tomcat.addWebapp("", webappDir);

        context.addLifecycleListener(new org.apache.catalina.startup.Tomcat.FixContextListener());

        Wrapper jspServlet = (Wrapper) context.findChild("jsp");
        if (jspServlet != null) {
            jspServlet.addInitParameter("development", "true");   // enables reload on change
            jspServlet.addInitParameter("modificationTestInterval", "1"); // check every 1 sec
        }

        // Register Servlets
        Tomcat.addServlet(context, "RootController", new AuthController());
        context.addServletMappingDecoded("", "RootController");

        Tomcat.addServlet(context, "ErrorController",new ErrorController());
        context.addServletMappingDecoded("/error","ErrorController");

        Tomcat.addServlet(context,"DashboardController", new DashboardController());
        context.addServletMappingDecoded("/dashboard", "DashboardController");

        Tomcat.addServlet(context,"ViewProductsController",new ViewProductsController());
        context.addServletMappingDecoded("/products", "ViewProductsController");


        tomcat.start();
        tomcat.getServer().await();
    }
}