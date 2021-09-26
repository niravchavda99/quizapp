<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Dashboard</title>
    <style>
    .class {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .container-fluid {
        margin-top: 10px;
    }

    .card {
        cursor: pointer;
    }

    .card:hover, .card-body:hover, .card-header:hover {
        background-color: rgba(255, 193, 7, 1);
    }

    .card-header {
        font-size: 20px;
    }

    .card-body {
        background-color: #CFD8DC;
    }
    </style>
</head>
<body style="background-color: #455A64;">
    <%@page import="models.User"%>
    <%
    
        User user = (User) session.getAttribute("user");
        
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="padding: 20px;">
        <a class="navbar-brand" href="dashboard.jsp">Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#">Profile</a>
                </li>
            </ul>
            <a class="btn btn-info" href="/quizapp/Logout">
                Logout                
            </a>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 class">
                <div class="card border-warning mb-3" style="max-width: 18rem;">
                    <div class="card-header bg-warning">Create</div>
                    <img src="http://c.files.bbci.co.uk/18145/production/_113692689_quiz_1.png" alt="Quiz">
                    <div class="card-body">
                        <h5 class="card-title">Create Your Own Quiz</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-6 class">
                <div class="card border-warning mb-3" style="max-width: 18rem;">
                    <div class="card-header bg-warning">Participate</div>
                    <img src="https://www.psd.gov.sg/images/default-source/challenge-library/lifestyle/trivia-quiz/triviaquiz/trivia-quiz-01-main-720x400.jpg" alt="Quiz">
                    <div class="card-body">
                        <h5 class="card-title">Participate In Global Quiz</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>
</body>
</html>