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
              <h1 class="m-0">Q&A목록</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="${cp}/admin/main">메인</a>/Q&A</li>
              </ol>
            </div><!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
    <!-- /.content-header -->
      <!-- /.row -->
      <div class="row">
        <div class="col-12">
            <!-- /.card-header -->
            <div class="card-body table-responsive p-0">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>번호</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>작성일자</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="dto" items="${lists}">
                    <tr>
                      <td>${dto.p_id}</td>
                      <td>${dto.p_writer}</td>
                      <td>${dto.p_title}</td>
                      <td>${dto.p_created}</td>
                      <td><a href="${articleUrl}${dto.p_id}&page=${currentPage }"><button name="info-btn" type="button" class="btn btn-block btn-info btn-sm">문의 확인</button></a></td>
                      <td><button name="delete-btn" type="button" class="btn btn-block btn-danger btn-sm">문의 삭제</button></td>
                  </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
            <!-- /.card-body -->
			<!-- /.card-footer -->
            <div class="card-footer clearfix">
		      <ul class="pagination pagination-sm m-0" style="justify-content: center">
		      	<c:choose>
			  	  <c:when test="${totalCount != 0}">
			  		<c:choose>
			  		  <c:when test="${hasPrev}">
			  		  	<li class="page-item"><a class="page-link" href="${pageUrl}?page=${prevPage}">«</a></li>
			  		  </c:when>
			  		</c:choose>
			  
			  		<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
			  		  <c:choose>
			  			<c:when test="${word != null}">
			  			  <li class="page-item"><a class="page-link" href="${pageUrl}?page=${p}&searchKey=${searchKey}&word=${word}">${p}</a></li>
			  			</c:when>
			  			<c:otherwise>
			  			  <li class="page-item"><a class="page-link" href="${pageUrl}?page=${p}">${p}</a></li>
			  			</c:otherwise>
			  		  </c:choose>
			  		</c:forEach>
			  		
			  		
			  		<c:choose>
			  		  <c:when test="${hasNext}">
			  		    <li class="page-item"><a class="page-link" href="${pageUrl}?page=${nextPage}">»</a></li>
			  		  </c:when>
			  		</c:choose>
			   	  </c:when>
			  	<c:otherwise>
				  		등록된 게시물이 없습니다.
			  		  </c:otherwise>
			  		</c:choose> 
		      </ul>
		    </div>
		    <!-- /.card-footer -->
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
    $("#board-info-bar").addClass('active');
    $("[name='info-btn']").css("width", "40%");
    $("[name='delete-btn']").css("width", "40%");
  })
</script>
</html>