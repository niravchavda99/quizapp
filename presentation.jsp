<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Presentation</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
    var scoreboard = null;
    const wsUrl = window.location.protocol === 'http:' ? 'ws://' : 'wss://';   
    const broadcastSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/BroadcastController");
    const loadScoreboardSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/FetchScoreboardController");

    broadcastSocket.onopen = function(event) {
        // console.log("Connected!");
    }

    broadcastSocket.onmessage = function({data}) {
        // console.log(data);
    }

    broadcastSocket.onerror = function(event) {
        console.log("Error ", event)
    }

    loadScoreboardSocket.onopen = function(event) {
        // console.log("Connected!");
    }

    loadScoreboardSocket.onmessage = function({data}) {
        data = data.replace(/'/g, '"');
        scoreboard = JSON.parse(data).scores;

        const dataTable = document.getElementById("dataTable");

        dataTable.innerHTML = "";
        for(let  i = 0; i < scoreboard.length; i++)
            dataTable.innerHTML += "<tr><th scope='row'>" + i + "</th><td>" + scoreboard[i].name + "</td><td>" + scoreboard[i].score + "</td></tr>";
    }

    loadScoreboardSocket.onerror = function(event) {
        console.log("Load Scoreboard Persentation Error ", event)
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
<%@include file="scoreboard.html"%>

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

    for(int i = 0; i < questions.size(); i++) {
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
                quizid: "<%=quizid%>",
                isLast: false
            });
        </script>
        <%
    }
%>

<h1 class="display-5 text-center mt-100">You are presenting now</h1>
<div class="display-5 text-center mt-10">Quiz Code: <%=quizid%></div>

<div class="container text-center mt-100" id="quizInitial">
    <button class="btn btn-lg btn-info" onclick="startQuiz()" style="font-size: 30px">
        Start Quiz
    </button>
</div>

<div class="container questions-container m-50" id="questionContainer" style="display: none">
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
    <button class="btn btn-dark next" id="next" onclick="loadScoreboard()">Next <i class="fa-solid fa-angles-right"></i></button>
</div>

<script>
    // console.log(allQuestions);
    var current = 0;
    var quizid = "<%=quizid%>";

    const questionView = document.getElementById("question");
    const option1View = document.getElementById("option1Label");
    const option2View = document.getElementById("option2Label");
    const option3View = document.getElementById("option3Label");
    const option4View = document.getElementById("option4Label");

    allQuestions[allQuestions.length - 1].isLast = true;
    
    const startQuiz = () => {
        document.getElementById("quizInitial").style.display = "none";
        document.getElementById("questionContainer").style.display = "block";
        loadQuestionInView(current);
    }

    const lastQuestionAction = () => {
        window.location = "scores.jsp?id=" + quizid;
    };

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

        if(question.isLast) {
            const btn = document.getElementById("nextQuestionModalBtn");
            btn.className = "btn btn-success btn-lg";
            btn.innerHTML = "Final Scores";
            btn.addEventListener("click", lastQuestionAction, true);
        }
    }

    const loadScoreboard = () => {
        broadcastSocket.send(JSON.stringify({showScoreboard: true}));
        loadScoreboardSocket.send(quizid);
        $("#scoreboardModal").modal("show");
    }

    const nextQuestion = () => {
        current++;
        if(current >= allQuestions.length) {
            // broadcastSocket.send(JSON.stringify({lastQuestion: true}));
            document.getElementById("next").disabled = true;
            return;
        }
        loadQuestionInView(current);
    }

    document.getElementById("nextQuestionModalBtn").addEventListener("click", nextQuestion, true);
</script>
<script src="assets/js/wow.min.js"></script>
<script src="assets/js/main.js"></script>
<jsp:include page="authfooter.jsp" />