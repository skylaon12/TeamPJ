<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<%@include file="../admin/common/meta.jsp" %>
<title>SOL CINEMA_ADMIN</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed dark-mode">

<div class="wrapper">
	<%@include file="../admin/common/navbar.jsp" %>
	<%@include file="../admin/common/sidebar.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">SOL CINEMA</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="${cp}/admin/main">메인</a></li>
              <li class="breadcrumb-item active">공지사항 등록</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <!-- Main content -->
    <section class="content">
      <div class="row">
        <div class="col-md-10">
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">공지사항</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body">
              <div class="form-group">
                 <label for="inputName">제목</label>
                 <h5>${board.p_title}</h5>
              </div>
              <div class="form-group">
		        <label for="inputDescription">내용</label>
		        <h3>${board.p_text}</h3>
		      </div>
			<div class="col-12">
		      <a href="${cp}/admin/main" class="btn btn-secondary">뒤로가기</a>
		      <a href="modify?id=${board.p_id}"><input type="button" value="수정하기" class="btn btn-success float-right"></a>
		      <a href="${cp}/admin/boardDel?id=${board.p_id}"><input type="button" value="삭제하기" class="btn btn-danger float-right"></a>
		    </div>
            </div>

            <!-- /.card-body -->
          </div>
          <!-- /.card -->

        </div>
	  </div>
    </section>
  </div>
</div>
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
<%@include file="../admin/common/footer.jsp" %>
<!-- ./wrapper -->
<%@include file="../admin/common/script.jsp" %>

<script>
	$(document).ready(function() {
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

</body>
</html>