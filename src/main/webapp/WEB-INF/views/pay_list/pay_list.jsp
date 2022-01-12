<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 재고관리</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
$(function (){	
	 $('#panel_delete').on('click',cancel);
});

function cancel(){	
	$('#title').html("주문내역"); 
	$('#panel_delete').css("display","none");
}
 
function delete_login_check(categoryno){
    if("${sessionScope.id }"!= ''){
        if("${sessionScope.grade}"<=10){
        	delete_read_ajax(categoryno);
              }
           else{
                alert("관리자만이 사용 가능한 서비스입니다.")
               }
        }else{
            alert("로그인을 하셔야 가능한 서비스입니다.");
        }
}
 
 function delete_read_ajax(categoryno){	
	$('#panel_delete').css("display","");
	$('#title').html("주문내역 > 삭제");
	var params = "categoryno =";
	$.ajax(
		{
			url:'/category/read_ajax',
			type: 'get',
			cache: false, // 응답 결과 임시 저장 취소
		    async: true,  // true: 비동기 통신
		    dataType: 'json', // 응답 형식: json, html, xml...
		    data: params,
		    success: function(rdata){
		    	console.log('rdata'+rdata)
		    	var categoryno = rdata.categoryno;
		    	var categoryname = rdata.categoryname;
		    	
		    	var frm_delete = $('#frm_delete');
		    	$('#categoryno',frm_delete).val(categoryno);
		    	$('#categoryno_output',frm_delete).html(categoryno);
		    	$('#categoryname_output',frm_delete).html(categoryname);
		    },error: function(request, status, error) { // callback 함수
	            console.log(error);
	        }
		}
	);
 }
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line' id = 'title'>주문내역</DIV>

<DIV class='content_body'>    
    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 15%;'/>
      <col style='width: 15%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs"></TH>
      <TH class="th_bs">주문날짜</TH>
      <TH class="th_bs">제품명</TH>
      <TH class="th_bs">제품 가격</TH>
      <TH class="th_bs">구매 수량</TH>
    </TR>
    </thead>   
    <tbody>
    <c:forEach var="pay_list" items="${pay_list}">      
      <c:set var="rdate" value="${pay_list.rdate }" />
      <c:set var="productname" value="${pay_list.productname }" />
      <c:set var="product_price" value="${pay_list.product_price }" />
      <c:set var="cnt" value="${pay_list.cnt }" />
      <c:set var="rank" value="${pay_list.rank }" />
      <TR>
      <TD class="rank">${rank }</TD> 
      <TD class="td_bs">${rdate }</TD> 
        <TD class="td_bs">${productname }</TD>           
        <TD class="td_bs">${product_price }</TD>   
        <TD class="td_bs">${cnt }</TD> 
        <TD class="td_bs">          
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
<DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>