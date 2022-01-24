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
    $('#create_cancel').on('click',cancel);
     $('#update_cancel').on('click',cancel);
     $('#panel_delete').on('click',cancel);
});
function cancel(){  
    $('#panel_create').css("display","none");
    $('#panel_update').css("display","none");
    $('#panel_delete').css("display","none");
}
function create_ajax(){
    $('#panel_create').css("display","");
    $('#panel_update').css("display","none");
    $('#panel_delete').css("display","none");
    $('#title').html("게시글 > 등록"); 
      }   
 
function update_read_ajax(postno){
    $('#panel_create').css("display","none");
    $('#panel_update').css("display","");
    $('#panel_delete').css("display","none");
    $('#title').html("게시글 > 수정");
    var params = "postno =";
    params = 'postno='+postno; 
    $.ajax(
        {
            url:'/post/read_ajax',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
                var postno = rdata.postno;
                var memberno = rdata.memberno;
                var title = rdata.title;
                var contents = rdata.contents;
                var pdate = rdata.pdate;
                
                var frm_update = $('#frm_update');
                $('#postno',frm_update).val(postno);
                $('#memberno',frm_update).val(memberno);
                $('#title',frm_update).val(title);
                $('#contents',frm_update).val(contents);
                $('#pdate',frm_update).val(pdate);
                
            },error: function(request, status, error) { // callback 함수
                console.log(error);
            }
        }
    );
 }
 
 function delete_read_ajax(postno){
     $('#panel_create').css("display","none");
    $('#panel_update').css("display","none");
    $('#panel_delete').css("display","");
    $('#title').html("게시글 > 삭제");
    
    var params = "postno =";
    params = 'postno='+postno;
     
    $.ajax(
        {
            url:'/post/read_ajax',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
                console.log('rdata'+rdata)
                var postno = rdata.postno;
                var memberno = rdata.memberno;
                var title = rdata.title;
                var contents = rdata.contents;
                var pdate = rdata.pdate;
                
                var frm_delete = $('#frm_delete');
                $('#postno',frm_delete).val(postno);
                               
                $('#memberno_output',frm_delete).html(memberno);
                $('#title_output',frm_delete).html(title);
                $('#contents_output',frm_delete).html(contents);
                $('#pdate_output',frm_delete).html(pdate);
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
 
<DIV class='title_line' id = 'title'>게시판</DIV>

<DIV class='content_body'>

<c:choose>
    <c:when test="${sessionScope.id != null}"><!--  로그인한 사람이 관리자일 경우 -->
<DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_create' id='frm_create' method='POST' action='./create' enctype="multipart/form-data">      
        <input type='hidden' name='memberno' id='memberno' value="${memberno }">
            <label>제목</label>
            <input type='text' id='title' name='title' required="required" style='width: 10%;'>     
            
            <label>내용</label>
            <input type='text' id='contents' name='contents' required="required" style='width: 10%;'>     
            
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='create_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
  
    <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_update' id='frm_update' method='POST' action='./update' enctype="multipart/form-data">      
        <input type='hidden' name='postno' id='postno' >
            <label>제목</label>
            <input type='text' id='title' name='title' required="required" style='width: 10%;'>     
            
            <label>내용</label>
            <input type='text' id='contents' name='contents' required="required" style='width: 10%;'>     
    
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
   
   <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display:none;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete'>
      <input type='hidden' name='postno' id='postno' >
      
       <label>제목</label>:<span id='title_output'></span> 
       <label>내용</label>:<span id='contents_output'></span> 
      
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='delete_cancel'  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
    </c:when> 
</c:choose>
            

  

    
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/> 
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">번호</TH>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">내용</TH>
      <TH class="th_bs">작성일</TH>
      <c:choose>
      <c:when test="${sessionScope.id != null}"><!--  로그인한 사람이 관리자일 경우 -->
      <TH class="th_bs"> <A href="javascript:create_ajax()" title="등록"><span class="glyphicon glyphicon-plus-sign"></span></A></TH>
      </c:when> 
      </c:choose>

    </TR>
    </thead>   
    <tbody>
    <c:forEach var="postVO" items="${list}">      
      <c:set var="postno" value="${postVO.postno }" />  
      <c:set var="memberno" value="${postVO.memberno }" />      
      <c:set var="title" value="${postVO.title }" />      
      <c:set var="contents" value="${postVO.contents }" />      
      <c:set var="pdate" value="${postVO.pdate }" /> 
      <TR>
        <TD class="td_bs">${postno }</TD>           
        <%-- <TD class="td_bs"><a href="../post?postno=${postno }">${postno }</a></TD> --%>
        <TD class="td_bs">${title }</TD>
        <TD class="td_bs">${contents }</TD>
        <TD class="td_bs">${pdate }</TD>
        <TD class="td_bs"> 
        <c:choose>
        <c:when test="${sessionScope.id != null}"><!--  로그인한 사람이 관리자일 경우 -->
          <A href="javascript:update_read_ajax(${postno })"  title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="javascript:delete_read_ajax(${postno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>         
         </c:when> 
         </c:choose>

        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
 
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>