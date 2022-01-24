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
$(function (){
	$('#create_cancel').on('click',cancel);
	 $('#update_cancel').on('click',cancel);
	 $('#panel_delete').on('click',cancel);
});

function cancel(){	
	$('#panel_create').css("display","none");
	$('#panel_update').css("display","none");
	$('#panel_delete').css("display","none");
}

	function delete_read_ajax(productno) {
		$('#panel_create').css("display", "none");
		$('#panel_update').css("display", "none");
		$('#panel_delete').css("display", "");
		$('#title').html("상품 > 삭제");	
		var params = 'productno=' + productno;
		$.ajax({
			url : '/products/delete_read_ajax',
			type : 'get',
			cache : false, // 응답 결과 임시 저장 취소
			async : true, // true: 비동기 통신
			dataType : 'json', // 응답 형식: json, html, xml...
			data : params,
			success : function(rdata) {
				console.log('rdata' + rdata)
				var categoryno = rdata.categoryno;
				var sub_categoryno = rdata.sub_categoryno;
				var sub_categoryname = rdata.sub_categoryname;
			 
				var frm_delete = $('#frm_delete');
				$('#categoryno', frm_delete).val(categoryno);
				$('#sub_categoryno', frm_delete).val(sub_categoryno);
				$('#sub_categoryno_output', frm_delete).html(sub_categoryno);
				$('#sub_categoryname_output', frm_delete).html(sub_categoryname);
			},
			error : function(request, status, error) { // callback 함수
				console.log(error);
			}
		});
	}
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line' id = 'title'>${categoryname}>${sub_categoryname} </DIV>
<DIV style = "float:right;"></DIV>
<DIV class='content_body'>
    <ASIDE class="aside_right">
    <c:choose>
        <c:when test="${sessionScope.grade<=10 }">
            <A class ="float:right; " href="/products/create?sub_categoryno=${sub_categoryno}" title="등록"><span class="glyphicon glyphicon-plus-sign"></span></A>
            <span class='menu_divide' >│</span>
        </c:when>       
    </c:choose>
    <A href="javascript:location.reload();">새로고침</A><br>
  </ASIDE> 

   <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display:none;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete'>
      <input type='hidden' name='sub_categoryno' id='sub_categoryno' '>
       <input type="hidden" id='url' name="url" value="${url} }">
       <label>서브 카테고리 번호</label>:<span id='sub_categoryno_output'></span> 
      <label>서브 카테고리 이름</label>:<span id='sub_categoryname_output'></span> 
      
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='delete_cancel'  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='GET' action='./list'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='hidden' name='sub_categoryno' id='sub_categoryno' value='${sub_categoryno }' >
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
           <input type='hidden' name='sub_categoryno' id='sub_categoryno' value='${sub_categoryno }' >
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list?sub_categoryno=${sub_categoryno}'">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
 <DIV>
        
        <HR class='menu_line'>
        <c:forEach var="products_list" items="${list}">   
        <c:set var="categoryno" value="${products_list.categoryno }" />   
        <c:set var="sub_categoryno" value="${products_list.sub_categoryno }" />
        <c:set var="productname" value="${products_list.productname }" />
        <c:set var="product_price" value="${products_list.product_price }" />
        <c:set var="productno" value="${products_list.productno }" />
        <c:set var="productimage" value="${products_list.pdimagefile1 }" />
           <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV class='prod_style'>
      <c:set var="productimage" value="${productimage.toLowerCase() }" />
        <c:choose>
          <c:when test="${productimage != null}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${productimage.endsWith('jpg') || productimage.endsWith('png') || productimage.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="/products/read?productno=${productno }">                          
                  <IMG src="/products/storage/${productimage}" style='width: 100%; height: 150px;'>
                </a><br>
                ${productname} <br><br>
                <fmt:formatNumber value="${product_price}" pattern="##,###원" />
               <%--  <del><fmt:formatNumber value="${price}" pattern="#,###" /></del>
                <span style="color: #FF0000; font-size: 1.0em;">${dc} %</span>
                <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong> --%>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="/menu/menu_list.do?restnum=${restnum }"></a><br>
                  </DIV>
                </DIV>
                             
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="/products/read?productno=${productno }">
              <img src='/products/none1.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>   
        </DIV>      
          </c:forEach> 
     </DIV>
</DIV>
<DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>