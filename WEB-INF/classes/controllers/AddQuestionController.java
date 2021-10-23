package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Question;
import models.User;
import utils.Database;
import utils.Utils;

@WebServlet("/AddQuestionController")
public class AddQuestionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String questionid = Utils.getUniqueID(8);
        String question = request.getParameter("question");
        String option1 = request.getParameter("option1");
        String option2 = request.getParameter("option2");
        String option3 = request.getParameter("option3");
        String option4 = request.getParameter("option4");
        String answer = request.getParameter("answer");
        String quizid = request.getParameter("quizid");
        Timestamp timestamp = new Timestamp(new java.util.Date().getTime());

        Question q = new Question();
        q.setId(questionid);
        q.setQuestion(question);
        q.setOption1(option1);
        q.setOption2(option2);
        q.setOption3(option3);
        q.setOption4(option4);
        q.setAnswer(answer);
        q.setQuizId(quizid);
        q.setTimestamp(timestamp);
        q.setQno(0);

        try {
            Database.addQuestion(q);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("quiz.jsp?id=" + q.getQuizId());
    }
}