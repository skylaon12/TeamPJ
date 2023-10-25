<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERROR</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Noto+Sans+KR:wght@100;200;300;400;500;600;700&display=swap');

    body {
        font-family: Noto Sans KR, sans-serif;
        font-weight: 400;
        margin: 0;
        padding: 0;
    }

    #center-div {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        min-width: 100vh;
    }

    #error-area {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 500px;
        height: 350px;
        border: 1px solid gainsboro;
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
    }

    #error-img {
        background: url('https://i.ibb.co/ky8vgdC/error.png') no-repeat center;
        background-size: 100%;
        width: 100px;
        height: 100px;
        
    }
</style>
<body>
    <div id="center-div">
        <div id="error-area">
            <div id="error-img"></div>
            <div style="font-size: 22px; color: red; margin-top: 10px;">잘못된 접근 입니다!</div>
            <div style="width: 70%; margin: 10px; border: 1px solid #565656; border-radius: 1px;"></div>
            <span>잘못된 경로로 접근했거나</span>
            <span>접근 권한이 없습니다.</span>
            <a href="${cp}"><span>메인 페이지로 이동</span></a>
        </div>
    </div>
</body>
</html>