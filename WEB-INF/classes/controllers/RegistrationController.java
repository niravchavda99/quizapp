package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import utils.Database;
import utils.OtpUtils;
import models.OTP;
import models.User;

@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        User user = (User) session.getAttribute("user");
        String location = user == null ? "login.jsp" : "dashboard.jsp";
        response.sendRedirect(location);
    }

    private void returnErrorRequest(String message, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        String errorMessage = "Some error occured. Please Try Again!";

        // Database connection Logic
        try {
            if (password.equals(repassword)) {
                User user = Database.registerUser(name, email, password, phone);
                if (user != null) {
                    HttpSession session = request.getSession(true);
                    OTP otp = OtpUtils.generate();
                    user.setOtp(otp);
                    session.setAttribute("user", user);
                    // response.sendRedirect("dashboard.jsp");
                    response.sendRedirect("verifyAccount.jsp");
                } else {
                    returnErrorRequest("Password dont match!", request, response);
                }
            } else {
                returnErrorRequest("Password dont match!", request, response);
            }
        } catch (SQLException e) {
            if (e.getMessage().startsWith("Duplicate entry"))
                errorMessage = "Email already registered!";
            System.out.println(e.getMessage());
            returnErrorRequest(errorMessage, request, response);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            System.out.println(e.getMessage());
            returnErrorRequest(errorMessage, request, response);
        }
    }
}
