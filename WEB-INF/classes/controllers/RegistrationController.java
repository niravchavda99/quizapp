package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import utils.Database;
import models.User;

@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        // Database connection Logic
        if (password.equals(repassword)) {
            User user = Database.registerUser(name, email, password);
            if (user != null) {
                pw.println(user.getName() + "<br>");
                pw.println(user.getEmail() + "<br>");
                pw.println(user.getPassword() + "<br>");
            } else {
                pw.println("Wrong Credentials");
            }
        } else {
            pw.println("Password dont match!");
        }

        // Session Management Logic
    }
}
