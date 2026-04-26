package com.website.buyer.passwordreset.servlet;

import java.io.*;
import java.net.*;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.website.jdbc.JdbcConnection;
import com.website.pojo.User;
import com.website.buyer.repository.LoginRepository;

@WebServlet("/ForgetPassword")
public class ForgetPassword extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        HttpSession mySession = request.getSession();

        try {
            LoginRepository repo = new LoginRepository(JdbcConnection.dbGetconnection());
            User forget = repo.Forgetpassword(email);

            if (forget == null) {
                mySession.setAttribute("failedMsg", "Email not registered!");
                response.sendRedirect("forgetpassword.jsp");
                return;
            }

            if (email == null || email.isEmpty()) {
                mySession.setAttribute("failedMsg", "Please enter a valid email!");
                response.sendRedirect("forgetpassword.jsp");
                return;
            }

            String name = forget.getName();
            if (name == null || name.trim().isEmpty()) name = "Customer";

            // Generate OTP
            Random rand = new Random();
            int otpvalue = rand.nextInt(90000) + 10000;

            // Store OTP in session
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);

            boolean emailSent = false;

            // Try Gmail SMTP first (works locally)
            try {
                String fromEmail = "selvadina17@gmail.com";
                String password = "oxfi xmou juvu bcft";

                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.connectiontimeout", "5000");
                props.put("mail.smtp.timeout", "5000");
                props.put("mail.smtp.writetimeout", "5000");

                Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(fromEmail, password);
                        }
                    });

                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(fromEmail, "E-Commerce Team"));
                message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(email));
                message.setSubject("Reset Password - OTP");

                String htmlContent =
                    "<html><body style='font-family:Arial;'>"
                    + "<h2>Hello, " + name + " 👋</h2>"
                    + "<p>Your OTP is:</p>"
                    + "<h1 style='color:#2E86C1;'>" + otpvalue + "</h1>"
                    + "<p>Valid for 10 minutes. Do not share.</p>"
                    + "<p>Regards,<br>E-Commerce Team</p>"
                    + "</body></html>";

                message.setContent(htmlContent, "text/html; charset=UTF-8");
                Transport.send(message);
                emailSent = true;
                System.out.println("Gmail sent successfully!");

            } catch (Exception gmailEx) {
                System.out.println("Gmail failed - trying Brevo...");

                // Try Brevo API (works on Railway)
                try {
                    String apiKey = System.getenv("BREVO_API_KEY");

                    String json = "{"
                        + "\"sender\":{\"name\":\"E Commerce\","
                        + "\"email\":\"selvadina17@gmail.com\"},"
                        + "\"to\":[{\"email\":\"" + email + "\"}],"
                        + "\"subject\":\"Reset Password OTP\","
                        + "\"htmlContent\":\"<h2>Hello " + name + "</h2>"
                        + "<p>Your OTP is: <b>" + otpvalue + "</b></p>"
                        + "<p>Valid 10 mins. Do not share.</p>\""
                        + "}";

                    URL url = new URL("https://api.brevo.com/v3/smtp/email");
                    HttpURLConnection con = (HttpURLConnection) url.openConnection();
                    con.setRequestMethod("POST");
                    con.setRequestProperty("api-key", apiKey);
                    con.setRequestProperty("Content-Type", "application/json");
                    con.setRequestProperty("Accept", "application/json");
                    con.setDoOutput(true);
                    con.setConnectTimeout(10000);
                    con.setReadTimeout(10000);

                    try (OutputStream os = con.getOutputStream()) {
                        os.write(json.getBytes("UTF-8"));
                    }

                    int responseCode = con.getResponseCode();
                    System.out.println("Brevo response: " + responseCode);

                    if (responseCode == 201) {
                        emailSent = true;
                        System.out.println("Brevo OTP sent!");
                    }

                } catch (Exception brevoEx) {
                    System.out.println("Brevo failed: " + brevoEx.getMessage());
                }
            }

            // Show message
            if (emailSent) {
                request.setAttribute("message",
                    "OTP sent to your email: " + email);
            } else {
                request.setAttribute("message",
                    "Email unavailable. Your OTP is: "
                    + otpvalue + " (Note this!)");
            }

            RequestDispatcher dispatcher =
                request.getRequestDispatcher("otp.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            mySession.setAttribute("failedMsg", "Error! Please try again.");
            response.sendRedirect("forgetpassword.jsp");
        }
    }
}