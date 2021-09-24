<<<<<<< HEAD
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

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
=======
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
>>>>>>> 62ca8c8 (Seperating Header & Footer.)
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
                        <form>

                            <div class="align-items-center my-4">
                                <h2 class="fw-bold mb-2 text-uppercase">Register</h2>
                            </div>

                            <!-- Email input -->
                            <div class="form-floating mb-4">
                                <input type="email" id="email" class="form-control form-control-lg"
                                    placeholder="Enter a valid email address" />
                                <label class="form-label" for="email">Email address</label>
                            </div>

                            <!-- Password input -->
                            <div class="form-floating mb-3">
                                <input type="password" id="password" class="form-control form-control-lg"
                                    placeholder="Enter password" />
                                <label class="form-label" for="password">Password</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" id="repassword" class="form-control form-control-lg"
                                    placeholder="Re-Enter password" />
                                <label class="form-label" for="repassword">Re-Type Password</label>
                            </div>

                            <div class="text-center text-lg-start mt-4 pt-2">
                                <button type="button" class="btn btn-primary btn-lg"
                                    style="padding-left: 2.5rem; padding-right: 2.5rem;">Register</button>
<<<<<<< HEAD
                                <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="login.html"
=======
                                <p class="small fw-bold mt-2 pt-1 mb-0">Already have an account? <a href="login.jsp"
>>>>>>> 62ca8c8 (Seperating Header & Footer.)
                                        class="link-danger">Login</a></p>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </section>
    </div>
<<<<<<< HEAD
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>

</html>
=======
    <jsp:include page="footer.jsp" />
>>>>>>> 62ca8c8 (Seperating Header & Footer.)
