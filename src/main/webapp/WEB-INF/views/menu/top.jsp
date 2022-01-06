<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>
    <DIV class='top_menu_label'>편의점 재고관리 시스템</DIV>
    <NAV class='top_menu'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='/' >메인 페이지</A><span class='top_menu_sep'> </span>
      
      <c:choose>
        <c:when test="${sessionScope.id != null}"> <%-- 로그인 한 경우 --%>
           ${sessionScope.id } <A class='menu_link'  href='/member/logout.do' >로그아웃</A><span class='top_menu_sep'> </span>
        </c:when>
        <c:otherwise>
          <A class='menu_link'  href='/member/login.do' >로그인</A><span class='top_menu_sep'> </span>
          <A class='menu_link'  href='/member/create.do'>회원가입</A><span class='top_menu_sep'> </span>
        </c:otherwise>
      </c:choose>    
      
      <A class='menu_link'  href='/member/my_info.do'>마이 페이지</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/category/list'>카테고리</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/subcategory/list'>서브 카테고리 전체 목록</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/cate/list_all.do'>카테고리 전체 목록</A><span class='top_menu_sep'> </span>           
      <A class='menu_link'  href='/cart/list_by_memberno.do'>장바구니</A><span class='top_menu_sep'> </span>
      <A class='menu_link'  href='/order_pay/list_by_memberno.do'>주문결재</A><span class='top_menu_sep'> </span> 
      <A class='menu_link'  href='/member/list.do'>회원목록</A><span class='top_menu_sep'> </span>
       
    </NAV>
  </DIV>
  
  <%-- 내용 --%> 
  <DIV class='content'>
  
  