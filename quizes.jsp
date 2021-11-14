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
                                    <th class="cell100 column1">Sr. No</th>
                                    <th class="cell100 column2">Topic</th>
                                    <th class="cell100 column3">Created At</th>
                                    <th class="cell100 column4">View</th>
                                    <th class="cell100 column5">Delete</th>
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
                                    <td class="cell100 column1"><%=(i+1)%></td>
                                    <td class="cell100 column2"><%=quiz.getTopic()%></td>
                                    <td class="cell100 column3"><%=date + "    " + time%></td>
                                    <td class="cell100 column4"><a class="view-quiz" href="quiz.jsp?id=<%=quiz.getId()%>"><i class="fas fa-eye"></i></a></td>
                                    <td class="cell100 column5"><a class="delete-quiz" href="DeleteQuizController?id=<%=quiz.getId()%>&email=<%=user.getEmail()%>"><i class="fas fa-trash"></i></a></td>
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
    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/main.js"></script>
    <jsp:include page="authfooter.jsp" />