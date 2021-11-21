<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Participate</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> 
</head>
<body>

<%@page import="models.User"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   --%>
    <%
        User user = (User) session.getAttribute("user");
        
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
<%@include file="navbar.jsp"%>
<%@page import="utils.Database"%>
<%@page import="models.Quiz"%>
<%@page import="models.Question"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@include file="scoreboard.html"%>

<%
    String quizid = (String) request.getParameter("quizid");
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
    const submitAnswerSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/SubmitAnswerController");
    const loadScoreboardSocket = new WebSocket(wsUrl + window.location.host + "/quizapp/FetchScoreboardController");
    const qId = "<%=quizid%>";
</script>

<h1 class="display-5 text-center mt-100" style="padding: 20px;">You are viewing presentation</h1>

<div class="container questions-container">
    <%-- Question --%>
    <div class="display-6 question" id="question"></div>
    <hr>
    <%-- Option 1 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="option1">
        <label class="form-check-label" for="option1" id="option1Label">
        </label>
    </div>

    <%-- Option 2 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="option2">
        <label class="form-check-label" for="option2" id="option2Label">
        </label>
    </div>

    <%-- Option 3 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="option3">
        <label class="form-check-label" for="option3" id="option3Label">
        </label>
    </div>

    <%-- Option 4 --%>
    <div class="form-check option">
        <input class="form-check-input" type="radio" name="flexRadioDefault" id="option4">
        <label class="form-check-label" for="option4" id="option4Label">
        </label>
    </div>
    <hr>
    <%-- Next Button --%>
    <button class="btn btn-dark next" id="next" onclick="next()" style="display: block;">Next <i class="fa-solid fa-angles-right"></i></button>
</div>

<%-- MODALS START HERE --%>

<!-- Waiting Modal -->
<div class="modal fade" id="waitingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title lead" id="staticBackdropLabel">Waiting for presenter to continue...</h5>
      </div>
    </div>
  </div>
</div>

<%-- MODALS END HERE --%>

<script>
    const questionView = document.getElementById("question");
    const option1View = document.getElementById("option1Label");
    const option2View = document.getElementById("option2Label");
    const option3View = document.getElementById("option3Label");
    const option4View = document.getElementById("option4Label");
    let question = null;

    function next() {
        $("#waitingModal").modal("show");
        const answer = getAnswer();
        console.log("answer", answer);
        submitAnswerSocket.send("questionid:" + question.questionId + ", email:<%=user.getEmail()%>, response:" + answer);
    }

    function clearSelection() {
        document.getElementById("option1").checked = document.getElementById("option2").checked = document.getElementById("option3").checked = document.getElementById("option4").checked = false;
    }

    function getAnswer() {
        console.log();
        if(document.getElementById("option1").checked) return 'a';
        if(document.getElementById("option2").checked) return 'b';
        if(document.getElementById("option3").checked) return 'c';
        if(document.getElementById("option4").checked) return 'd';
        return '0';
    }

    broadcastSocket.onopen = function(event) {
        console.log('Broadcast Connected!');
    }

    submitAnswerSocket.onopen = function(event) {
        console.log('Submit Answer Connected!');
    }

    const lastQuestionAction = () => {
        window.location = "scores.jsp?id=" + quizid;
    };

    broadcastSocket.onmessage = function({data}) {
        const tmp = JSON.parse(data);
        if('showScoreboard' in tmp) {
            hideModal();
            loadScoreboardSocket.send(qId);
            $("#scoreboardModal").modal("show");
            console.log("Got Here");
            return;
        }


        clearSelection();
        question = tmp;
        if(question.quizid != qId) return;
        
        if(question.isLast)
            document.getElementById("modalFooter").innerHTML = "<button class='btn btn-success btn-lg' onclick='lastQuestionAction()'>Final Scores</button>";

        questionView.innerHTML = question.question;
        option1View.innerHTML = question.option1;
        option2View.innerHTML = question.option2;
        option3View.innerHTML = question.option3;
        option4View.innerHTML = question.option4;
        document.getElementById("next").style.display = "block";
        hideModal();
    }

    submitAnswerSocket.onmessage = function({data}) {
        // $("$waitingModal").modal("hide");
        console.log("Submit Answer Response", data);
    }

    broadcastSocket.onerror = function(event) {
        console.log("Broadcast Error ", event);
    }

    submitAnswerSocket.onerror = function(event) {
        console.log("Submit Answer Error ", event);

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
        console.log("Load Scoreboard Participation Error ", event)
    }

    function hideModal() {
        $("#waitingModal").modal("hide");
        $("#scoreboardModal").modal("hide");
    }

    setTimeout(() => {
        $("#waitingModal").modal("show");
    }, 500);

    document.getElementById("modalFooter").innerHTML = "<div class='lead'>Waiting for host to continue...</div>";
</script>
<script src="assets/js/wow.min.js"></script>
<script src="assets/js/main.js"></script>
<jsp:include page="authfooter.jsp" />