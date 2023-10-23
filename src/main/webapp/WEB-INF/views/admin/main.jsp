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
  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="${cp}/admin/main">메인</a></li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- Small boxes (Stat box) -->
        <div class="row">
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
              <div class="inner">
                <h3>${m_cnt}<sup style="font-size: 20px">명</sup></h3>

                <p>회원 수</p>
              </div>
              <div class="icon">
                <i class="ion ion-bag"></i>
              </div>
              <a href="${cp}/admin/memberList" class="small-box-footer">더보기</a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
              <div class="inner">
                <h3>${resv_cnt}<sup style="font-size: 20px">건</sup></h3>

                <p>예매 현황</p>
              </div>
              <div class="icon">
                <i class="ion ion-stats-bars"></i>
              </div>
              <a href="${cp}/admin/ticketList" class="small-box-footer">더보기</a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
              <div class="inner">
                <h3>${q_cnt}<sup style="font-size: 20px">건</sup></h3>

                <p>대기중인 QnA</p>
              </div>
              <div class="icon">
                <i class="ion ion-person-add"></i>
              </div>
              <a href="${cp}/admin/QnAList" class="small-box-footer">더보기</a>
            </div>
          </div>
          <!-- ./col -->
          <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
              <div class="inner">
                <h3>${revenue}<sup style="font-size: 20px">원</sup></h3>

                <p>이달의 매출액</p>
              </div>
              <div class="icon">
                <i class="ion ion-pie-graph"></i>
              </div>
            </div>
          </div>
          <!-- ./col -->
        </div>
        <!-- /.row -->
        <!-- Main row -->
        <div class="row">
          <!-- Left col -->
          <section class="col-lg-7 connectedSortable">
          <div class="card bg-gradient-primary">
            <div class="card-header border-0">
              <h3 class="card-title">
                  <i class="fas fa-map-marker-alt mr-1"></i>
                  공지사항
                </h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body table-responsive p-0" id="board-container">
              <table class="table table-hover text-nowrap">
                <thead>
                  <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>등록일자</th>
                    <th>조회수</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="dto" items="${board}">
                    <tr>
                      <td><a href="${cp}/admin/read?id=${dto.p_id}" style="color: inherit;text-decoration: none;">${dto.p_title}</a></td>
                      <td>${dto.p_writer}</td>
                      <td>${dto.p_created}</td>
                      <td>${dto.p_hitcount}</td>
                      <td><a href="${cp}/admin/boardDel?id=${dto.p_id}"><button name="delete-btn" type="button" class="btn btn-block btn-danger btn-sm">문의 삭제</button></a></td>
                  </tr>
                  </c:forEach>
                </tbody>
                <tfoot>
                	<tr>
                	  <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td>
                      <a href="${cp}/admin/write"><button type="button" class="btn btn-block bg-gradient-success btn-sm">등록</button></a>
                    </td>
                	</tr>
                </tfoot>
              </table>
            </div>
            <div class="btn-group">
    		  <button type="button" id="prevButton" class="btn btn-info">
        		이전
    		  </button>
    		  <button type="button" id="nextButton" class="btn btn-info">
        		다음
    		  </button>
			</div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </section>
          <!-- /.Left col -->
          <!-- right col (We are only adding the ID to make the widgets sortable)-->
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
	    var currentPage = ${currentPage};
	    var totalPage = ${totalPage};
	    
	    
	    // "다음" 버튼 클릭 시 AJAX 요청을 보내고 컨테이너 업데이트
	    $('#nextButton').click(function() {
	        if (currentPage < totalPage) {
	            $.get("getBoardData?page=" + (++currentPage), function(data) {
	                $("#board-container").html(data);
	            });
	            console.log("현재 페이지 : " + currentPage);
	        }else{
	        	caution.fire({
	        		icon: 'info',
	        		title: '마지막 페이지 입니다!'
	        	})
	        }
	    });

	    // "이전" 버튼에 대한 유사한 AJAX 요청 구현
	    $('#prevButton').click(function() {
	        if (currentPage > 1) {
	            $.get("getBoardData?page=" + (--currentPage), function(data) {
	                $("#board-container").html(data);
	            });
	            console.log("현재 페이지 : " + currentPage);
	        }else{
	        	caution.fire({
	        		icon: 'info',
	        		title: '첫 페이지 입니다!'
	        	})
	        }
	    });
	});

//   $(function() {
//     var Toast = Swal.mixin({
//       toast: true,
//       position: 'top-end',
//       showConfirmButton: false,
//       timer: 3000
//     });

//     $('.swalDefaultSuccess').click(function() {
//       Toast.fire({
//         icon: 'success',
//         title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
//       })
//     });
//     $('.swalDefaultInfo').click(function() {
//       Toast.fire({
//         icon: 'info',
//         title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
//       })
//     });
//     $('.swalDefaultError').click(function() {
//       Toast.fire({
//         icon: 'error',
//         title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
//       })
//     });
//     $('.swalDefaultWarning').click(function() {
//       Toast.fire({
//         icon: 'warning',
//         title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
//       })
//     });
//     $('.swalDefaultQuestion').click(function() {
//       Toast.fire({
//         icon: 'question',
//         title: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.'
//       })
//     });

//     $('.toastrDefaultSuccess').click(function() {
//       toastr.success('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
//     });
//     $('.toastrDefaultInfo').click(function() {
//       toastr.info('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
//     });
//     $('.toastrDefaultError').click(function() {
//       toastr.error('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
//     });
//     $('.toastrDefaultWarning').click(function() {
//       toastr.warning('Lorem ipsum dolor sit amet, consetetur sadipscing elitr.')
//     });
//   });
</script>

</body>
</html>