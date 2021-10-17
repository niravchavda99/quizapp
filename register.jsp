<jsp:include page="authheader.jsp" />
<style>
    .h-custom {
        height: calc(100% - 73px);
    }
    @media (max-width: 450px) {
        .h-custom {
            height: 100%;
        }
    }
</style>
</head>

<body>
<%@page import="models.User"%>
    <%
        User user = (User) session.getAttribute("user");
        if(user != null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }
    %>
    <div>
        <section class="vh-100">
            <div class="container-fluid h-custom">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-md-9 col-lg-6 col-xl-5">
                        <img src="https://mdbootstrap.com/img/Photos/new-templates/bootstrap-login-form/draw2.png"
                            class="img-fluid" alt="Sample image">
                    </div>
                    <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
                        <form method="POST" action="RegistrationController">
                            <div class="align-items-center my-4">
                                <h2 class="fw-bold mb-2 text-uppercase">Register</h2>
                            </div>

                            <%
                            String errorMessage = (String) request.getAttribute("errorMessage");
                            if(errorMessage != null) {
                                out.println("<div class='text-center text-lg-start mt-4 pt-2' id='errorMessage'>");
                                out.println("<div class='alert alert-danger' role='alert'>");
                                
                                out.println(errorMessage);
                                
                                out.println("</div>");
                                out.println("</div>");
                            }
                            %>

                            <div class="text-center text-lg-start mt-4 pt-2" style="display: none;" id="errorMessage">
                                <div class="alert alert-danger" role="alert">
                                    Passwords do not match!
                                </div>
                            </div>

                            <!-- Name input -->
                            <div class="form-floating mb-4">
                                <input type="text" required id="name" class="form-control form-control-lg"
                                    placeholder="Enter your full name" name="name" required />
                                <label class="form-label" for="name">Full Name</label>
                            </div>

                            <!-- Email input -->
                            <div class="form-floating mb-4">
                                <input type="email" id="email" class="form-control form-control-lg"
                                    placeholder="Enter a valid email address" required name="email" />
                                <label class="form-label" for="email">Email address</label>
                            </div>

                            <!-- Phone number input -->
                            <div class="form-floating mb-4">
                                <input type="text" id="phone" class="form-control form-control-lg"
                                    placeholder="Enter a valid phone number" required name="phone" />
                                <label class="form-label" for="phone">Phone Number</label>
                            </div>

                            <!-- Password input -->
                            <div class="form-floating mb-3">
                                <input type="password" id="password" class="form-control form-control-lg"
                                    placeholder="Enter password" name="password" required oninput="checkPassword()" />
                                <label class="form-label" for="password">Password</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" id="repassword" class="form-control form-control-lg"
                                    placeholder="Re-Enter password" name="repassword" oninput="checkPassword()" required />
                                <label class="form-label" for="repassword">Re-Type Password</label>
                            </div>

                            <div class="text-center text-lg-start mt-4 pt-2">
                                <button type="submit" class="btn btn-primary btn-lg"
                                    style="padding-left: 2.5rem; padding-right: 2.5rem; display: none;" id="submitBtn">Register</button>
                                <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="login.jsp"
                                        class="link-danger">Login</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <script>
        const pass = document.getElementById("password");
        const repass = document.getElementById("repassword");
        // const phone = document.getElementById("phone");
        // const name = document.getElementById("name");
        // const email = document.getElementById("email");
        const submitButton = document.getElementById("submitBtn");
        const errorMessage = document.getElementById("errorMessage");

        const toggleSubmitButton = value => submitBtn.style.display = (value ? "block" : "none");
        const toggleErrorMessage = value => errorMessage.style.display = (value ? "block" : "none");

        function checkPassword() {
            if(pass.value != "" && repass.value != null && pass.value === repass.value) {
                toggleSubmitButton(true);
                toggleErrorMessage(false);
                return true;
            }

            toggleSubmitButton(false);
            toggleErrorMessage(true);
            return false;
        }
    </script>
    <jsp:include page="authfooter.jsp" />