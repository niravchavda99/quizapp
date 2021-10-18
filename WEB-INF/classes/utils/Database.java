package utils;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import models.Question;
import models.Quiz;
import models.User;

public class Database {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/quizapp";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    public static User validateUser(String email, String password) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
                Statement statement = connection.createStatement()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String sql = "SELECT * FROM users WHERE email='" + email + "' AND BINARY password='" + password + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            User user = null;

            if (resultSet.next()) {
                user = new User();
                user.setEmail(resultSet.getString("email"));
                user.setName(resultSet.getString("name"));
                user.setPassword(resultSet.getString("password"));
                user.setPhone(resultSet.getString("phone"));
                user.setIsVerified(resultSet.getBoolean("isVerified"));
            }

            return user;
        } catch (Exception e) {
            System.out.println("Error in database: " + e.getMessage());
            return null;
        }
    }

    public static boolean verifyUser(User user) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("UPDATE users SET isVerified=1 WHERE email='%s'", user.getEmail());

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static User registerUser(String name, String email, String password, String phone)
            throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format(
                "INSERT INTO users (name, email, password, phone, isVerified) VALUES('%s', '%s', '%s', '%s', 0)", name,
                email, password, phone);
        int count = statement.executeUpdate(sql);

        User user = null;

        if (count > 0) {
            user = new User();
            user.setEmail(email);
            user.setName(name);
            user.setPassword(password);
            user.setPhone(phone);
        }

        return user;
    }

    public static List<Quiz> fetchQuizes(String email) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT * FROM quizes WHERE email='%s' ORDER BY timestamp DESC", email);

        List<Quiz> quizes = new ArrayList<>();

        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            Quiz quiz = new Quiz();
            quiz.setId(resultSet.getString("quizid"));
            quiz.setTopic(resultSet.getString("topic"));
            quiz.setTimestamp(resultSet.getTimestamp("timestamp"));

            quizes.add(quiz);
        }

        return quizes;
    }

    public static Quiz createQuiz(String topic, String email) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String id = Utils.getUniqueID(6);
        Timestamp timestamp = new Timestamp(new java.util.Date().getTime());
        String sql = String.format("INSERT INTO quizes VALUES('%s', '%s', '%s', '%s')", id, topic, email,
                timestamp.toString());
        int count = statement.executeUpdate(sql);

        Quiz quiz = null;

        if (count > 0) {
            quiz = new Quiz();
            quiz.setId(id);
            quiz.setTopic(topic);
            quiz.setTimestamp(timestamp);
        }

        return quiz;
    }

    public static Quiz getQuiz(String email, String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT * FROM quizes WHERE BINARY quizid='%s' AND email='%s'", quizid, email);

        Quiz quiz = null;

        ResultSet resultSet = statement.executeQuery(sql);

        if (resultSet.next()) {
            quiz = new Quiz();
            quiz.setId(resultSet.getString("quizid"));
            quiz.setTopic(resultSet.getString("topic"));
            quiz.setTimestamp(resultSet.getTimestamp("timestamp"));
        }

        return quiz;
    }

    public static List<Question> fetchQuestions(String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT * FROM questions WHERE BINARY quizid='%s'", quizid);

        List<Question> questions = new ArrayList<>();

        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            Question question = new Question();

            question.setId(resultSet.getString("questionid"));
            question.setQuestion(resultSet.getString("question"));
            question.setOption1(resultSet.getString("option1"));
            question.setOption2(resultSet.getString("option2"));
            question.setOption3(resultSet.getString("option3"));
            question.setOption4(resultSet.getString("option4"));
            question.setAnswer(resultSet.getString("answer"));
            question.setQuizId(resultSet.getString("quizid"));
            question.setTimestamp(resultSet.getTimestamp("timestamp"));

            questions.add(question);
        }

        return questions;
    }
}
