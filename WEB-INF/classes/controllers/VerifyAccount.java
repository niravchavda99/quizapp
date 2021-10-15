package controllers;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.Period;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;
import utils.Database;

@WebServlet("/VerifyAccount")
public class VerifyAccount extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String enteredOtp = request.getParameter("verifyOtp");
        System.out.println("Entered: "+enteredOtp);
        System.out.println("Original: "+user.getOtp().getValue());
        System.out.println(enteredOtp.equals(user.getOtp().getValue()));
        if(enteredOtp.equals(user.getOtp().getValue())) {
            try {
                Database.verifyUser(user);
                response.sendRedirect("dashboard.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("login.jsp");
            }
        } else {
            session.setAttribute("otpErrorMessage", "Invalid OTP!");
            response.sendRedirect("verifyAccount.jsp");
        }
    }
}