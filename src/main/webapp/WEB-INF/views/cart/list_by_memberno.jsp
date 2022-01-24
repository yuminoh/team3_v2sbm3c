<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 온라인 쇼핑몰</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script type="text/javascript">
  function delete_func(cartno) {  // GET -> POST 전송, 상품 삭제
    var frm = $('#frm_post');
    frm.attr('action', './delete.do');
    $('#cartno',  frm).val(cartno);
    
    frm.submit();
  }   

  function update_cnt(cartno) {  // 수량 변경
    var frm = $('#frm_post');
    frm.attr('action', './cart_update.do');
    $('#cartno',  frm).val(cartno);
    
    var new_cnt = $('#' + cartno + '_cnt').val();  // $('#1_cnt').val()로 변환됨.
    $('#cnt',  frm).val(new_cnt);

    // alert('cnt: ' + $('#cnt',  frm).val());
    // alert('cartno: ' + $('#cartno',  frm).val());
    // return;
    
    frm.submit();
    
  }
</script>

<style type="text/css">

    
</style>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
<%-- GET -> POST: 상품 삭제, 수량 변경용 폼 --%>
<form name='frm_post' id='frm_post' action='' method='post'>
  <input type='hidden' name='cartno' id='cartno'>
  <input type='hidden' name='cnt' id='cnt'>
  <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
</form>
 
<DIV class='title_line'>
  장바구니
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
  
    <c:if test="${cateno != null}">
      <A href="/product/list?sub_categoryno=${sub_categoryno}">쇼핑 계속하기</A>
      <span class='menu_divide' >│</span>    
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>

  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 40%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col> <%-- 수량 --%>
      <col style="width: 10%;"></col> <%-- 합계 --%>
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
      <c:choose>
        <c:when test="${list.size() > 0 }">
           <c:forEach var="cartVO" items="${list }">
            <c:set var="cartno" value="${cartVO.cartno }" />
            <c:set var="productno" value="${cartVO.productno }" />
            <c:set var="productname" value="${cartVO.productname }" />
            <c:set var="product_price" value="${cartVO.product_price }" />
            <c:set var="pdimage" value="${cartVO.pdimagefile1 }" />
            <c:set var="cnt" value="${cartVO.cnt }" />
            <tr> 
              <td style='vertical-align: middle; text-align: center;'>        
                <c:choose>
                  <c:when test="${pdimage.endsWith('jpg') || pdimage.endsWith('png') || pdimage.endsWith('gif')}">
                    <a href="/products/read.do?productno=${productno}"><IMG src="/products/storage/${pdimage }" style="width: 120px; height: 80px;"></a> 
                  </c:when>
                  <c:otherwise>
                    <a href="/products/read.do?productno=${productno}"><IMG src="/products/none1.jpg" style="width: 120px; height: 80px;"></a> 
                  </c:otherwise>
                </c:choose>
              </td>  
              <td style='vertical-align: middle;'>
                <a href="/products/read.do?productno=${productno}"><strong>${productname}</strong></a> 
              </td>            
              <td style='vertical-align: middle; text-align: center;'>
                <input type='number' id='${cartno }_cnt' min='1' max='100' step='1' value="${cnt }" 
                  style='width: 52px;'><br>
                <button type='button' onclick="update_cnt(${cartno})" class='btn' style='margin-top: 5px;'>변경</button>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <fmt:formatNumber value="${product_price }" pattern="#,###" />
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <A href="javascript: delete_func(${cartno })"><IMG style="width:30px; height:30px" src="/cart/images/delete3.png"></A>
              </td>
            </tr>
          </c:forEach>       
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="6" style="text-align: center; font-size: 1.3em;">장바구니에 상품이 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      
      
    </tbody>
  </table>
  
  <table class="table table-striped" style='margin-top: 50px; margin-bottom: 50px; width: 100%;'>
    <tbody>
      <tr>
        <td style='width: 50%;'>
        <!-- 
          <div class='cart_label'>상품 금액</div>
          <div class='cart_price'><fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
        -->
        </td>
        <td style='width: 50%;'>
          <div class='cart_label' style='font-size: 2.0em;'>전체 주문 금액</div>
          <div class='cart_price'  style='font-size: 2.0em; color: #FF0000;'><fmt:formatNumber value="${total }" pattern="#,###" /> 원</div>
          <form name='frm' id='frm' style='margin-top: 50px;' action="/order_pay/create.do" method='get'>            
            <button type='submit' id='btn_order' class='btn btn-info' style='font-size: 1.5em;'>주문하기</button>
          </form>
        <td>
      </tr>
    </tbody>
  </table>   
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>