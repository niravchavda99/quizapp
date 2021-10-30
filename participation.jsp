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

        .questions-container {
            background-color: rgba(0, 200, 83);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }

        .question {
            padding: 10px;
        }

        .option {
            padding: 5px 40px;
        }

        .next {
            margin-top: 10px;
            margin-left: 20px;
        }
    </style>
    <script>
        var allQuestions = [];
    </script>
<body style="background-color: #455A64;">

<%@page import="models.User"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   --%>
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
    boolean quizExists = Database.quizExists(quizid);

    if(!quizExists) {
%>
<%@include file="404.html"%>
<%
        return;
    }
%>

<script>
    const wsUrl = window.location.protocol === 'http:' ? 'ws://' : 'wss://';
    const broadcastSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/BroadcastController");
</script>

<div class="container questions-container">
    <%-- Question --%>
    <div class="display-6 question" id="question"></div>
    
    <%-- Option 1 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
        <label class="form-check-label" for="flexRadioDefault1" id="option1Label">
        </label>
    </div>

    <%-- Option 2 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
        <label class="form-check-label" for="flexRadioDefault2" id="option2Label">
        </label>
    </div>

    <%-- Option 3 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3">
        <label class="form-check-label" for="flexRadioDefault3" id="option3Label">
        </label>
    </div>

    <%-- Option 4 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault4">
        <label class="form-check-label" for="flexRadioDefault4" id="option4Label">
        </label>
    </div>

    <%-- Next Button --%>
    <button class="btn btn-dark next" id="next">Next <i class="fa-solid fa-angles-right"></i></button>
</div>

<script>
    const questionView = document.getElementById("question");
    const option1View = document.getElementById("option1Label");
    const option2View = document.getElementById("option2Label");
    const option3View = document.getElementById("option3Label");
    const option4View = document.getElementById("option4Label");

    broadcastSocket.onopen = function(event) {
        console.log('Connected!');
    }

    broadcastSocket.onmessage = function({data}) {
        // console.log(data);
        const question = JSON.parse(data);
        questionView.innerHTML = question.question;
        option1View.innerHTML = question.option1;
        option2View.innerHTML = question.option2;
        option3View.innerHTML = question.option3;
        option4View.innerHTML = question.option4;
    }

    broadcastSocket.onerror = function(event) {
        console.log("Error ", event)
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
</body>
</html>