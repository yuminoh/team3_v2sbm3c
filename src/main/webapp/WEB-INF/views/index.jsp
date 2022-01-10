<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 재고관리</title>
<!-- /static 기준 -->
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <script type="text/javascript">
 </script>
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
</head>
<body>
<jsp:include page="./menu/top.jsp" flush='false' />
  <%-- <DIV id='category-all-layer' class='category-all-layer'>
    <div style="width:100px;float:left;">
      <ul>
        <c:forEach var="categoryVO" items="${category_list}" varStatus="status"> 
        <c:set var="categoryno" value="${categoryVO.categoryno }" />
        <c:set var="categoryname" value="${categoryVO.categoryname }" />
        <li id ="category_${status.count}"  style="list-style:none;"><A >${categoryname}</A> </li>
       </c:forEach>      
      </ul>
    </div>
    <div style="border: solid 1px #333333;float: left;">
      <ul>
        
      </ul>
    </div>
      
  </DIV> --%>
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

