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
<div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation" src="${cp}/resources/images/admin/loading-gif.gif" alt="AdminLTELogo" height="60" width="60">
  </div>
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
                <i class="fas fa-minus"></i></button>
              </div>
            </div>
            <div class="card-body">
              <form id="board-write-form" method="post">
              	<input type="hidden" name = "${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" id="writer" name="p_writer" value="${admin.account}">
                
	            <div class="form-group">
	              <label for="inputName">제목</label>
	              <input type="text" id="title" name="p_title" class="form-control">
	            </div>
	            <div class="form-group">
	              <label for="inputDescription">내용</label>
	              <textarea id="text" name="p_text" class="form-control" rows="4"></textarea>
	            </div>
				<div class="col-12">
		          <a href="${cp}/admin/main" class="btn btn-secondary">뒤로가기</a>
		          <input type="button" id="writeBtn" value="등록하기" class="btn btn-success float-right">
		        </div>
       		  </form>
            </div>

            <!-- /.card-body -->
          </div>
          <!-- /.card -->

        </div>
	  </div>
    </section>
  </div>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
<%@include file="../admin/common/footer.jsp" %>
</div>
<!-- ./wrapper -->
<%@include file="../admin/common/script.jsp" %>

<script>
	$(document).ready(function() {
		var caution = Swal.mixin({
		      toast: true,
		      position: 'top-end',
		      showConfirmButton: false,
		      timer: 3000
		    });
  		
		$("#writeBtn").click(function(){
			var title = $("#title").val();
		  	var text = $("#text").val();
		  	console.log("제목 : " + title);
		  	console.log("내용 : " + text);
		  	if(title == "" || text == ""){
		  		caution.fire({
		  			icon: 'warning',
		  			title: '제목 또는 내용이 공백입니다.'
		  			})
		  	}else{
		  		$("#board-write-form").attr("action","writeProc");
		  		$("#board-write-form").submit();
		  	}
		})
	});
</script>

</body>
</html>