<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/table.css" />
    <link rel="stylesheet" href="assets/css/util.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css">
  </head>
  <body>
    <%@page import="models.User"%>
    <%
    
        User user = (User) session.getAttribute("user");
        
        if(user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    <%@include file="navbar.jsp"%>
    <%@page import="models.Quiz"%>
    <%@page import="utils.Database"%>
    <%@page import="java.util.List"%>
    <%@page import="java.sql.Timestamp"%>
    <%
        List<Quiz> quizes = Database.fetchQuizes(user.getEmail());
        if(quizes.isEmpty()) {
    %>
        <div class="alert alert-info">You haven't created any quiz yet!</div>
    <%
            return;
        }
    %>
    <div class="limiter mt-100">
        <h1 class="display-3" style="text-align: center; margin-top: -10px;">Your Quizes</h1>
        <div class="container-table100">
            <div class="wrap-table100">
                <div class="table100 ver1 m-b-110">
                    <div class="table100-head">
                        <table>
                            <thead>
                                <tr class="row100 head">
                                    <th class="cell100 column1 text-center">#</th>
                                    <th class="cell100 column2">Topic</th>
                                    <th class="cell100 column3">Created At</th>
                                    <th class="cell100 column4 text-center">View</th>
                                    <th class="cell100 column5 text-center">Delete</th>
                                </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="table100-body js-pscroll">
                        <table>
                            <tbody>
                                <%
                                for(int i = 0; i < quizes.size(); i++) {
                                    Quiz quiz = quizes.get(i);
                                    Timestamp timestamp = quiz.getTimestamp();
                                    String date = String.format("%d-%d-%d", timestamp.getDate(), timestamp.getMonth() + 1, timestamp.getYear() + 1900);
                                    String time = String.format("%d:%d:%d", timestamp.getHours(), timestamp.getMinutes(), timestamp.getSeconds());
                                %>
                                <tr class="row100 body">
                                    <td class="cell100 column1 text-center"><%=(i+1)%></td>
                                    <td class="cell100 column2"><%=quiz.getTopic()%></td>
                                    <td class="cell100 column3"><%=date + "    " + time%></td>
                                    <td class="cell100 column4 text-center"><a class="view-quiz" href="quiz.jsp?id=<%=quiz.getId()%>"><i class="fas fa-eye"></i></a></td>
                                    <td class="cell100 column5 text-center"><a class="delete-quiz" href="DeleteQuizController?id=<%=quiz.getId()%>&email=<%=user.getEmail()%>"><i class="fas fa-trash"></i></a></td>
                                </tr>
                                <%
                                  }
                                %>                               
                            </tbody>
                        </table>

                    </div>
                </div>
                
                <div class="container">
                    <h1 class="display-5 text-center">View Scores</h1>
                    <table class="table table-responsive table-hover">
                        <thead>
                            <tr>
                                <th scope="col"><strong>#</strong></th>
                                <th scope="col"><strong>Quiz</strong></th>
                                <th scope="col" class="text-center"><strong>Score</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<String> qzs = Database.fetchCompletedQuizes(user.getEmail());
                            for(int i = 0; i < qzs.size(); i++) {
                                out.println("<tr>");
                                out.println("<th scope='row'>" + (i + 1) + "</th>");
                                int index = qzs.get(i).indexOf(',');
                                String qid = qzs.get(i).substring(0, index);
                                String qtopic = qzs.get(i).substring(index + 1);
                                out.println("<td>" + qtopic + "</td>");
                                out.println("<td class='text-center'><a class='view-quiz' href='scores.jsp?id=" + qid + "'><i class='fas fa-eye'></i></a></td>");
                                out.println("</tr>");
                            }
                            %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/main.js"></script>
    <jsp:include page="authfooter.jsp" />