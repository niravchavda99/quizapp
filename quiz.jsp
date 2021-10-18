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
    .delete-quiz {
        color: red;
    }

    .delete-quiz:hover {
        color: #b50000;
    }

    .view-quiz {
        color: #FFC107;
        cursor: pointer;
    }

    .view-quiz:hover {
        color: #FB8C00;
    }

    .view-quiz, .delete-quiz {
        font-size: 20px;
    }

    .row {
        color: white;
        background-color: #0097A7;
    }

    .col-2, .col-6 {
        padding: 10px;
    }

    .row-head {
        background-color: #00838F;
    }

    .row-body:hover {
        background-color: #00BCD4;
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

    <!-- Add Question Modal -->
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
    <h1 class="display-5 text-center" style="color: white;">Quiz ID <%=quizid%> is unavailable!</h1>
<%
        return;
    }


    List<Question> questions = Database.fetchQuestions(quiz.getId());
    quiz.setQuestions(questions);
%>
    <div class="container">
        <h1 class="display-5 text-center" style="color: white; padding: 20px;"><%=quiz.getTopic()%></h1>
        <%-- <table class="table table-hover table-striped table-dark">
        <tr>
            <th class="text-center">Sr No.</th>
            <th>Question</th>
            <th class="text-center">Edit</th>
            <th class="text-center">Delete</th>
        </tr> --%>

        <div>
            <div class="btn btn-primary"><i class="fas fa-plus"></i> Add Question</div>
        <div>

        <br>

        <div class="row row-head">
            <div class="col-2">
                <b>Sr No.</b>
            </div>

            <div class="col-6">
                <b>Question</b>
            </div>
            
            <div class="col-2 text-center">
                <b>Edit</b>
            </div>
            
            <div class="col-2 text-center">
                <b>Delete</b>
            </div>
        </div>

<%
    for(int i = 0; i < questions.size(); i++) {
        Question question = questions.get(i); 
%>
        <%-- <tr>
            <td class="text-center"><%=(i+1)%></td>
            <td><%=question.getQuestion()%></td>
            <td class="text-center"><span class="view-quiz"><i class="fas fa-eye"></i></span></td>
            <td class="text-center"><a class="delete-quiz" href="DeleteQuestion?id=<%=question.getId()%>"><i class="fas fa-trash"></i></a></td>
        </tr> --%>

        <div class="row row-body">
            <div class="col-2">
                <%=(i+1)%>
            </div>

            <div class="col-6">
                <%=question.getQuestion()%>
            </div>
            
            <div class="col-2 text-center">
                <span class="view-quiz">
                    <i class="fas fa-pencil-alt"></i>
                </span>
            </div>
            
            <div class="col-2 text-center">
                <a class="delete-quiz" href="DeleteQuestion?id=<%=question.getId()%>">
                    <i class="fas fa-trash"></i>
                </a>
            </div>
        </div>
<%
    }
%>
        <%-- </table> --%>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

</body>
</html>