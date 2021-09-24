package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import models.User;
import utils.Database;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter pw = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Database connection Logic
        User user = Database.validateUser(email, password);
        if (user != null) {
            pw.println(user.getName() + "<br>");
            pw.println(user.getEmail() + "<br>");
            pw.println(user.getPassword() + "<br>");
        } else {
            pw.println("Wrong Credentials");
        }

        // Session Management Logic

        // RequestDispatcher dispatcher =
        // request.getRequestDispatcher("/dashboard.jsp");
        // dispatcher.forward(request, response);
    }
}