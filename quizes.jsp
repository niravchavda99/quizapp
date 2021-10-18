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

    .delete-quiz {
        color: red;
    }

    .delete-quiz:hover {
        color: #b50000;
    }

    .view-quiz {
        color: #0099ff;
    }

    .view-quiz, .delete-quiz {
        font-size: 20px;
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
    crossorigin="anonymous"></script>

    <%@page import="models.Quiz"%>
    <%@page import="utils.Database"%>
    <%@page import="java.util.List"%>
    <%@page import="java.sql.Timestamp"%>

    <div class="container">

    <%
        List<Quiz> quizes = Database.fetchQuizes(user.getEmail());
    %>
            <h1 class="display-1" style="text-align: center; color: white; margin-top: -10px;">Your Quizes</h1>
    <%
        if(quizes.isEmpty()) {
    %>
        <div class="alert alert-info">You haven't created any quiz yet!</div>
    <%
            return;
        }
    %>
    <table class="table table-hover table-dark table-striped">
        <tr>
            <th>Sr. No</th>
            <th>Topic</th>
            <th>Created At</th>
            <th class="text-center">View</th>
            <th class="text-center">Delete</th>
        </tr>
    <%
        for(int i = 0; i < quizes.size(); i++) {
            Quiz quiz = quizes.get(i);
            Timestamp timestamp = quiz.getTimestamp();
            String date = String.format("%d-%d-%d", timestamp.getDate(), timestamp.getMonth() + 1, timestamp.getYear() + 1900);
            String time = String.format("%d:%d:%d", timestamp.getHours(), timestamp.getMinutes(), timestamp.getSeconds());
    %>
        <tr>
            <td><%=(i+1)%></td>
            <td><%=quiz.getTopic()%></td>
            <td><%=date + "    " + time%></td>
            <td class="text-center"><a class="view-quiz" href="quiz.jsp?id=<%=quiz.getId()%>"><i class="fas fa-eye"></i></a></td>
            <%-- <td><a class="btn btn-primary" href="quiz.jsp?id=<%=quiz.getId()%>"><i class="far fa-eye"></i>&nbsp;View</a></td> --%>
            <td class="text-center"><a class="delete-quiz" href="DeleteQuiz?id=<%=quiz.getId()%>"><i class="fas fa-trash"></i></a></td>
            <%-- <td><a class="btn btn-danger"><i class="fas fa-trash"></i>&nbsp;Delete</a></td> --%>
        </tr>
    <%
        }
    %>
    </table>
    </div>
</body>
</html>