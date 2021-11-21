<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Presentation</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <%@page import="models.User"%>
<%
    User user = (User) session.getAttribute("user");
    
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
</head>
<body>
    
<%@include file="navbar.jsp"%>
<%@page import="utils.Database"%>
<%@page import="models.Quiz"%>
<%@page import="models.Score"%>
<%@page import="java.util.List"%>

<%
    String quizid = (String) request.getParameter("id");
    Quiz quiz = Database.getQuiz(user.getEmail(), quizid);


    if(quiz == null) {
%>
<%@include file="404.html"%>
<%
        return;
    }

    List<Score> scores = Database.fetchScores(quizid);
%>

<div class="container mt-120">
    <h1 class="display-4 text-center">Scoreboard</h1>
    <table class="table table-responsive table-hover">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">User</th>
                <th scope="col">Score</th>
            </tr>
        </thead>
        <tbody>
        <%
            for(int i = 0; i < scores.size(); i++) {
                Score score = scores.get(i);
                out.println("<tr>");
                out.println("<th scope='row'>" + (i + 1) + "</th>");
                out.println("<td>" + score.getUser().getName() + "</td>");
                out.println("<td>" + score.getScore() + "</td>");
                out.println("</tr>");
            }
        %>
        </tbody>
    </table>
    <div class="container text-center mt-50">
        <a href="quizes.jsp" class="btn btn-lg btn-primary">Back to Quizes</a>
        <a href="dashboard.jsp" class="btn btn-lg btn-danger">Back to Home</a>
    </div>
</div>

<script src="assets/js/wow.min.js"></script>
<script src="assets/js/main.js"></script>
<jsp:include page="authfooter.jsp" />