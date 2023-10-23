<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>

<head>
  <%@include file="../admin/common/meta.jsp" %>
    <title>SOL CINEMA_ADMIN</title>
</head>

<body class="hold-transition sidebar-mini layout-fixed ">
  <div class="wrapper">
  	<%@include file="../admin/common/navbar.jsp" %>
	<%@include file="../admin/common/sidebar.jsp" %>
    <!-- Main content -->
    <section class="content-wrapper">
     <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h1 class="m-0">예매현황</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="${cp}/admin/main">메인</a>/예매현황</li>
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
                    <th>번호</th>
                    <th>회원명</th>
                    <th>영화명</th>
                    <th>위치</th>
                    <th>상영시간</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="ticket" items="${tickets}">
                    <tr>
                      <td>${ticket.user_id}</td>
                      <td>${ticket.user_name}</td>
                      <td>${ticket.m_title}</td>
                      <td>${ticket.region_detail} ${ticket.theater_num} ${ticket.seat_num}</td>
                      <td>${ticket.reserv_date} | ${ticket.str_hour}시${ticket.str_min}분</td>
                      <td><a href="${cp}/admin/cancelTicket?id=${ticket.id}"><button name="delete-btn" type="button" class="btn btn-block btn-danger btn-sm">취소</button></a></td>
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
    $("#ticket-info-bar").addClass('active');
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
  })
</script>
</html>