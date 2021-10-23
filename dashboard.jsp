<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <title>Dashboard</title>
    <style>
    .text-center {
        text-align: center;
    }

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
        transition: transform 0.5s ease;
    }

    .card:hover, .card-body:hover, .card-header:hover {
        background-color: rgba(255, 193, 7, 1);
    }

    .card:hover {
        transform: scale(1.1);
    }

    .card-header {
        font-size: 20px;
    }

    .card-body {
        background-color: #CFD8DC;
    }

    .modal-header {
        background-color: rgba(255, 193, 7, 1);
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
    
    <%@include file="navTemplate.html"%>

    <!-- Create Quiz Modal -->
    <div class="modal fade" id="createQuizModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="CreateQuizController" method="POST">
            <div class="modal-body">
                <input type="text" class="form-control" placeholder="Quiz Topic" name="topic" id="topic" required />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-warning">Create</button>
            </div>
        </form>
        </div>
    </div>
    </div>

    <!-- Participate Quiz Modal -->
    <div class="modal fade" id="participateQuizModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="participateQuizModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="participate.jsp" method="POST">
            <div class="modal-body">
                <input type="text" class="form-control" placeholder="Quiz ID" name="quizid" id="participatequizid" required />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-warning">Participate</button>
            </div>
        </form>
        </div>
    </div>
    </div>

    <div class="container">
        <div class="row" style="margin-top: 50px;">
            <div class="col-md-6 class">
                <div class="card border-warning mb-3" style="max-width: 18rem;" data-bs-toggle="modal" data-bs-target="#createQuizModal">
                    <div class="card-header bg-warning text-center" style="font-size: 30px;">
                        <i class="fas fa-plus"></i> Create
                    </div>
                    <img src="http://c.files.bbci.co.uk/18145/production/_113692689_quiz_1.png" alt="Quiz">
                    <div class="card-body">
                        <h5 class="card-title text-center">Create Your Own Quiz</h5>
                        <%-- <p class="card-text">...</p> --%>
                    </div>
                </div>
            </div>

            <div class="col-md-6 class">
                <div class="card border-warning mb-3" style="max-width: 18rem;" data-bs-toggle="modal" data-bs-target="#participateQuizModal">
                    <div class="card-header bg-warning text-center" style="font-size: 30px;">
                        <i class="fas fa-hat-wizard"></i> Participate
                    </div>
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8eU22cHOfoga04yvH-yKYNS6FPm9ZeVP2jw&usqp=CAU" alt="Quiz">
                    <div class="card-body">
                        <h5 class="card-title text-center">Participate In Global Quiz</h5>
                        <%-- <p class="card-text">...</p> --%>
                    </div>
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