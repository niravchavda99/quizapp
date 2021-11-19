<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Presentation</title>
    <%@page import="models.User"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   --%>
<%
    User user = (User) session.getAttribute("user");
    
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<script>
    var allQuestions = [];
    const wsUrl = window.location.protocol === 'http:' ? 'ws://' : 'wss://';   
    const broadcastSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/BroadcastController");

    broadcastSocket.onopen = function(event) {
        // console.log("Connected!");
    }

    broadcastSocket.onmessage = function({data}) {
        // console.log(data);
    }

    broadcastSocket.onerror = function(event) {
        console.log("Error ", event)
    }

</script>
</head>
<body>
    
<%@include file="navbar.jsp"%>
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
%>
<%
    List<Question> questions = Database.fetchQuestions(quiz.getId());
    quiz.setQuestions(questions);

    for(int i = 0;i < questions.size(); i++) {
        Question question = questions.get(i);
        %>
        <%-- <div><%=question.getQuestion()%></div> --%>
        <script>
            allQuestions.push({
                questionId: "<%=question.getId()%>",
                question: "<%=question.getQuestion()%>",
                option1: "<%=question.getOption1()%>",
                option2: "<%=question.getOption2()%>",
                option3: "<%=question.getOption3()%>",
                option4: "<%=question.getOption4()%>",
                answer: "<%=question.getAnswer()%>",
                quizid: "<%=quizid%>"
            });
        </script>
        <%
    }
%>

<h1 class="display-5 text-center mt-100" style="padding: 20px;">You are presenting now</h1>

<div class="container questions-container m-50">
    <%-- Question --%>
    <div class="display-6 question" id="question"></div>
    <hr>
        <div style="padding: 10px;">
            <div class="lead" id="option1Label"></div>
            <div class="lead" id="option2Label"></div>        
            <div class="lead" id="option3Label"></div>
            <div class="lead" id="option4Label"></div>
        </div>
    <hr>
    <%-- Next Button --%>
    <button class="btn btn-dark next" id="next" onclick="nextQuestion()">Next <i class="fa-solid fa-angles-right"></i></button>
</div>

<script>
    // console.log(allQuestions);
    var current = 0;

    const questionView = document.getElementById("question");
    const option1View = document.getElementById("option1Label");
    const option2View = document.getElementById("option2Label");
    const option3View = document.getElementById("option3Label");
    const option4View = document.getElementById("option4Label");
    
    const loadQuestionInView = index => {
        const question = allQuestions[index];
        questionView.innerHTML = question.question;
        option1View.innerHTML = "A. " + question.option1;
        option2View.innerHTML = "B. " + question.option2;
        option3View.innerHTML = "C. " + question.option3;
        option4View.innerHTML = "D. " + question.option4;

        delete question.answer;
        setTimeout(() => {
            broadcastSocket.send(JSON.stringify(question)); 
        }, 500);
    }

    loadQuestionInView(current);

    const nextQuestion = () => {
        current++;
        if(current >= allQuestions.length) {
            document.getElementById("next").disabled = true;
            return;
        }
        loadQuestionInView(current);
    }

</script>
<script src="assets/js/wow.min.js"></script>
<script src="assets/js/main.js"></script>
<jsp:include page="authfooter.jsp" />