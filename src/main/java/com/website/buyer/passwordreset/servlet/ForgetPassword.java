package com.website.buyer.passwordreset.servlet;

import java.io.IOException;
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String email = request.getParameter("email");
            HttpSession mySession = request.getSession();

            LoginRepository repo = new LoginRepository(JdbcConnection.dbGetconnection());
            User forget = repo.Forgetpassword(email);

            // ✅ check user exists
            if (forget == null) {
                mySession.setAttribute("failedMsg", "Email not registered!");
                response.sendRedirect("forgetpassword.jsp");
                return;
            }

            // ✅ get name
            String name = forget.getName();
            if (name == null || name.trim().isEmpty()) {
                name = "Customer";
            }

            if (email != null && !email.isEmpty()) {

                // ✅ generate OTP
                Random rand = new Random();
                int otpvalue = rand.nextInt(90000) + 10000;

                String fromEmail = "selvadina17@gmail.com";
                String password = "oxfi xmou juvu bcft";

                // ✅ mail config
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.socketFactory.port", "465");
                props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.port", "465");

                Session session = Session.getInstance(props,
                        new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(fromEmail, password);
                            }
                        });

                // ✅ create email
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(fromEmail, "E-Commerce Team"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Reset Password - OTP");

                // ✅ HTML EMAIL CONTENT
                String htmlContent =
                        "<html>" +
                        "<body style='font-family: Segoe UI, Arial; background:#f4f4f4; padding:20px;'>" +

                        "<div style='max-width:600px; margin:auto; background:white; padding:20px; border-radius:10px;'>" +

                        "<h2>Hello, " + name + " 👋</h2>" +

                        "<p>We received a request to reset your password for your <b>E-Commerce Online Shopping</b> account.</p>" +

                        "<div style='text-align:center; margin:20px 0;'>" +
                        "<p>Your OTP is:</p>" +
                        "<h1 style='color:#2E86C1; letter-spacing:4px;'>" + otpvalue + "</h1>" +
                        "</div>" +

                        "<p>⏱ This OTP is valid for <b>10 minutes</b>.</p>" +
                        "<p style='color:red;'><b>Do not share this OTP with anyone.</b></p>" +

                        "<hr>" +

                        "<p style='font-size:12px; color:#888;'>If you didn’t request this, ignore this email and contact our support team immediately. </p>" +

                        "<p>Regards,<br><b>E-Commerce Team</b></p>" +

                        "</div></body></html>";

                // ✅ IMPORTANT FIX (HTML rendering)
                message.setContent(htmlContent, "text/html; charset=UTF-8");

                Transport.send(message);

                System.out.println("Email sent successfully");

                // ✅ store OTP in session
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);

                // ✅ redirect to OTP page
                RequestDispatcher dispatcher = request.getRequestDispatcher("otp.jsp");
                request.setAttribute("message", "OTP sent to your email");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}