<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 온라인 쇼핑몰</title>
 
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

   <DIV class='title_line'>
    내정보
  </DIV>
  <DIV class='menu_line'></DIV>
<div class="my-page-container">

  <ul>
  <li>아이디 </li>
  <li>${sessionScope.id}</li>
  </ul>
  
  <ul>
  <li>회원 이름 </li>
  <li>${sessionScope.mname}</li>
  </ul>
  
  <ul>
  <li>회원 등급 </li>
     <li><c:choose>
      <c:when test="${grade >= 1 and grade <= 10}">관리자 영역</c:when>    
      <c:when test="${grade >= 11 and grade <= 20}">회원 영역</c:when>
      <c:when test="${grade >= 30 and grade <= 39}">정지 회원 영역</c:when>
      <c:when test="${grade >= 40 and grade <= 49}">탈퇴 회원 영역</c:when>
      <c:when test="${grade == 99}">비회원 영역 처리</c:when>
    </c:choose></li>  
  </ul>
  
  <ul>
  <li>가입일</li> 
  <li>${sessionScope.mdate}</li>
  </ul>
  
  <ul>
  <li>전화번호 </li> 
  <li>${sessionScope.tel}</li>
  </ul>
  
  <%-- 등급(1 ~ 10: 관리자 / 11~20: 회원 / 30~39: 정지 회원 / 40~49: 탈퇴 회원 / 99: 비회원) --%>
  <ul>  
  <c:set var="grade" value="${sessionScope.grade}" />
  <li>로그인 등급</li>
  <li>${grade }</li>
  </ul>
  
  
  <ul class='slim'>
  <c:if test="${sessionScope.id ne null }">
    <li>로그인된 사용자 메뉴 출력 영역(특정 권한별 구분)</li>
  
    <li><c:choose>
      <c:when test="${grade >= 1 and grade <= 10}">관리자 영역</c:when>    
      <c:when test="${grade >= 11 and grade <= 20}">회원 영역</c:when>
      <c:when test="${grade >= 30 and grade <= 39}">정지 회원 영역</c:when>
      <c:when test="${grade >= 40 and grade <= 49}">탈퇴 회원 영역</c:when>
      <c:when test="${grade == 99}">비회원 영역 처리</c:when>
    </c:choose>  
    
    <c:choose>
      <c:when test="${grade <= 20}"> + 관리자 + 회원 영역</c:when>    
      <c:when test="${grade >= 30}"> + 비회원(정지, 탈퇴) 영역 처리</c:when>
    </c:choose></li>  
  </c:if>
 </ul>
 </DIV>
       <DIV class='bottom_menu'>
       <button type='button' onclick="location.href='/pay_list'" class='btn btn-info'>구매내역 조회</button>
       <button type='button' onclick="location.href='./passwd_update.do?memberno=${memberno}'" class='btn btn-info'>비밀번호 변경</button>
       <button type='button' onclick="location.href='./read.do?memberno=${memberno}'" class="btn btn-warning">회원정보 수정</button>
       <button type='button' onclick="location.href='./delete.do?memberno=${memberno}'" class="btn btn-danger">회원탈퇴</button>
      </DIV>
      <div>
      회원님의 관심 품목
      </div>
      <br>
     <c:choose>
        <c:when test="${list_count != null}">
            <c:forEach var="list" items="${intereted_list}">      
                <c:set var="sub_categoryno" value="${list.sub_categoryno }" />
                <c:set var="sub_categoryname" value="${list.sub_categoryname }" />
                <c:set var="categoryno" value="${list.categoryno }" />
             
                <DIV style="width:100px; height:100px; text-align: center; float:left;">
                     <A href="/products/list?sub_categoryno=${sub_categoryno }">${sub_categoryname }</A>
                </DIV>
            </c:forEach>
        </c:when>    
      </c:choose>
<DIV class='menu_line'></DIV>
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>


