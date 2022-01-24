<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<DIV class='container_main'> 
  <%-- 화면 상단 메뉴 --%>
  <DIV class='top_img'>

  <script type="text/javascript">
  function chatting(){
      var url = 'http://127.0.0.1:8000/chatbot/chatting/';
      var win = window.open(url, '챗봇', 'width=700px, height=630px');

      var x = (screen.width - 700) / 2;
      var y = (screen.height - 630) / 2;

      win.moveTo(x, y); // 화면 중앙으로 이동
    }
</script>

  <div class="top_menu_label">
  <a href="/"><img src="/images/logo.png" alt="">편의점 쇼핑몰</a>
<ul>
    <li><a class="menu_link" href="/">힐링 편의점</a></li>
    <li><A class='menu_link'  href='/member/create.do'>회원가입</A></li>
    <li><A class='menu_link'  href='/member/my_info.do'>마이 페이지</A></li>
     <c:choose>
        <c:when test="${sessionScope.id != null}"> <%-- 로그인 한 경우 --%> 
            <li><A class='menu_link'  href='/cart/list_by_memberno'>장바구니</A><span class='top_menu_sep'></span></li> 
            <li><A class='menu_link'  href='/order_pay/list_by_memberno.do?memberno=${sessionScope.memberno }'>주문결재 내역</A><span class='top_menu_sep'> </span>       
            <li><A class='menu_link'>${sessionScope.id }님</A></li><li><A class='menu_link'  href='/member/logout.do' >Logout</A></li>          
        </c:when>
        <c:otherwise><%-- 로그인 안한 경우 --%>
          <li><A class='menu_link'  href='/member/login.do' >Login</A></li>
        </c:otherwise>
      </c:choose>    
</ul>
    </DIV>   
       
    <div class='top_menu'>
      <ul>    
      <span style='padding-left: 0.5%;'></span>
      <li><A class='menu_link'  href='/category/list'>카테고리</A><span class='top_menu_sep'> </span></li>   
      <li><a class="menu_link" href="/notice/list.do">공지사항</a><span class="top_menu_sep"></span></li>     
      <li><a class="menu_link" href="/post/list.do">상품 문의 게시판</a><span class="top_menu_sep"></span></li>      
      <li><a class="menu_link" href="/">메뉴2</a><span class="top_menu_sep"></span></li>      
      <li><a class="menu_link" href="/">메뉴3</a><span class="top_menu_sep"></span></li>        
      <li><a class="menu_link" href="javascript: chatting()">챗봇</a><span class="top_menu_sep"></span></li>
      <c:choose>
        <c:when test="${sessionScope.id != null}"> <%-- 로그인 한 경우 --%>                         
            <c:choose>
                <c:when test="${sessionScope.grade <10}"><!--  로그인한 사람이 관리자일 경우 -->
                    <A class='menu_link'  href='/subcategory/list'>서브 카테고리 전체 목록</A><span class='top_menu_sep'> </span>                         
                    <A class='menu_link'  href='/member/list.do'>회원목록</A><span class='top_menu_sep'> </span>
                    <A class='menu_link'  href='/stock/list.do'>재고</A><span class='top_menu_sep'> </span>
                </c:when> 
            </c:choose>
        </c:when>                             
            <c:otherwise>
                <A class='menu_link'  href='/member/login.do' >로그인</A><span class='top_menu_sep'> </span>
                <A class='menu_link'  href='/member/create.do'>회원가입</A><span class='top_menu_sep'> </span>                    
            </c:otherwise>      
       </c:choose>          
      <c:choose>
            <c:when test="${sessionScope.grade <10}"><!--  로그인한 사람이 관리자일 경우 -->
            <li><A class='menu_link'  href='/subcategory/list'>서브 카테고리 전체 목록</A><span class='top_menu_sep'></span></li>                         
            <li><A class='menu_link'  href='/member/list.do'>회원목록</A><span class='top_menu_sep'></span></li>
            <li><A class='menu_link'  href='/stock/list.do'>재고</A><span class='top_menu_sep'> </span></li>
            </c:when> 
      </c:choose>         
      </ul>    
                       
  </DIV> 

     
    </div>
    
  </DIV>
  <%-- 내용 --%> 
  <DIV class='content'>
   