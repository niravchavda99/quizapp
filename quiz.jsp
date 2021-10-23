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

    .modal-textbox {
        margin: 10px 0px;
    }

    .modal-header {
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

<%-- M O D A L S    S T A R T    H E R E --%>

    <!-- Add Question Modal -->
    <div class="modal fade" id="addQuestionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Add Question</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="AddQuestionController" method="POST">
            <div class="modal-body">
                <input type="text" class="form-control modal-textbox" placeholder="Question" name="question" id="question" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 1" name="option1" id="option1" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 2" name="option2" id="option2" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 3" name="option3" id="option3" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 4" name="option4" id="option4" required />

                <select class="form-control modal-textbox" name="answer" required>
                    <option selected disabled>Answer</option>
                    <option>A</option>
                    <option>B</option>
                    <option>C</option>
                    <option>D</option>
                </select>
                <input type="hidden" name="quizid" id="quizid" value="<%=quizid%>">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-info">Create</button>
            </div>
        </form>
        </div>
    </div>
    </div>

<%-- M O D A L S    E N D    H E R E --%>

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
            <div class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addQuestionModal"><i class="fas fa-plus"></i> Add Question</div>
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
                <span class="view-quiz" data-bs-toggle="modal" data-bs-target="#editQuestionModal<%=i%>">
                    <i class="fas fa-pencil-alt"></i>
                </span>
            </div>
            
            <div class="col-2 text-center">
                <a class="delete-quiz" href="DeleteQuestion?id=<%=question.getId()%>">
                    <i class="fas fa-trash"></i>
                </a>
            </div>
        </div>

        <!-- Edit Question Modal -->
    <div class="modal fade" id="editQuestionModal<%=i%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Edit Question</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="AddQuestionController" method="POST">
            <div class="modal-body">
                <input type="text" class="form-control modal-textbox" placeholder="Question" name="question" id="question" required value="<%=question.getQuestion()%>" />
                <input type="text" class="form-control modal-textbox" placeholder="Option 1" name="option1" id="option1" required value="<%=question.getOption1()%>" />
                <input type="text" class="form-control modal-textbox" placeholder="Option 2" name="option2" id="option2" required value="<%=question.getOption2()%>" />
                <input type="text" class="form-control modal-textbox" placeholder="Option 3" name="option3" id="option3" required value="<%=question.getOption3()%>" />
                <input type="text" class="form-control modal-textbox" placeholder="Option 4" name="option4" id="option4" required value="<%=question.getOption4()%>" />

                <select class="form-control modal-textbox" name="answer" required>
                    <option>A</option>
                    <option>B</option>
                    <option>C</option>
                    <option>D</option>
                </select>
                <input type="hidden" name="quizid" id="quizid" value="<%=quizid%>">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-info">Create</button>
            </div>
        </form>
        </div>
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