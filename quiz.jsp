<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/table.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
    <script>
        const setValueToId = (id, value) => document.getElementById(id).value = value;

        const populateUpdateForm = function (questionId, question, op1, op2, op3, op4, answer) {
            setValueToId("questionId", questionId);
            setValueToId("updateQuestion", question);
            setValueToId("updateOption1", op1);
            setValueToId("updateOption2", op2);
            setValueToId("updateOption3", op3);
            setValueToId("updateOption4", op4);
            document.getElementById("answer" + answer.toUpperCase()).selected = true;
        }
    </script>
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

<h1 class="display-5 text-center mt-100" style="padding: 20px;"><%=quiz.getTopic()%></h1>
    
    
    <div class="limiter">
        <%
        if(questions.size() > 0) {
        %>
            <a href="presentation.jsp?id=<%=quiz.getId()%>" id="topBar" class="btn btn-light"><i class="fa-solid fa-desktop"></i> Present</a>
        <%
            }
        %>
        <button id="topBar" class="btn btn-light" data-bs-toggle="modal" data-bs-target="#addQuestion"><i class="fas fa-plus"></i> Add Question</button>
        <div class="container-table100">
            <div class="wrap-table100">
                <div class="table100 ver1 m-b-110">
                    <div class="table100-head">
                        <table>
                            <thead>
                                <tr class="row100 head">
                                    <th class="cell100 column1">Sr. No</th>
                                    <th class="cell100 column2">Question</th>
                                    <th class="cell100 column4">Edit</th>
                                    <th class="cell100 column5">Delete</th>
                                </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="table100-body js-pscroll">
                        <table>
                            <tbody>
                                <%
                                    if(questions.size() > 0){
                                        for(int i = 0; i < questions.size(); i++) {
                                            Question question = questions.get(i); 
                                        %>
                                        <tr class="row100 body">
                                            <td class="cell100 column1"><%=(i+1)%></td>
                                            <td class="cell100 column2"><%=question.getQuestion()%></td>
                                            <td class="cell100 column4"><span class="view-quiz" data-bs-toggle="modal" data-bs-target="#editQuestionModal" onclick="populateUpdateForm('<%=question.getId()%>', '<%=question.getQuestion()%>', '<%=question.getOption1()%>', '<%=question.getOption2()%>', '<%=question.getOption3()%>', '<%=question.getOption4()%>', '<%=question.getAnswer().toUpperCase()%>')">
                                                <i class="fas fa-pencil-alt"></i>
                                            </span></td>
                                            <td class="cell100 column5"><a class="delete-quiz" href="DeleteQuestionController?id=<%=question.getId()%>&quizid=<%=quiz.getId()%>&email=<%=user.getEmail()%>">
                                                <i class="fas fa-trash"></i>
                                            </a></td>
                                        </tr>
                                        <%
                                        }
                                    } else {
                                    %>
                                    <tr class="row100 body">
                                        <td class="cell100 column1" colspan="4"><h2 class="text-center">Empty Question List.</h2></td>
                                    </tr>
                                <%   
                                    }
                                %>                               
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- M O D A L S    S T A R T    H E R E --%>

    <!-- Add Question Modal -->
    <div class="modal fade" id="addQuestion" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
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
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/main.js"></script>
    <jsp:include page="authfooter.jsp" />