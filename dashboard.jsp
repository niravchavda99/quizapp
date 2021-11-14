<jsp:include page="authheader.jsp" />
    <link rel="stylesheet" href="assets/css/animate.css" />
    <link rel="stylesheet" href="assets/css/main.css" />
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
    
    <!-- ========================= preloader start ========================= -->
    <div class="preloader">
      <div class="loader">
        <div class="spinner">
          <div class="spinner-container">
            <div class="spinner-rotator">
              <div class="spinner-left">
                <div class="spinner-circle"></div>
              </div>
              <div class="spinner-right">
                <div class="spinner-circle"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
		<!-- ========================= preloader end ========================= -->
		

    <%@include file="navbar.jsp"%>

    <!-- ========================= hero-section start ========================= -->
    <section id="home" class="hero-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-6">
            <div class="hero-content">
              <span class="wow fadeInLeft" data-wow-delay=".2s">Welcome To Quiz</span>
              <h1 class="wow fadeInUp" data-wow-delay=".4s">
                Quiz your audience during presentations
              </h1>
              <p class="wow fadeInUp" data-wow-delay=".6s">
                Create interactive quizzes that are designed to be enjoyable and dynamic, no matter if you want to test your colleague's knowledge, run a fun quiz with your friends, or help students study. 
              </p>
              <button class="main-btn btn-hover wow fadeInUp" data-wow-delay=".6s" data-bs-toggle="modal" data-bs-target="#createQuizModal">Create</button>
              <button class="main-btn btn-hover wow fadeInUp" data-wow-delay=".6s" data-bs-toggle="modal" data-bs-target="#participateQuizModal">Participate</button>
            </div>
					</div>
					<div class="col-lg-6">
						<div class="hero-img wow fadeInUp" data-wow-delay=".5s">
							<img src="assets/img/main_page_image.png" alt="">
						</div>
					</div>
        </div>
			</div>
    </section>
		<!-- ========================= hero-section end ========================= -->


    <!-- ========================= Create Quiz Modal Start ========================= -->
    <div class="modal fade" id="createQuizModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="createQuizModalLabel" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="CreateQuizController" method="POST">
              <div class="modal-body">
                  <input type="text" class="form-control" placeholder="Quiz Topic" name="topic" id="topic" required />
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Create</button>
              </div>
          </form>
          </div>
        </div>
      </div>
      <!-- ========================= Create Quiz Modal End ========================= -->
  
      <!-- ========================= Participate Quiz Modal Start ========================= -->
      <div class="modal fade" id="participateQuizModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="participateQuizModalLabel" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form action="participation.jsp" method="POST">
              <div class="modal-body">
                  <input type="text" class="form-control" placeholder="Quiz ID" name="quizid" id="participatequizid" required />
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                  <button type="submit" class="btn btn-primary">Participate</button>
              </div>
          </form>
          </div>
        </div>
      </div>
    <!-- ========================= Participate Quiz Modal End ========================= -->

    <script src="assets/js/wow.min.js"></script>
    <script src="assets/js/main.js"></script>
    <jsp:include page="authfooter.jsp" />