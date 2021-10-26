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

    <script>
        function populateUpdateForm(questionid, question, op1, op2, op3, op4, answer) {
            document.getElementById("questionId").value = questionid;
            document.getElementById("updateQuestion").value = question;
            document.getElementById("updateOption1").value = op1;
            document.getElementById("updateOption2").value = op2;
            document.getElementById("updateOption3").value = op3;
            document.getElementById("updateOption4").value = op4;
            document.getElementById("answer"+answer.toUpperCase()).selected = true;
        }
    </script>
</head>
<body style="background-color: #455A64;">

<%@page import="models.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
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

    <!-- Edit Question Modal -->
    <div class="modal fade" id="editQuestionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Update Question</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form action="UpdateQuestionController" method="POST">
            <div class="modal-body">
                <input type="text" class="form-control modal-textbox" placeholder="Question" name="updateQuestion" id="updateQuestion" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 1" name="updateOption1" id="updateOption1" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 2" name="updateOption2" id="updateOption2" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 3" name="updateOption3" id="updateOption3" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 4" name="updateOption4" id="updateOption4" required />

                <select class="form-control modal-textbox" name="updateAnswer" required>
                    <option id="answerA">A</option>
                    <option id="answerB">B</option>
                    <option id="answerC">C</option>
                    <option id="answerD">D</option>
                </select>
                <input type="hidden" name="quizId" id="quizId" value="<%=quizid%>">
                <input type="hidden" name="questionId" id="questionId">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-info">Update</button>
            </div>
        </form>
        </div>
    </div>
    </div>

<%-- M O D A L S    E N D    H E R E --%>

    <div class="container">
        <h1 class="display-5 text-center" style="color: white; padding: 20px;"><%=quiz.getTopic()%></h1>

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
        <div class="row row-body">
            <div class="col-2">
                <%=(i+1)%>
            </div>

            <div class="col-6">
                <%=question.getQuestion()%>
            </div>
            
            <div class="col-2 text-center">
                <span class="view-quiz" data-bs-toggle="modal" data-bs-target="#editQuestionModal" onclick="populateUpdateForm('<%=question.getId()%>', '<%=question.getQuestion()%>', '<%=question.getOption1()%>', '<%=question.getOption2()%>', '<%=question.getOption3()%>', '<%=question.getOption4()%>', '<%=question.getAnswer().toUpperCase()%>')">
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
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

</body>
</html>