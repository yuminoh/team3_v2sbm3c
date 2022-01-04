<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="productno" value="${productVO.productno }" />
<c:set var="sub_categoryno" value="${productVO.sub_categoryno }" />
<c:set var="productname" value="${productVO.productname }" />
<c:set var="pdimagefile1" value="${productVO.pdimagefile1 }" />
 
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
  <A href="../categrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../cate/list_by_categrpno.do?categrpno=${categrpVO.categrpno }" class='title_link'>${categrpVO.name }</A> >
  <A href="./list_by_cateno_search_paging.do?cateno=${cateVO.cateno }" class='title_link'>${cateVO.name }</A>
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
      <input type='hidden' name='cateno' value='${cateVO.cateno }'>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_cateno_search.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
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
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style='text-align: center; width: 50%; float: left;'>
          <c:set var="file1saved" value="${contentsVO.file1saved.toLowerCase() }" />
          <c:set var="thumb1" value="${contentsVO.thumb1 }" />
          <c:choose>
            <c:when test="${pdimagefile1.endsWith('jpg') || pdimagefile1.endsWith('png') || pdimagefile1.endsWith('gif')}">
              <IMG src="/products/storage/${pdimagefile1 }" style='width: 90%;'> 
            </c:when>
            <c:otherwise> <!-- 이미지가 없음 -->
               <IMG src="/products/none1.png" style="width: 90%;"> 
            </c:otherwise>
          </c:choose>
          
        </DIV>

        <DIV style='text-align: left; width: 47%; float: left;'>
          <span style='font-size: 1.5em;'>${title}</span>
          <br>
          <FORM name='frm' method='POST' action='./update_file' 
              enctype="multipart/form-data">
            <input type="hidden" name="productno" value="${productno }">  
            <input type="hidden" name="sub_categoryno" value="${sub_categoryno }"> 
            <input type="hidden" name="productname" value="${productname }">                        
            <br><br> 
            변경 이미지 선택<br>  
            <input type='file' name='file1M1' id='file1M1' value='' placeholder="파일 선택"><br>            
            <br>
            <div style='margin-top: 20px; clear: both;'>  
              <button type="submit" class="btn btn-primary">파일 변경 처리</button>
              <button type="button" onclick="history.back();" class="btn btn-primary">취소</button>
            </div>  
          </FORM>
        </DIV>
      </li>
      <li class="li_none">

      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>


