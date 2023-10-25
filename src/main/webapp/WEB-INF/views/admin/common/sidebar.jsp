<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${cp}/admin/main" class="brand-link">
      <img src="../resources/images/logo/logo-s.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">SOL CINEMA</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="../resources/images/admin/profile.png" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">${admin.account}</a>
        </div>
      </div>


      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="${cp}/admin/main" id="dash-bar" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
          </li>
          <li class="nav-item menu-open">
            <a href="#" id="info-bar" class="nav-link ">
              <i class="fa-solid fa-circle-info"></i>
              <p>
                정보관리
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
				<!-- a태그 id 내가 추가함 -->
                <a id="member-info-bar" href="${cp}/admin/memberList" class="nav-link">
                  <i class="fa-regular fa-user"></i>
                  <p>회원 관리</p>
                </a>
              </li>
              <li class="nav-item">
              	<!-- a태그 id 내가 추가함 -->
                <a id="ticket-info-bar" href="${cp}/admin/ticketList" class="nav-link">
                  <i class="fa-solid fa-ticket"></i>
                  <p>예매 관리</p>
                </a>
              </li>
              <li class="nav-item">
              	<!-- a태그 id 내가 추가함 -->
                <a id="board-info-bar" href="${cp}/admin/QnAList?page=1" class="nav-link">
                  <i class="fa-solid fa-q"></i>
                  <p>Q&A 관리</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="${cp}/" class="nav-link">
              <i class="fa-brands fa-golang"></i>
              <p>
                메인 페이지로 가기
              </p>
            </a>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
