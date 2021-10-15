package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import models.OTP;
import models.User;
import utils.Database;
import utils.OtpUtils;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);

        User user = (User) session.getAttribute("user");
        String location = user == null ? "login.jsp" : "dashboard.jsp";
        response.sendRedirect(location);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = Database.validateUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            
            if(!user.getIsVerified()) {
                OTP otp = OtpUtils.generate();
                user.setOtp(otp);
                session.setAttribute("user", user);

                // Send OTP from here...
                response.sendRedirect("verifyAccount.jsp");
                return;
            }

            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid Credentials!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}