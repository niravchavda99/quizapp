<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Quiz</title>
    </head>
    <style>
        .text-center {
            text-align: center;
            margin: 0 auto;
        }
    </style>
<body style="background-color: #455A64;">

<%@page import="models.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%
        User user = (User) session.getAttribute("user");
        
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
<%@include file="navTemplate.html"%>
<%@page import="utils.Database"%>
<%@page import="models.Quiz"%>
<%@page import="models.Question"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>

<%
    String quizid = (String) request.getParameter("id");
    Quiz quiz = Database.getQuiz(user.getEmail(), quizid);


    if(quiz == null) {
%>
<%@include file="404.html"%>
<%
        return;
    }

    List<Question> questions = Database.fetchQuestions(quiz.getId());
    quiz.setQuestions(questions);

    for(int i = 0;i < questions.size(); i++) {
        %>
        <div><%=questions.get(i).getQuestion()%></div>
        <%
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

</body>
</html>