<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<link rel="shortcut icon"
		href="https://www.megabox.co.kr/static/pc/images/favicon.ico">
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>MEET PLAY SHARE, 솔 시네마</title>
	
	<link rel="stylesheet" href="${cp}/resources/css/board.css" />

</head>
<body>
	<div id="back-container">
        <div id="main-container">
            <div id="left-nav-bar">
                <span style="display: flex; justify-content: center; padding: 30px 20px; border-radius: 10px 10px 0 0; background-color: #8b0bd6; letter-spacing: 1px; font-weight: 500;">고객센터</span>
                <nav id="left-nav-column">
                    <ul>
                        <li class="left-nav select">
                            <a href="home">고객센터 홈</a>
                        </li>
                        <li class="left-nav">
                            <a href="${cp}/notice/list?page=1">공지사항</a>
                        </li>
                        <li class="left-nav">
                            <a href="${cp}/inquiry/list?page=1">내 문의 내역</a>
                        </li>
                        <li class="left-nav">
                            <a href="${cp}/inquiry/write?page=1">1:1 문의</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <div id="content-container">
                <h2 style="border-bottom: 1px solid #cacaca; padding-bottom: 0.5em; margin-bottom: 0.5em;">고객센터 홈</h2>
                <div id="service-container">
                    <div class="home-content">
                        <a href="${cp}/inquiry/write?page=1" class="block">
                            <h2 class="service">1:1 문의</h2>
                            <span>1:1 문의로 문의주세요</span>
                        </a>
                    </div>
                    <div class="home-content">
                        <a href="${cp}/notice/list?page=1" class="block">
                            <h2 class="service">공지사항</h2>
                            <span>솔시네마의 공지사항 이예요</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>