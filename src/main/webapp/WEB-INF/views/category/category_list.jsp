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
	$('#title').html("카테고리"); 
	$('#panel_create').css("display","none");
	$('#panel_update').css("display","none");
	$('#panel_delete').css("display","none");
}

function create_login_check(sub_categoryno){
    if("${sessionScope.id }"!= ''){
        if("${sessionScope.grade}"<=10){
            create_ajax();
              }
           else{
                alert("관리자만이 사용 가능한 서비스입니다.")
               }
        }else{
            alert("로그인을 하셔야 가능한 서비스입니다.");
        }
}

function create_ajax(){
	$('#panel_create').css("display","");
    $('#panel_update').css("display","none");
    $('#panel_delete').css("display","none");
    $('#title').html("카테고리 > 등록"); 
      }   
 
function update_login_check(categoryno){
	if("${sessionScope.id }"!= ''){
		if("${sessionScope.grade}"<=10){
			update_read_ajax(categoryno);
			  }
		   else{
			    alert("관리자만이 사용 가능한 서비스입니다.")
			   }
		}else{
			alert("로그인을 하셔야 가능한 서비스입니다.");
		}
}

function update_read_ajax(categoryno){
	$('#panel_create').css("display","none");
    $('#panel_update').css("display","");
    $('#panel_delete').css("display","none");
    $('#title').html("카테고리 > 수정");
    var params = "categoryno =";
    params = 'categoryno='+categoryno; 
    $.ajax(
        {
            url:'/category/read_ajax',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
                var categoryno = rdata.categoryno;
                var categoryname = rdata.categoryname;
                var frm_update = $('#frm_update');
                $('#categoryno',frm_update).val(categoryno);
                $('#categoryname',frm_update).val(categoryname);
            },error: function(request, status, error) { // callback 함수
                console.log(error);
            }
        }
    );
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
	 $('#panel_create').css("display","none");
	$('#panel_update').css("display","none");
	$('#panel_delete').css("display","");
	$('#title').html("카테고리 > 삭제");
	var params = "categoryno =";
	params = 'categoryno='+categoryno; 
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
 
<DIV class='title_line' id = 'title'>카테고리</DIV>

<DIV class='content_body'>
<DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_create' id='frm_create' method='POST' action='./create' enctype="multipart/form-data">      
            <label>카테고리 이름</label>
            <input type='text' id='categoryname' name='categoryname' 'required="required" style='width: 20%;' autofocus="autofocus">     
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='create_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_update' id='frm_update' method='POST' action='./update' enctype="multipart/form-data">      
            <label>카테고리 이름</label>
            <input type='text' id='categoryname' name='categoryname' 'required="required" style='width: 20%;' autofocus="autofocus">     
            <input type="hidden" id='categoryno' name="categoryno" >
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
   
   <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display:none;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete'>
      <input type='hidden' name='categoryno' id='categoryno' '>
       <label>카테고리 번호</label>:<span id='categoryno_output'></span> 
      <label>카테고리 이름</label>:<span id='categoryname_output'></span> 
      
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='delete_cancel'  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='GET' action='./list'>
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
                     onclick="location.href='./list'">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 20%;'/>
      <col style='width: 40%;'/>
      <col style='width: 10%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리 번호</TH>
      <TH class="th_bs">카테고리</TH>
      <TH class="th_bs"> <A href="javascript:create_login_check()" title="등록"><span class="glyphicon glyphicon-plus-sign"></span></A></TH>
    </TR>
    </thead>   
    <tbody>
    <c:forEach var="category_list" items="${list}">      
      <c:set var="categoryno" value="${category_list.categoryno }" />
      <c:set var="categoryname" value="${category_list.categoryname }" />
      <TR>
        <TD class="td_bs">${categoryno }</TD>           
        <TD class="td_bs"><a href="../subcategory/list_bycategory?categoryno=${categoryno }">${categoryname }</a></TD>   
        <TD class="td_bs">
          <A href="javascript:update_login_check(${categoryno })"  title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="javascript:delete_login_check(${categoryno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>         
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