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
              <h1 class="m-0">Q&A목록</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
              	<li class="breadcrumb-item"><a href="${cp}/admin/QnACompleList"><button type="button" class="btn btn-block btn-outline-primary btn-sm">완료된 Q&A</button></a></li>
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
          <div class="card-header">
            <form id="searchForm" method="get">
			  <ul class="nav nav-pills ml-auto p-2">
			    <c:choose>
			      <c:when test="${empty param.p_category or param.p_category eq '전체'}">
			      	<li class="nav-item"><a class="nav-link active" href="QnAList">전체</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=결제/환불">결제/환불</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=영화관">영화관</a></li>
			      </c:when>
				  <c:when test="${param.p_category eq '결제/환불'}">
			      	<li class="nav-item"><a class="nav-link" href="QnAList">전체</a></li>
	            	<li class="nav-item"><a class="nav-link active" href="QnAList?p_category=결제/환불">결제/환불</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=영화관">영화관</a></li>				  
				  </c:when>
				  <c:when test="${param.p_category eq '영화관'}">
			      	<li class="nav-item"><a class="nav-link" href="QnAList">전체</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=결제/환불">결제/환불</a></li>
	            	<li class="nav-item"><a class="nav-link active" href="QnAList?p_category=영화관">영화관</a></li>
				  </c:when>
				  <c:otherwise>
			      	<li class="nav-item"><a class="nav-link" href="QnAList">전체</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=결제/환불">결제/환불</a></li>
	            	<li class="nav-item"><a class="nav-link" href="QnAList?p_category=영화관">영화관</a></li>				  
				  </c:otherwise>			      
			    </c:choose>
	            <li class="nav-item dropdown">
	            <input type="hidden" id="page" name ="page" value="${currentPage }">
			  	<input type="hidden" id="p_category" name ="p_category" value="${p_category }">
	 		  	<select id="searchKey" name="searchKey" class="form-control custom-select">
		          <option value="p_writer">작성자</option>
		          <option value="p_title">제목</option>
	            </select>
	            </li>
	            <li>
	              <div class="card-tools">
	              <div class="input-group input-group-sm" style="width: 150px;">
	                <input type="text" id="word" name="word" class="form-control float-right" placeholder="Search">
	                  <div class="input-group-append">
	                    <button type="button" id="searchBtn" class="btn btn-lg btn-default">
                            <i class="fa fa-search"></i>
						  </button>
<!-- 	                  	<i class="fa-brands fa-golang"><input type="button" id="searchBtn" class="btn btn-default"></i> -->
	                  </div>
	                </div>
	              </div>
	            </li>
              </ul>        	 
		    </form>
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
                      <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 0px;">${dto.p_writer}</td>
					  <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100px;">${dto.p_title}</td>
                      <td>${dto.p_created}</td>
                      <td><a href="${articleUrl}${dto.p_id}&page=${currentPage }"><button name="info-btn" type="button" class="btn btn-block btn-info btn-sm">문의 확인</button></a></td>
                      <td><a href="completQnAProc?id=${dto.p_id}&page=${currentPage}&p_category=${p_category}&searchKey=${searchKey}&word=${word}"><button name="info-btn" type="button" class="btn btn-block btn-success btn-sm">문의 완료</button></a></td>
                      <td><a href="delQnAProc?id=${dto.p_id}&page=${currentPage}&p_category=${p_category}&searchKey=${searchKey}&word=${word}"><button name="delete-btn" type="button" class="btn btn-block btn-danger btn-sm">문의 삭제</button></a></td>
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
			  		  	<li class="page-item"><a class="page-link" href="${pageUrl}?page=${prevPage}&p_category=${p_category}">«</a></li>
			  		  </c:when>
			  		</c:choose>
			  
			  		<c:forEach var="p" begin="${blockStartNo}" end="${blockEndNo}">
			  		  <c:choose>
			  			<c:when test="${word != null}">
			  			  <li class="page-item"><a class="page-link" href="${pageUrl}?page=${p}&p_category=${p_category}&searchKey=${searchKey}&word=${word}">${p}</a></li>
			  			</c:when>
			  			<c:otherwise>
			  			  <li class="page-item"><a class="page-link" href="${pageUrl}?page=${p}&p_category=${p_category}">${p}</a></li>
			  			</c:otherwise>
			  		  </c:choose>
			  		</c:forEach>
			  		
			  		
			  		<c:choose>
			  		  <c:when test="${hasNext}">
			  		    <li class="page-item"><a class="page-link" href="${pageUrl}?page=${nextPage}&p_category=${p_category}">»</a></li>
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
    $("[name='info-btn']").css("width", "50%");
    $("[name='delete-btn']").css("width", "50%");
    
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
  
  
    
	$("#searchBtn").click(function(){
// 		var f = $("#searchForm");
		var curPage = $("#page").val();
		var curCategory = $("#p_category").val();
		
		var sKey = $("#searchKey option:selected").val();
		var sWord = $("#word").val();
		var url = "";
			if (curCategory == null || curCategory === '') {
				url = "QnAList?page="+ curPage +"&searchKey="+ sKey +"&word="+ sWord;
			} else {
				url = "QnAList?page="+ curPage +"&p_category="+ curCategory +"&searchKey="+ sKey +"&word="+ sWord;
			}
			$("#searchForm").attr("action",url)
			$("#searchForm").submit();
	});
		
</script>
</html>