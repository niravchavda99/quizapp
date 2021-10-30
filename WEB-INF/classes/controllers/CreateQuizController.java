package controllers;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Quiz;
import models.User;
import utils.Database;

@WebServlet("/CreateQuizController")
public class CreateQuizController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String topic = (String) request.getParameter("topic");

        Quiz quiz = null;
        try {
            quiz = Database.createQuiz(topic, user.getEmail());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            String url = quiz == null ? "dashboard.jsp" : ("quiz.jsp?id=" + quiz.getId());
            response.sendRedirect(url);
        }
    }
}
