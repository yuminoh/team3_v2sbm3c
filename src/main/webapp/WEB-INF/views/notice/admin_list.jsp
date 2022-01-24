<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 온라인 쇼핑몰</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../notice/list.do" class='title_link'>공지사항 목록</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?noticeno=${noticeVO.noticeno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="noticeVO" items="${list }">
        <c:set var="noticeno" value="${noticeVO.noticeno }" />
        <c:set var="title" value="${noticeVO.title }" />
        <c:set var="content" value="${noticeVO.content }" />
        <c:set var="rname" value="${noticeVO.rname }" />
        <c:set var="rdate" value="${noticeVO.rdate.substring(0, 10) }" />
        <c:set var="word" value="${noticeVO.word }" />
        
        
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/notice/storage/ --%>
                <a href="./read.do?noticeno=${noticeno}&now_page=${param.now_page }"><IMG src="/notice/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/notice/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?noticeno=${noticeno}"><span style="color: #00ff00; font-size: 1.2em;">${noticeVO.title} </span> <br>
            ${noticeVO.content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <span style="color: #505050; font-size: 1em;">공지 등록일 : ${rdate} </span><br>
            <span style="color: #000000; font-size: 1em;">작성자 : ${noticeVO.rname} </span><br>
            <span style="color: #FF0000; font-size: 1.2em;">${noticeVO.word} </span>
          </td>
          <td style='vertical-align: middle; text-align: center;'>수정/삭제<br>공지 정보</td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>


