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
    
<script type="text/javascript">
$(function (){	
	 $('#panel_delete').on('click',cancel);
});

function cancel(){	
	$('#title').html("주문내역"); 
	$('#panel_delete').css("display","none");
}
 
function recommend_login_check(memberno){
    if("${sessionScope.id }"!= ''){
    	$('#panel').html("<img src='/images/ani04.gif' style='width: 10%;'>"); // static
    	recommend_read_ajax(memberno);
        }else{
            alert("로그인을 하셔야 가능한 서비스입니다.");
        }
}
 
function recommend_read_ajax(memberno){    
    var params = "memberno="+memberno;
    $('#panel').css("display","");
    
    $.ajax(
        {
            url:'/pay_list/interested_products',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
            	if(rdata.code=="value_Suffice"){
            		var interested_product=rdata.interested_product;
                    var product_record=rdata.product_record;
                    recommend_ajax(interested_product,product_record);
            	}
            	else{
            		var html = "상품을 추천해 드리기엔 구매 기록이 충분하지 않습니다.";
            		$('#panel').html(html);   
            	}   
                $('#panel').show();
            },error: function(request, status, error) { // callback 함수
                console.log(error);
            }
        }
    );
 }
 
function recommend_ajax(interested_product, product_record){    
    var interested_product1=interested_product[0];      
    var interested_product2=interested_product[1];  
    var interested_product3=interested_product[2];  
    var product_record1=product_record[0];
    var product_record2=product_record[1];
    var product_record3=product_record[2];
    var product_record4=product_record[3];
    var product_record5=product_record[4];
    var params="interested_product1="+interested_product1;
    params += "&interested_product2="+interested_product2;
    params += "&interested_product3="+interested_product3;
    params += "&product_record1="+product_record1;
    params += "&product_record2="+product_record2;
    params += "&product_record3="+product_record3;
    params += "&product_record4="+product_record4;
    params += "&product_record5="+product_record5;
    $.ajax(
        {
            url:'http://127.0.0.1:8000/product/recommend',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
            	recommend_ouput(rdata.index);// 최종적으로 나온 추천 서브카테고리 번호
            },error: function(request, status, error) { // callback 함수
                console.log(error);
            }
        }
    );
 }
 
 function recommend_ouput(sub_categoryno){
	 var params = "sub_categoryno="+sub_categoryno;
	 console.log(params); 
	 $.ajax(
		        {
		            url:'/pay_list/recommend',
		            type: 'get',
		            cache: false, // 응답 결과 임시 저장 취소
		            async: true,  // true: 비동기 통신
		            dataType: 'json', // 응답 형식: json, html, xml...
		            data: params,
		            success: function(rdata){
		                  console.log(rdata.sub_categoryname); 
		                  var html = "당신의 추천 상품은 '"+rdata.sub_categoryname+"' 입니다.";
		                  html += "<br><br><button type='button' class='btn btn-info' onclick="
		                  html += '"location.href='
		                  html += "'/products/list?sub_categoryno="+rdata.sub_categoryno+"'"+'"'+">추천상품 보러가기</button>";
		                  console.log('html->'+html);
		                  $('#panel').html(html);		                                  
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
 
<DIV class='title_line' id = 'title'>구매내역</DIV>
<div style="float:right;"><button type='button' onclick="javascript:recommend_login_check(${sessionScope.memberno})" class='btn btn-info'>나의 추천상품</button></div>
<DIV class='content_body'>    
<DIV id='panel' style='display: none; float:center; margin: 10px auto; text-align: center; width: 60%;'>        
     <input type="hidden" id='sub_categoryno' name="sub_categoryno" >
     <input type="hidden" id='sub_categoryname' name="sub_categoryname" >
</DIV>
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