<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
  <%@include file="../admin/common/meta.jsp" %>
    <title>SOL CINEMA_ADMIN</title>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
  <div class="wrapper">
  	<%@include file="../admin/common/navbar.jsp" %>
	<%@include file="../admin/common/sidebar.jsp" %>
	<div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation" src="${cp}/resources/images/admin/loading-gif.gif" alt="AdminLTELogo" height="60" width="60">
  </div>
    <!-- Main content -->
    <section class="content-wrapper">
     <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0">회원목록</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="${cp}/admin/main">메인</a>/회원관리</li>
              </ol>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
    <!-- /.content-header -->
      <!-- /.row -->
      <div class="row">
        <div class="col-12">
          <div class="card">
            <!-- /.card-header -->
            <div class="card-body table-responsive p-0">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>일련번호</th>
                    <th>아이디</th>
                    <th>비밀번호</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>연락처</th>
                    <th>나이</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="member" items="${members}">
                    <tr>
                      <td>${member.id}</td>
                      <td>${member.account}</td>
                      <td>*******</td>
                      <td>${member.name}</td>
                      <td>${member.email1}@${member.email2}</td>
                      <td>${member.phonenumber}</td>
                      <td>${member.age}</td>
                      <td><a href="userInfo?id=${member.id}"><button name="info-btn" type="button" class="btn btn-block btn-info btn-sm">회원 정보</button></a></td>
                      <td><a href="userDeleteProc?account=${member.account}&id=${member.id}"><button type="button" class="btn btn-block btn-danger btn-sm">회원삭제</button></a></td>
                  </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <%@include file="../admin/common/footer.jsp" %>
  <!-- ./wrapper -->

  <!-- ./wrapper -->
  <%@include file="../admin/common/script.jsp" %>

</body>
<script>
	$(document).ready(function(){
    $("#dash-bar").removeClass('active');
    $("#info-bar").addClass('active');
    $("#member-info-bar").addClass('active');
    var Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
      });
    <c:if test="${not empty msgType}">
        <c:choose>
            <c:when test="${msgType eq 'Success'}">
            	toastr.success("${msg}");
            </c:when>
            <c:when test="${msgType eq 'Fail'}">
            	toastr.error("${msg}");
            </c:when>
        </c:choose>
    </c:if>
  });
</script>
</html>