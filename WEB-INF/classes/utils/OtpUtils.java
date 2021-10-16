package utils;

import java.io.*;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

import models.OTP;

public class OtpUtils {
    private static String EMAIL = null;
    private static String PASSWORD = null;

    public static OTP generate() {
        OTP otp = new OTP();
        String value = new DecimalFormat("000000").format(new Random().nextInt(999999));
        otp.setValue(value);
        otp.setGeneratedAt(LocalDateTime.now());
        otp.setExpiry(LocalDateTime.now().plusMinutes(2));
        return otp;
    }

    public static void send(String to, OTP otp) {
        Properties props = new Properties();
        try {
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            InputStream input = classLoader.getResourceAsStream("email.properties");
            props.load(input);
            EMAIL = props.getProperty("EMAIL");
            PASSWORD = props.getProperty("PASSWORD");
        } catch (IOException e) {
            e.printStackTrace();
        }

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.starttls.required", "false");
        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("QuizApp - Verification Code");
            String text = String.format("%s is your OTP for QuizApp Verification. OTP is valid for 2 minutes.",
                    otp.getValue());
            message.setText(text);

            Transport.send(message);

            System.out.println("Done");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
