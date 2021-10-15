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
<title>Quiz App</title>
</head>

<body>
<%@page import="models.User"%>
    <%
        User user = (User) session.getAttribute("user");
        if(user != null) {
          if(!user.getIsVerified()) {
            response.sendRedirect("verifyAccount.jsp");
            return;
          }
            response.sendRedirect("dashboard.jsp");
            return;
        }
    %>
  <div>
    <section class="vh-100">
      <div class="container-fluid h-custom">
        <div class="row d-flex justify-content-center align-items-center h-100">
          <div class="col-md-9 col-lg-6 col-xl-5">
            <img src="https://mdbootstrap.com/img/Photos/new-templates/bootstrap-login-form/draw2.svg" class="img-fluid"
              alt="Sample image">
          </div>
          <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
            <form method="POST" action="LoginController">

              <div class="align-items-center my-4">
                <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
              </div>
              
              <%
              String errorMessage = (String) request.getAttribute("errorMessage");
              if(errorMessage != null) {
                out.println("<div class='text-center text-lg-start mt-4 pt-2' id='errorMessage'>");
                out.println("<div class='alert alert-danger' role'alert'>");
                
                out.println(errorMessage);
                
                out.println("</div>");
                out.println("</div>");
              }
              %>

              <!-- Email input -->
              <div class="form-floating mb-4">
                <input type="email" id="email" class="form-control form-control-lg"
                  placeholder="Enter a valid email address" required name="email" />
                <label class="form-label" for="email">Email address</label>
              </div>

              <!-- Password input -->
              <div class="form-floating mb-3">
                <input type="password" id="password" class="form-control form-control-lg"
                  placeholder="Enter password" name="password" required />
                <label class="form-label" for="password">Password</label>
              </div>

              <div class="d-flex justify-content-between align-items-center">
                <!-- Checkbox -->
                <div class="form-check mb-0">
                  <input class="form-check-input me-2" type="checkbox" value="" id="rememberCheck" />
                  <label class="form-check-label" for="rememberCheck">
                    Remember me
                  </label>
                </div>
                <a href="#!" class="text-body">Forgot password?</a>
              </div>

              <div class="text-center text-lg-start mt-4 pt-2">
                <button type="submit" class="btn btn-primary btn-lg"
                  style="padding-left: 2.5rem; padding-right: 2.5rem;">Login</button>
                <p class="small fw-bold mt-2 pt-1 mb-0">Don't have an account? <a href="register.jsp"
                    class="link-danger">Register</a></p>
              </div>

            </form>
          </div>
        </div>
      </div>
    </section>
  </div>
  <jsp:include page="authfooter.jsp" />