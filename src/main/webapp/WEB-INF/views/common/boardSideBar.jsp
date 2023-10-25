<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="left-nav-bar">
                <span style="display: flex; justify-content: center; padding: 30px 20px; border-radius: 10px 10px 0 0; background-color: #8b0bd6; letter-spacing: 1px; font-weight: 500;">고객센터</span>
                <nav id="left-nav-column">
                    <ul>
                        <li id="home-bar" class="left-nav">
                            <a href="${cp}/inquiry/home">고객센터 홈</a>
                        </li>
                        <li id="notice-bar" class="left-nav select">
                            <a href="${cp}/notice/list?page=${writeCurrentPage}">공지사항</a>
                        </li>
                        <security:authorize access="hasRole('USER')">
                        <li id="my-inquiry-bar" class="left-nav">
                            <a href="${cp}/inquiry/list?page=1">내 문의 내역</a>
                        </li>
                        <li id="write-inquiry-bar" class="left-nav">
                            <a href="${cp}/inquiry/write?page=1">1:1 문의</a>
                        </li>
                        </security:authorize>
                    </ul>
                </nav>
            </div>