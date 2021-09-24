<jsp:include page="header.jsp" />
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

                            <!-- Name input -->
                            <div class="form-floating mb-4">
                                <input type="text" required id="name" class="form-control form-control-lg"
                                    placeholder="Enter your full name" name="name" />
                                <label class="form-label" for="name">Full Name</label>
                            </div>

                            <!-- Email input -->
                            <div class="form-floating mb-4">
                                <input type="email" id="email" class="form-control form-control-lg"
                                    placeholder="Enter a valid email address" name="email" />
                                <label class="form-label" for="email">Email address</label>
                            </div>

                            <!-- Password input -->
                            <div class="form-floating mb-3">
                                <input type="password" id="password" class="form-control form-control-lg"
                                    placeholder="Enter password" name="password" />
                                <label class="form-label" for="password">Password</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" id="repassword" class="form-control form-control-lg"
                                    placeholder="Re-Enter password" name="repassword" />
                                <label class="form-label" for="repassword">Re-Type Password</label>
                            </div>

                            <div class="text-center text-lg-start mt-4 pt-2">
                                <button type="submit" class="btn btn-primary btn-lg"
                                    style="padding-left: 2.5rem; padding-right: 2.5rem;">Register</button>
                                <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="login.jsp"
                                        class="link-danger">Login</a></p>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <jsp:include page="footer.jsp" />