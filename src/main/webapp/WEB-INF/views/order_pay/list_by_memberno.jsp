<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 
 
<script type="text/javascript">
  $(function(){
 
  });
</script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
  <DIV class='title_line'>
    ${sessionScope.id }님 주문결재 내역
  </DIV>

  <DIV class='content_body' style='width: 100%;'>

    <ASIDE class="aside_right">
      <A href="javascript:location.reload();">새로고침</A>
    </ASIDE> 
   
    <div class='menu_line'></div>
   
   
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 7%;'/>
      <col style='width: 15%;'/>
      <col style='width: 30%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 13%;'/>
      <col style='width: 5%;'/>
    </colgroup>
    <TR>
      <TH class='th_bs'>주문<br>번호</TH>
      <TH class='th_bs'>회원<br>번호</TH>
      <TH class='th_bs'>수취인<br>성명</TH>
      <TH class='th_bs'>수취인<br>전화번호</TH>
      <TH class='th_bs'>수취인<br>주소</TH>
      <TH class='th_bs'>결재 타입</TH>
      <TH class='th_bs'>결재 금액</TH>
      <TH class='th_bs'>주문일</TH>
      <TH class='th_bs'>조회</TH>
    </TR>
   
    <c:forEach var="order_payVO" items="${list }">
      <c:set var="payno" value ="${order_payVO.payno}" />
      <c:set var="memberno" value ="${order_payVO.memberno}" />
      <c:set var="rc_name" value ="${order_payVO.rc_name}" />
      <c:set var="rc_tel" value ="${order_payVO.rc_tel}" />
      <c:set var="rc_address" value ="(${order_payVO.rc_zipcode}) ${order_payVO.rc_address1} ${order_payVO.rc_address2}" />
      <c:set var="paytype" value ="${order_payVO.paytype}" />
      <c:set var="amount_pay" value ="${order_payVO.amount_pay}" />
      <c:set var="rdate" value ="${order_payVO.rdate}" />
         
       
    <TR>
      <TD class=td_basic>${payno}</TD>
      <TD class=td_basic><A href="/member/read.do?memberno=${memberno}">${memberno}</A></TD>
      <TD class='td_basic'>${rc_name}</TD>
      <TD class='td_left'>${rc_tel}</TD>
      <TD class='td_basic'>${rc_address}</TD>
      <TD class='td_basic'>
        <c:choose>
          <c:when test="${paytype == 1}">신용 카드</c:when>
          <c:when test="${paytype == 2}">모바일</c:when>
          <c:when test="${paytype == 3}">포이트</c:when>
          <c:when test="${paytype == 4}">계좌 이체</c:when>
          <c:when test="${paytype == 5}">직접 입금</c:when>
        </c:choose>
      </TD>
      <TD class='td_basic'><fmt:formatNumber value="${amount_pay }" pattern="#,###" /></TD>
      <TD class='td_basic'>${rdate.substring(1,16) }</TD>
      <TD class='td_basic'>
        <A href="/order_item/list_by_memberno.do?order_payno=${order_payno}"><img src="/images/bu6.png" title="주문 내역 상세 조회"></A>
      </TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.reload();" class="btn btn-primary">새로 고침</button>
  </DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
 