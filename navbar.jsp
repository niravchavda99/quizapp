    <!-- ========================= header start ========================= -->
    <% String url = request.getRequestURI(); %>
    
    <header class="header">
        <div class="navbar-area">
          <div class="container">
            <div class="row align-items-center">
              <div class="col-lg-12">
                <nav class="navbar navbar-expand-lg">
                  <a class="navbar-brand" href="dashboard.jsp">
                    <img src="assets/img/main_logo.jpg" alt="Logo" />
                  </a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="toggler-icon"></span>
                    <span class="toggler-icon"></span>
                    <span class="toggler-icon"></span>
                  </button>
  
                  <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                    <ul id="nav" class="navbar-nav ms-auto">
                      <li class="nav-item">
                        <a class='btn <%= url.contains("dashboard.jsp")?"active":""%>' href="dashboard.jsp">Home</a>
                      </li>
                      <li class="nav-item">
                        <a class='btn <%= url.contains("dashboard.jsp")?"":"active"%>' href="quizes.jsp">Your Quizes</a>
                      </li>
                      <li class="nav-item">
                        <div class="dropdown">
                          <a class="btn dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                            <%= user.getName() %>
                          </a>
                        
                          <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <li class="nav-item"> 
                              <a class="btn" href="#">
                                <i class="fas fa-user"></i> Profile
                              </a>
                            </li>
                            <li class="nav-item"> 
                              <a class="btn" href="Logout">
                                <i class="fas fa-sign-out-alt"></i> Logout
                              </a>
                            </li>
                          </ul>
                        </div>
                      </li>
                    </ul>
                  </div>
                  <!-- navbar collapse -->
                </nav>
                <!-- navbar -->
              </div>
            </div>
            <!-- row -->
          </div>
          <!-- container -->
        </div>
        <!-- navbar area -->
      </header>
      <!-- ========================= header end ========================= -->