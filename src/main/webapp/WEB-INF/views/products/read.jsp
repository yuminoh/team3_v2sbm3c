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
  $(function() {
      $('#btn_login').on('click', login_ajax);
      $('#btn_loadDefault').on('click', loadDefault);
  });
  
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
  
  function loadDefault() {
	    $('#id').val('user1');
	    $('#passwd').val('1234');
  }

  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // params += '&${ _csrf.parameterName }=${ _csrf.token }';
    console.log(params);
    // return;
    
    $.ajax(
      {
        url: '/member/login_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
          
          if (rdata.cnt == 1) {
            // 쇼핑카트에 insert 처리 Ajax 호출
            $('#div_login').hide();
            alert('로그인 성공');
            $('#login_yn').val('YES');
            cart_ajax_post();
            
          } else {
            alert('로그인에 실패했습니다.<br>잠시후 다시 시도해주세요.');
            
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END
  }

  <%-- 쇼핑 카트에 상품 추가 --%>
  function cart_ajax(productno) {
    var f = $('#frm_login');
    $('#productno', f).val(productno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
 
    console.log('-> productno: ' + $('#productno', f).val()); 
    
    if ('${sessionScope.id}' != '' || $('#login_yn').val() == 'YES') {  // 로그인이 되어 있다면
        cart_ajax_post();
             
    } else {  // 로그인 안한 경우
    	$('#div_login').show();   // 쇼핑카트에 insert 처리 Ajax 호출 
    }

  }

  <%-- 쇼핑카트 상품 등록 --%>
  function cart_ajax_post() {
    var f = $('#frm_login');
    var productno = $('#productno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    var params = "";
    
    params += 'productno=' + productno;
    params += '&${ _csrf.parameterName }=${ _csrf.token }';
    
    console.log('-> cart_ajax_post: ' + params);
    // return;
    
    $.ajax(
      {
        url: '/cart/create.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
          
          if (rdata.cnt == 1) {
            var sw = confirm('선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?');
            
            if (sw == true) {
              // 쇼핑카트로 이동
              location.href='/cart/list_by_memberno.do';
            }           
          } else {
            alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

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
  
  <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
    <FORM name='frm_login' id='frm_login' method='POST' action='/member/login_ajax.do' class="form-horizontal">
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type="hidden" name="productno" id="productno" value="productno">
      <input type="hidden" name="login_yn" id="login_yn" value="NO">
      
      <div class="form-group">
        <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
        <div class="col-md-8">
          <input type='text' class="form-control" name='id' id='id' 
                     value='${ck_id }' required="required" 
                     style='width: 30%;' placeholder="아이디" autofocus="autofocus">
          <Label>   
            <input type='checkbox' name='id_save' value='Y' 
                      ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>                   
        </div>
   
      </div>   
   
      <div class="form-group">
        <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
        <div class="col-md-8">
          <input type='password' class="form-control" name='passwd' id='passwd' 
                    value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
          <Label>
            <input type='checkbox' name='passwd_save' value='Y' 
                      ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>
        </div>
      </div>   
   
      <div class="form-group">
        <div class="col-md-offset-4 col-md-8">
          <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
          <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
          <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button>
          <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                      onclick="$('#div_login').hide();">취소</button>
        </div>
      </div>   
      
    </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
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
          <button type='button' onclick="cart_ajax(${productno })" class="btn btn-info">장바 구니</button>           
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

