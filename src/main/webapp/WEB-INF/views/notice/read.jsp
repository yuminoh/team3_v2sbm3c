<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />        
<c:set var="rname" value="${noticeVO.rname }" />
<c:set var="file1" value="${noticeVO.file1 }" />
<c:set var="file1saved" value="${noticeVO.file1saved }" />
<c:set var="thumb1" value="${noticeVO.thumb1 }" />
<c:set var="content" value="${noticeVO.content }" />
<c:set var="recom" value="${noticeVO.recom }" />
<c:set var="word" value="${noticeVO.word }" />
<c:set var="size1_label" value="${noticeVO.size1_label }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>편의점 온라인 쇼핑몰</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   
<script type="text/javascript">
$(function(){
    $('#btn_recom').on("click", function() { update_recom_ajax(${noticeno}); });

});

function update_recom_ajax(noticeno) {
   // console.log('-> noticeno:' + noticeno);
  var params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'noticeno=' + noticeno; // 공백이 값으로 있으면 안됨.
  $.ajax(
    {
      url: '/notice/update_recom_ajax.do',
      type: 'post',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우
        // console.log('-> rdata: '+ rdata);
        var str = '';
        if (rdata.cnt == 1) {
          // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
          // console.log('-> btn_recom: ' + $('#btn_recom').html());
          $('#btn_recom').html('좋아요('+rdata.recom+')');
          $('#span_animation').hide();
        } else {
          $('#span_animation').html("지금은 추천을 할 수 없습니다.");
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    }
  );  //  $.ajax END

  // $('#span_animation').css('text-align', 'center');
  $('#span_animation').html("<img src='/notice/images/ani03.gif' style='width: 20%;'>");
  $('#span_animation').show(); // 숨겨진 태그의 출력
}

</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../notice/list.do" class='title_link'>공지사항</A> > 
  <A href="../notice/list.do?noticeno=${noticeVO.noticeno }" class='title_link'>${noticeVO.title }</A> 
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
  <c:choose>
    <c:when test="${sessionScope.grade <10}"><!--  로그인한 사람이 관리자일 경우 -->
    <A href="./create.do?noticeno=${noticeVO.noticeno }">등록</A>
    <A href="./update_text.do?noticeno=${noticeno}">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file.do?noticeno=${noticeno}">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="./delete.do?noticeno=${noticeno}">삭제</A>│  
    </c:when> 
</c:choose>
    <span class='menu_divide' ></span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' ></span>

  </ASIDE> 
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1saved" value="${file1saved.toLowerCase() }" />
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/notice/storage/ --%>
                <IMG src="/notice/storage/${file1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/notice/images/none2.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 50%; height: 70px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
          <span style="font-size: 1em; font-weight: bold;">작성자: ${rname }</span><br>
           <form>
          <button type='button' id="btn_recom" class="btn btn-info">좋아요(${recom })</button>
          <span id="span_animation"></span>
          </form>
        </DIV> 

        <DIV>${content }</DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/notice/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

