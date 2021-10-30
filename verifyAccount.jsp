<%@page import="models.User"%>
<%@page import="models.OTP"%>
<%@page import="utils.OtpUtils"%>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    OTP otp = OtpUtils.generate();
    user.setOtp(otp);
    session.setAttribute("user", user);
    OtpUtils.send(user.getEmail(), otp);
    String userMail = user.getEmail();


    String otpErrorMessage = (String) session.getAttribute("otpErrorMessage");
    String startMail = userMail.substring(0,2);
    String endMail = userMail.substring((userMail.indexOf("@")-3),userMail.indexOf("@"));
%>
<jsp:include page="authheader.jsp" />
<style>
    .h-custom {
        height: calc(100% - 73px);
    }

    .height-100 {
        height: 100vh
    }

    .card {
        width: 400px;
        border: none;
        height: 300px;
        display: flex;
        justify-content: center;
        align-items: center
    }

    .card h6 {
        color: #6F1667;
        font-size: 20px
    }

    .inputs input {
        width: 40px;
        height: 40px
    }

    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0
    }

    .form-control:focus {
        box-shadow: none;
        border: 2px solid #6F1667
    }

    .content a {
        color: #D64F4F;
        transition: all 0.5s
    }

    .content a:hover {
        color: #6F1667
    }

    @media (max-width: 450px) {
        .h-custom {
            height: 100%;
        }
    }
</style>
<title>Quiz App</title>
</head>
<body>
    <div>
        <section class="vh-100">
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-md-9 col-lg-6 col-xl-5">
                        <img src="https://image.freepik.com/free-vector/two-factor-authentication-concept-illustration_114360-5488.jpg"
                            class="img-fluid" alt="Sample image">
                    </div>
                    <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                        <%
                            if(otpErrorMessage != null) {
                        %>
                            <div class="alert alert-info"><%=otpErrorMessage%></div>
                        <%
                           }
                        %>
                        <div class="container d-flex justify-content-center align-items-center">
                            <div class="position-relative">
                                <div class="card p-2 text-center">
                                    <h5>Please enter the one time password <br> </h5>
                                    <div> <span> sent to</span> <small><%= startMail + "*******" + endMail + "@gmail.com"%></small> </div>
                                    <form method="POST" action="VerifyAccount">
                                        <div id="otp" class="inputs d-flex flex-row justify-content-center mt-2">
                                            <input class="m-2 text-center form-control rounded" name="field1" type="text" id="input1"
                                                onkeyup="field(1)" maxlength="1" />
                                            <input class="m-2 text-center form-control rounded" name="field2" onkeyup="field(2)"
                                                type="text" id="input2" maxlength="1" />
                                            <input class="m-2 text-center form-control rounded" name="field3" onkeyup="field(3)"
                                                type="text" id="input3" maxlength="1" />
                                            <input class="m-2 text-center form-control rounded" name="field4" onkeyup="field(4)"
                                                type="text" id="input4" maxlength="1" />
                                            <input class="m-2 text-center form-control rounded" name="field5" onkeyup="field(5)"
                                                type="text" id="input5" maxlength="1" />
                                            <input class="m-2 text-center form-control rounded" name="field6" onkeyup="field(6)"
                                                type="text" id="input6" maxlength="1" />
                                        </div>
                                        <div class="mt-4"> <button type="submit" id="verifyBtn" class="btn btn-primary btn-lg"
                                                style="padding-left: 2.5rem; padding-right: 2.5rem;">Verify</button>
                                        </div>
                                        <hr class="bg-primary border-2 border-top">
                                        <div class="mt-3 content d-flex justify-content-center align-items-center">
                                            <div id="timerInfo">Your OTP is valid for another 120 seconds.</div>
                                        </div>  
                                    </form>
                                    <div class="mt-4">
                                        <a class="btn btn-danger btn-lg" href="/quizapp/Logout">Logout</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script>
         function field(box) {
            var currentBox = document.getElementById("input" + box);
            if (!currentBox.value == "") {
                let nextBox = document.getElementById("input" + (box + 1));
                nextBox.focus();
            } else if (currentBox.value == "") {
                let previousBox = document.getElementById("input" + (box - 1));
                previousBox.focus();
            }
        }


        const timerInfo = document.getElementById("timerInfo");
        const submitButton = document.getElementById("verifyBtn");
        let timer = 120;

        const timerObj = setInterval(() => {
            timer--;
            timerInfo.innerHTML = "Your OTP is valid for another "+ timer + " seconds.";

            if(timer == 0) {
                submitButton.disabled = true;
                timerInfo.innerHTML = "<a href=''>Resend</a> OTP";
                clearInterval(timerObj);
            }
        }, 1000);

    </script>
    <jsp:include page="authfooter.jsp" />