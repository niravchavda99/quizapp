package utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import models.Question;
import models.Quiz;
import models.Score;
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
            System.out.println(sql);
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

    public static boolean quizExists(String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT * FROM quizes WHERE BINARY quizid='%s'", quizid);

        ResultSet resultSet = statement.executeQuery(sql);

        return resultSet.next();
    }

    public static List<Question> fetchQuestions(String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT * FROM questions WHERE BINARY quizid='%s' ORDER BY timestamp", quizid);

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

    public static boolean addQuestion(Question question) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format(
                "INSERT INTO questions VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",
                question.getId(), question.getQuestion(), question.getOption1(), question.getOption2(),
                question.getOption3(), question.getOption4(), question.getAnswer(), question.getQuizId(),
                question.getTimestamp().toString(), question.getQno());

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static boolean updateQuestion(String questionid, String question, String option1, String option2,
            String option3, String option4, String answer, String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format(
                "UPDATE questions SET question='%s', option1='%s', option2='%s', option3='%s', option4='%s', answer='%s' WHERE questionid='%s' AND quizid='%s'",
                question, option1, option2, option3, option4, answer, questionid, quizid);

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static boolean deleteRecord(String table, String type, String id)
            throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format("DELETE FROM %s WHERE %sid='%s'", table, type, id);

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static boolean submitResponse(String questionid, String email, String response)
            throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format("INSERT INTO responses VALUES('%s', '%s', '%s')", questionid, email, response);

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static List<Score> fetchScores(String quizid) throws SQLException, ClassNotFoundException {
        List<Score> scores = new ArrayList<>();

        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format(
                "SELECT responses.email, users.name, COUNT(responses.recordedAnswer) AS score FROM users, responses, questions WHERE users.email = responses.email AND questions.questionid=responses.questionid AND responses.questionid IN(SELECT questionid FROM questions WHERE quizid='%s') AND questions.answer=responses.recordedAnswer GROUP BY users.email ORDER BY score DESC",
                quizid);
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            Score score = new Score();

            User user = new User();
            user.setEmail(resultSet.getString("email"));
            user.setName(resultSet.getString("name"));

            score.setUser(user);
            score.setScore(resultSet.getInt("score"));

            scores.add(score);
        }

        return scores;
    }

    public static List<String> fetchCompletedQuizes(String email) throws SQLException, ClassNotFoundException {
        List<String> quizes = new ArrayList<>();

        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");

        String sql = String.format(
                "SELECT DISTINCT quizes.quizid, quizes.topic FROM responses, questions, quizes WHERE responses.questionid=questions.questionid AND questions.quizid=quizes.quizid AND quizes.email='%s'",
                email);
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next())
            quizes.add(resultSet.getString("quizid") + "," + resultSet.getString("topic"));

        return quizes;
    }

    public static Quiz getAttemptedQuiz(String email, String quizid) throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("SELECT DISTINCT quizes.* FROM questions, responses, quizes WHERE questions.questionid=responses.questionid AND quizes.quizid=questions.quizid AND responses.email='%s' AND questions.quizid='%s'", email, quizid);

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
}
