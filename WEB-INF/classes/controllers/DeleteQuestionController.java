package controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;
import utils.Database;

@WebServlet("/DeleteQuestionController")
public class DeleteQuestionController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) request.getParameter("email");

        if (!user.getEmail().equals(email)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String questionid = (String) request.getParameter("id");
        String quizid = (String) request.getParameter("quizid");

        try {
            Database.deleteRecord("questions", "question", questionid);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect("quiz.jsp?id=" + quizid);
        }
    }
}
