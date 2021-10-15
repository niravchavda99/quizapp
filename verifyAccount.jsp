<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<%@page import="models.User"%>
<%@page import="models.OTP"%>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
%>
    <div class="container">
        <div class="alert alert-info">Please Login to continue...</div>
        <a class="btn btn-info" href="login.jsp">Login</a>
    </div>
<%
        return;
    }

    out.println(user.getOtp().getValue());
    String otpErrorMessage = (String) session.getAttribute("otpErrorMessage");
    String numberEnding = user.getPhone().substring(user.getPhone().length() - 3);
%>

<div class="container" style="text-align: center;">
    <h1>Please Verify Your Account To Continue!</h1>
    <br />
    <br />
    <%
        if(otpErrorMessage != null) {
    %>
        <div class="alert alert-info"><%=otpErrorMessage%></div>
    <%
        }
    %>
    <h3>A passcode has been sent to your number XXXXXXX<%=numberEnding%></h3>
    <br />
    <form method="POST" action="VerifyAccount">
        <input type="text" class="form-control" name="verifyOtp" id="verifyOtp" style="font-size: 30px; width: 200px; margin: 0 auto; border: 1px solid black;" placeholder="OTP">
        <br />
        <input type="submit" value="Verify" id="verifyBtn" class="btn btn-primary btn-lg">
    </form>
</div>