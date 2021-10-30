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

@WebServlet("/UpdateQuestionController")
public class UpdateQuestionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String questionid = request.getParameter("questionId");
        String question = request.getParameter("updateQuestion");
        String option1 = request.getParameter("updateOption1");
        String option2 = request.getParameter("updateOption2");
        String option3 = request.getParameter("updateOption3");
        String option4 = request.getParameter("updateOption4");
        String answer = request.getParameter("updateAnswer");
        String quizid = request.getParameter("quizId");

        try {
            Database.updateQuestion(questionid, question, option1, option2, option3, option4, answer, quizid);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect("quiz.jsp?id=" + quizid);
        }
    }
}
