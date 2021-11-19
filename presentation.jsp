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
        option1View.innerHTML = question.option1;
        option2View.innerHTML = question.option2;
        option3View.innerHTML = question.option3;
        option4View.innerHTML = question.option4;

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