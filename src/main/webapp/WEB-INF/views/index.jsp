<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 온라인 쇼핑몰</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <script type="text/javascript">
 $(function (){
	 recommend_check();
 });
 
 function recommend_check(){
	 if(${count}>0){
		 $('#recommend_products').css("display","");
	 }else{
		 $('#recommend_products').css("display","none");
	 }
 }
 </script>
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
</head>
<body>
<jsp:include page="./menu/top.jsp" flush='false' />
  <DIV id='recommend_products'  style='display:none;'>
    <h3>오늘의 신규상품</h3>
    <c:choose>
        <c:when test="${count >0}"> <!-- 추천 상품이 존재하면 -->
           <c:forEach var="products_list" items="${list}">               
            <c:set var="sub_categoryno" value="${products_list.sub_categoryno }" />
            <c:set var="productname" value="${products_list.productname }" />
            <c:set var="product_price" value="${products_list.product_price }" />
            <c:set var="productno" value="${products_list.productno }" />
            <c:set var="productimage" value="${products_list.pdimagefile1 }" />
            <DIV class='prod_style'>
            <a href="/products/read?productno=${productno }">                          
                  <IMG src="/products/storage/${productimage}" style='width: 100%; height: 150px;'>
                </a><br>
                ${productname} <br><br>
            <fmt:formatNumber value="${product_price}" pattern="##,###원" /></DIV>
            </c:forEach>            
        </c:when>        
    </c:choose>            
  </DIV>
  <DIV style='width: 100%; margin: 30px auto; text-align: center;'>
    <%-- /static/images/store.png --%>
    <IMG src='/images/store.png' style='width: 50%;'>
  </DIV>
  
  <DIV style='margin: 0px auto; width: 90%;'>
    <DIV style='float: left; width: 50%;'>
     </DIV>
     <DIV style='float: left; width: 50%;'>
    </DIV>  
  </DIV>
 
  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  
 
<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>

