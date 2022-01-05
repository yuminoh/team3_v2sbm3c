<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 재고 관리</title>
<%-- /static/css/style.css --%> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.code == 'passwd_fail'}">
          <LI class='li_none'>
            <span class="span_fail">패스워드가 일치하지 않습니다.</span>
          </LI> 
        </c:when>
        <c:when test="${param.code == 'product_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">상품 정보를 등록했습니다.</span>
          </LI>                   
          <LI class='li_none'>                                                   
            <button type='button' 
                         onclick="location.href='./product_update.do?cateno=${param.cateno}&categrpno=${param.categrpno }&contentsno=${param.contentsno }'"
                         class="btn btn-primary">관련 상품 정보 재등록</button>
          </LI>
        </c:when>
        <c:when test="${param.code == 'product_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">상품 정보 등록에 실패했습니다.</span>
          </LI>                                                                      
        </c:when>

        <c:when test="${param.code == 'create_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">${param.mname }님(${param.id }) 회원 가입을 축하합니다.</span>
          </LI>  
          <LI class='li_none'>
            <button type='button' 
                         onclick="location.href='./login.do?id=${param.id}'"
                         class="btn btn-primary">로그인</button>
          </LI> 
        </c:when>
        
        <c:when test="${param.code == 'create_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">회원 가입에 실패했습니다. 다시 시도해주세요.</span>
          </LI>                                                                      
        </c:when>

        <c:when test="${param.code == 'update_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">${param.mname }님(${param.id }) 회원 정보를 변경했습니다.</span>
          </LI>
          <LI class='li_none'>
            <button type='button' 
                         onclick="location.href='/'"
                         class="btn btn-primary">확인</button>
          </LI>                                                                       
        </c:when>
                
        <c:when test="${param.code == 'update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">${param.mname }님(${param.id }) 회원 정보 수정에 실패했습니다.</span>
          </LI>                                                                      
        </c:when>
        
        <c:when test="${param.code == 'delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">${param.mname }님(${param.id }) 회원 정보 삭제에 성공했습니다.</span>
          </LI>   
          <LI class='li_none'>
            <button type='button' 
                         onclick="location.href='/member/list.do'"
                         class="btn btn-primary">회원 목록</button>
          </LI>                                                                     
        </c:when>    
            
        <c:when test="${code == 'delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">${param.mname }님(${param.id }) 회원 정보 삭제에 실패했습니다.</span>
          </LI>                                                                      
        </c:when> 
        
        <c:when test="${param.code == 'passwd_update_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">${param.mname }님(${param.id }) 패스워드를 변경했습니다.</span>
          </LI>   
          <LI class='li_none'>
            <button type='button' 
                         onclick="location.href='/'"
                         class="btn btn-primary">확인</button>
          </LI>                                                                     
        </c:when>   
        
        <c:when test="${code == 'passwd_update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">${param.mname }님(${param.id }) 패스워드 변경에 실패했습니다.</span>
          </LI>                                                                      
        </c:when>  
        
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
        
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:choose>
            <c:when test="${param.cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>    
            </c:when>
        </c:choose>
        
        <%-- <a href="./list_by_cateno.do?cateno=${param.cateno}" class="btn btn-primary">목록</a> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search_paging.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>

      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>

