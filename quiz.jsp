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
        color: black;
        background-color: rgba(0, 230, 118, 0.3);
    }

    .col-2, .col-6 {
        padding: 10px;
    }

    .row-head {
        background-color: #00c853;
        margin-bottom: 5px;
    }

    .row-body {
        transition: transform 0.5s ease;
    }

    .row-body:hover {
        background-color: rgb(0, 230, 118);
        transform: scale(1.03);
    }

    .modal-textbox {
        margin: 10px 0px;
    }

    .modal-header {
        background-color: #00BCD4;
    }

    #topBar {
        float: right;
        margin: 0px 0px 0px 10px;
    }

    label {
        color: grey;
    }
    </style>

    <script>
        const setValueToId = (id, value) => document.getElementById(id).value = value;

        const populateUpdateForm = function (questionid, question, op1, op2, op3, op4, answer) {
            setValueToId("questionId", questionId);
            setValueToId("updateQuestion", question);
            setValueToId("updateOption1", op1);
            setValueToId("updateOption2", op2);
            setValueToId("updateOption3", op3);
            setValueToId("updateOption4", op4);
            document.getElementById("answer"+answer.toUpperCase()).selected = true;
        }
    </script>
</head>
<body style="background-color: #455A64;">

<%@page import="models.User"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   --%>
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
<%@include file="404.html"%>
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
                
                <label for="option1">Options</label>
                <input type="text" class="form-control modal-textbox" placeholder="Option 1" name="option1" id="option1" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 2" name="option2" id="option2" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 3" name="option3" id="option3" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 4" name="option4" id="option4" required />

                <label for="answer">Select Answer</label>
                <select class="form-control modal-textbox" id="answer" name="answer" required>
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
                
                <label for="updateOption1">Options</label>
                <input type="text" class="form-control modal-textbox" placeholder="Option 1" name="updateOption1" id="updateOption1" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 2" name="updateOption2" id="updateOption2" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 3" name="updateOption3" id="updateOption3" required />
                <input type="text" class="form-control modal-textbox" placeholder="Option 4" name="updateOption4" id="updateOption4" required />

                <label for="updateAnswer">Select Answer</label>
                <select class="form-control modal-textbox" id="updateAnswer" name="updateAnswer" required>
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
        <%
            if(questions.size() > 0) {
        %>
            <a href="presentation.jsp?id=<%=quiz.getId()%>" id="topBar" class="btn btn-light"><i class="fa-solid fa-desktop"></i> Present</a>
        <%
            }
        %>
            <div id="topBar" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addQuestionModal"><i class="fas fa-plus"></i> Add Question</div>
        <div>

        <br>
        <br>

        <div class="row row-head">
            <div class="col-2 text-center">
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
            <div class="col-2 text-center">
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
                <a class="delete-quiz" href="DeleteQuestionController?id=<%=question.getId()%>&quizid=<%=quiz.getId()%>&email=<%=user.getEmail()%>">
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