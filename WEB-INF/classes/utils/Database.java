package utils;

import java.sql.*;

import models.User;

public class Database {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";

    public static User validateUser(String email, String password) {
        try (Connection connection = DriverManager.getConnection(DB_URL + "quizapp", DB_USERNAME, DB_PASSWORD);
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

    public static boolean verifyUser(User user) throws Exception {
        Connection connection = DriverManager.getConnection(DB_URL + "quizapp", DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("UPDATE users SET isVerified=1 WHERE email='%s'", user.getEmail());

        int count = statement.executeUpdate(sql);

        return count > 0;
    }

    public static User registerUser(String name, String email, String password, String phone) throws Exception {
        Connection connection = DriverManager.getConnection(DB_URL + "quizapp", DB_USERNAME, DB_PASSWORD);
        Statement statement = connection.createStatement();
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = String.format("INSERT INTO users (name, email, password, phone, isVerified) VALUES('%s', '%s', '%s', '%s', 0)", name, email,
                password, phone);
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
}
