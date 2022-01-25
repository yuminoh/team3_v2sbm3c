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
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
   
<script type="text/javascript">
$(function(){
    $('#btn_recom').on("click", function() { update_recom_ajax(${noticeno}); });


// ---------------------------------------- 댓글 관련 시작 ----------------------------------------
var frm_reply = $('#frm_reply');
$('#content', frm_reply).on('click', check_login);  // 댓글 작성시 로그인 여부 확인
$('#btn_create', frm_reply).on('click', reply_create);  // 댓글 작성시 로그인 여부 확인

list_by_noticeno_join(); // 댓글 목록
// ---------------------------------------- 댓글 관련 종료 ----------------------------------------
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

// 댓글 작성시 로그인 여부 확인
function check_login() {
  var frm_reply = $('#frm_reply');
  if ($('#memberno', frm_reply).val().length == 0 ) {
    $('#modal_title').html('댓글 등록'); // 제목 
    $('#modal_content').html("로그인해야 등록 할 수 있습니다."); // 내용
    $('#modal_panel').modal();            // 다이얼로그 출력
    return false;  // 실행 종료
  }
}

// 댓글 등록
function reply_create() {
  var frm_reply = $('#frm_reply');
  
  if (check_login() !=false) { // 로그인 한 경우만 처리
    var params = frm_reply.serialize(); // 직렬화: 키=값&키=값&...
    // alert(params);
    // return;

    // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
    // 오라클: 한글 1자가 3바이트임으로 300자로 제한
    // alert('내용 길이: ' + $('#content', frm_reply).val().length);
    // return;
    
    if ($('#content', frm_reply).val().length > 300) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
      $('#modal_panel').modal();           // 다이얼로그 출력
      return;  // 실행 종료
    }

    $.ajax({
      url: "../reply/create.do", // action 대상 주소
      type: "post",          // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = ""; // 메시지 출력
        var tag = ""; // 글목록 생성 태그
        
        if (rdata.cnt > 0) {
          $('#modal_content').attr('class', 'alert alert-success'); // CSS 변경
          msg = "댓글을 등록했습니다.";
          $('#content', frm_reply).val('');
          $('#passwd', frm_reply).val('');

          // list_by_contentsno_join(); // 댓글 목록을 새로 읽어옴
          
          $('#reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
          $("#reply_list").attr("data-replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
          
          // list_by_contentsno_join_add(); // 페이징 댓글, 페이징 문제 있음.
          // alert('댓글 목록 읽기 시작');
          // global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
          // global_rdata_cnt = 0; // 목록 출력 글수
          
           list_by_noticeno_join(); // 페이징 댓글
        } else {
          $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
          msg = "댓글 등록에 실패했습니다.";
        }
        
        $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html(msg);     // 내용
        $('#modal_panel').modal();           // 다이얼로그 출력
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });
  }
}

// noticeno 별 소속된 댓글 목록
function list_by_noticeno_join() {
  var params = 'noticeno=' + ${noticeVO.noticeno };

  $.ajax({
    url: "../reply/list_by_noticeno_join.do", // action 대상 주소
    type: "get",           // get, post
    cache: false,          // 브러우저의 캐시영역 사용안함.
    async: true,           // true: 비동기
    dataType: "json",   // 응답 형식: json, xml, html...
    data: params,        // 서버로 전달하는 데이터
    success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
      // alert(rdata);
      var msg = '';
      
      $('#reply_list').html(''); // 패널 초기화, val(''): 안됨
      
      for (i=0; i < rdata.list.length; i++) {
        var row = rdata.list[i];
        
        msg += "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
        msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
        msg += "  " + row.rdate;
        
        if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
          msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='/reply/images/delete3.png'></A>";
        }
        msg += "  " + "<br>";
        msg += row.content;
        msg += "</DIV>";
      }
      // alert(msg);
      $('#reply_list').append(msg);
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      console.log(error);
    }
  });
  
}

// 댓글 삭제 레이어 출력
function reply_delete(replyno) {
  // alert('replyno: ' + replyno);
  var frm_reply_delete = $('#frm_reply_delete');
  $('#replyno', frm_reply_delete).val(replyno); // 삭제할 댓글 번호 저장
  $('#modal_panel_delete').modal();             // 삭제폼 다이얼로그 출력
}

// 댓글 삭제 처리
function reply_delete_proc(replyno) {
  // alert('replyno: ' + replyno);
  var params = $('#frm_reply_delete').serialize();
  $.ajax({
    url: "../reply/delete.do", // action 대상 주소
    type: "post",           // get, post
    cache: false,          // 브러우저의 캐시영역 사용안함.
    async: true,           // true: 비동기
    dataType: "json",   // 응답 형식: json, xml, html...
    data: params,        // 서버로 전달하는 데이터
    success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
      // alert(rdata);
      var msg = "";
      
      if (rdata.passwd_cnt ==1) { // 패스워드 일치
        if (rdata.delete_cnt == 1) { // 삭제 성공

          $('#btn_frm_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 
          
          $('#' + replyno).remove(); // 태그 삭제
            
          return; // 함수 실행 종료
        } else {  // 삭제 실패
          msg = "패스 워드는 일치하나 댓글 삭제에 실패했습니다. <br>";
          msg += " 다시한번 시도해주세요."
        }
      } else { // 패스워드 일치하지 않음.
        // alert('패스워드 불일치');
        // return;
        
        msg = "패스워드가 일치하지 않습니다.";
        $('#modal_panel_delete_msg').html(msg);

        $('#passwd', '#frm_reply_delete').focus();  // frm_reply_delete 폼의 passwd 태그로 focus 설정
        
      }
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      console.log(error);
    }
  });
}
// -------------------- 댓글 관련 종료 --------------------
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

  <!-- Modal 알림창 시작 -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->
  
  <!-- -------------------- 댓글 삭제폼 시작 -------------------- -->
<div class="modal fade" id="modal_panel_delete" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
      </div>
      <div class="modal-body">
        <form name='frm_reply_delete' id='frm_reply_delete'>
          <input type='hidden' name='replyno' id='replyno' value=''>
          
          <label>패스워드</label>
          <input type='password' name='passwd' id='passwd' class='form-control'>
          <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
        </form>
      </div>
      <div class="modal-footer">
        <button type='button' class='btn btn-danger' 
                     onclick="reply_delete_proc(frm_reply_delete.replyno.value); frm_reply_delete.passwd.value='';">삭제</button>

        <button type="button" class="btn btn-default" data-dismiss="modal" 
                     id='btn_frm_reply_delete_close'>Close</button>
      </div>
    </div>
  </div>
</div>
<!-- -------------------- 댓글 삭제폼 종료 -------------------- -->
  
<DIV class='title_line'>
  <A href="../notice/list.do" class='title_link'>공지사항</A> > 
  <A href="../notice/read.do?noticeno=${noticeVO.noticeno }" class='title_link'>${noticeVO.title }</A> 
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
  <c:choose>
    <c:when test="${sessionScope.grade <10}"><!--  로그인한 사람이 관리자일 경우 -->
    <A href="./create.do?noticeno=${noticeVO.noticeno }">등록</A>
    <A href="./update_text.do?noticeno=${noticeno}">수정</A>
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
 
   <!-- ------------------------------ 댓글 영역 시작 ------------------------------ -->
  <DIV style='width: 80%; margin: 0px auto;'>
      <HR>
      <FORM name='frm_reply' id='frm_reply'> <%-- 댓글 등록 폼 --%>
          <input type='hidden' name='noticeno' id='noticeno' value='${noticeno}'>
          <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
          
          <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
          <input type='password' name='passwd' id='passwd' placeholder="비밀번호">
          <button type='button' id='btn_create'>등록</button>
      </FORM>
      <HR>
      <DIV id='reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
      
      </DIV>
      <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin: 0px auto; width: 100%; background-color: #EEFFFF;'>
          <button id='btn_add' style='width: 100%;'>더보기 ▽</button>
      </DIV>  
    
  </DIV>
  
  <!-- ------------------------------ 댓글 영역 종료 ------------------------------  -->
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

