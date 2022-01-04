<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="categoryno" value="${productsVO.categoryno }" />
<c:set var="sub_categoryno" value="${productsVO.sub_categoryno }" />
<c:set var="productname" value="${productsVO.productname }" />   
<c:set var="product_price" value="${productsVO.product_price }" />     
<c:set var="productno" value="${productsVO.productno }" />
<c:set var="product_Explanation" value="${productsVO.product_Explanation }" />
<c:set var="pdimagefile1" value="${productsVO.pdimagefile1 }" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 재고관리</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function(){
	  $('#panel_delete').on('click',cancel);
  });

  function cancel(){    
	    $('#panel_delete').css("display","none");
	}
  
  function delete_read_ajax(productno){     
      $('#panel_delete').css("display","");
      var params = "productno="+productno;
      $.ajax(
          {
              url:'/products/read_ajax',
              type: 'get',
              cache: false, // 응답 결과 임시 저장 취소
              async: true,  // true: 비동기 통신
              dataType: 'json', // 응답 형식: json, html, xml...
              data: params,
              success: function(rdata){
                  console.log('rdata'+rdata)
                  var productno = rdata.productno;
                  var productname = rdata.productname;
                  var sub_categoryno = rdata.sub_categoryno;
                  var frm_delete = $('#frm_delete');
                  $('#productno',frm_delete).val(productno);
                  $('#sub_categoryno',frm_delete).val(sub_categoryno);
                  $('#productno_output',frm_delete).html(productno);
                  $('#productname_output',frm_delete).html(productname);
              },error: function(request, status, error) { // callback 함수
                  console.log(error);
              }
          }
      );  //ajax END
   }  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../category/list" class='title_link'>${categoryname } </A> >
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${sub_categoryname }</A> >
  <A href="./list_by_cateno_search_paging.do?cateno=" class='title_link'>${productname }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create?sub_categoryno=${sub_categoryno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>   
    <span class='menu_divide' >│</span>
    <A href="./update?productno=${productno}">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file?productno=${productno}">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="javascript:delete_read_ajax(${productno })" title="삭제">삭제</A>  
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_cateno_search.do'>
      <input type='hidden' name='categoryno' value='${categoryno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
<DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display:none;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete'>
      <input type='hidden' name='productno' id='productno' '>
      <input type='hidden' name='sub_categoryno' id='sub_categoryno' '>
       <label>상품 번호</label>:<span id='productno_output'></span> 
      <label>상품 이름</label>:<span id='productname_output'></span> 
      
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='delete_cancel'  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
  
  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="pdimagefile1" value="${pdimagefile1.toLowerCase() }" />
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${pdimagefile1.endsWith('jpg') || pdimagefile1.endsWith('png') || pdimagefile1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <IMG src="/products/storage/${pdimagefile1 }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/contents/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 47%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 2.0em; font-weight: bold;">${product_Explanation}  </span></br>      
          <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${product_price}" pattern="#,###" /> 원</span><br>

          <span style="font-size: 1.0em;">수량</span><br>
          <form>
          <input type='number' name='ordercnt' value='1' required="required" 
                     min="1" max="99999" step="1" class="form-control" style='width: 30%;'><br>
          <button type='button' onclick="" class="btn btn-info">장바 구니</button>           
          <button type='button' onclick="" class="btn btn-info">바로 구매</button>
          <span id="span_animation"></span>
          </form>
        </DIV> 

        <DIV>${content }</DIV>
      </li>
      <li class="li_none">
        
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${pdimagefile1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/products/storage&filename=${pdimagefile1}&downname=${pdimagefile1}'>${pdimagefile1}</A>  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

