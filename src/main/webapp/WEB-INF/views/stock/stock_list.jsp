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
    $('#title').html("재고 > 등록"); 
    
    $.ajax(
            {
                url:'/products/list_read_ajax',
                type: 'get',
                cache: false, // 응답 결과 임시 저장 취소
                async: true,  // true: 비동기 통신
                dataType: 'json', // 응답 형식: json, html, xml...
                data:false,
                success: function(rdata){
                    var html= products(rdata.product_list_data);
                    $('#product_select').html(html);
                },error: function(request, status, error) { // callback 함수
                    console.log(error);
              }
          }
     );
}   
      
function products(product_list_data) {
    var html = "";
    html += "<select name=productno id='productno'>";
    for (var i = 0; i < product_list_data.length; i++) {
        html += "<option value='"+product_list_data[i].productno+"'>";
        html += product_list_data[i].productname + "</option>";
    }
    html += "</select>";
    return html;
}

function update_read_ajax(productno){
    $('#panel_create').css("display","none");
    $('#panel_update').css("display","");
    $('#panel_delete').css("display","none");
    $('#title').html("재고 > 수정");
    var params = "productno =";
    params = 'productno='+productno; 
    $.ajax(
        {
            url:'/stock/read_ajax',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
                var productno = rdata.productno;
                var productname = rdata.productname;
                var stocknum = rdata.stocknum;      
                var stockno = rdata.stockno;   
                var productwa = rdata.productwa; 
                var productst = rdata.productst; 
                
                var frm_update = $('#frm_update');
                $('#productno',frm_update).val(productno);
                $('#productname',frm_update).text(productname);
                $('#stocknum',frm_update).val(stocknum);
                $('#stockno',frm_update).val(stockno);
                $('#productwa',frm_update).val(productwa);
                $('#productst',frm_update).val(productst);
                
            },error: function(request, status, error) { // callback 함수
                console.log(error);
            }
        }
    );
 }
 
 function delete_read_ajax(productno){
     $('#panel_create').css("display","none");
    $('#panel_update').css("display","none");
    $('#panel_delete').css("display","");
    $('#title').html("재고 > 삭제");
    
    var params = "productno =";
    params = 'productno='+productno;
     
    $.ajax(
        {
            url:'/stock/read_ajax',
            type: 'get',
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,
            success: function(rdata){
                console.log('rdata'+rdata)
                var stocknum = rdata.stocknum;
                var stockno = rdata.categoryno;
                var productclass = rdata.productclass;
                var productwa = rdata.productwa;
                var productst = rdata.productst;
                
                var frm_delete = $('#frm_delete');
                $('#stocknum',frm_delete).val(stocknum);               
                $('#stocknum_output',frm_delete).html(stocknum);
                $('#stockno_output',frm_delete).html(stockno);
                $('#productclass_output',frm_delete).html(productclass);
                $('#productwa_output',frm_delete).html(productwa);
                $('#productst_output',frm_delete).html(productst);
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
 
<DIV class='title_line' id = 'title'>재고</DIV>

<DIV class='content_body'>

<DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_create' id='frm_create' method='POST' action='./create' enctype="multipart/form-data">      
             <label>상품명</label>
            <select id = 'product_select' name = 'productno'>              
                    <!--ajax요청을 통해 상품 목록을 입력  -->                          
            </select>
            <label>재고 수량</label>
            <input type='number' id='stockno' name='stockno' required="required" value='1' required="required" min='0' max='1000' step='1' style='width: 10%;'>                                             
            <label>폐기 예정 수량</label>
            <input type='number' id='productwa' name='productwa' required="required" value='0' min='0' max='1000' step='1' style='width: 10%;'>     
            
            <label>입고 예정 수량</label>
            <input type='number' id='productst' name='productst' required="required" value='0' min='0' max='1000' step='1' style='width: 10%;'>     
            
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='create_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
  
  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display: none;'>
        <FORM name='frm_update' id='frm_update' method='POST' action='./update' enctype="multipart/form-data">  
            <label>상품명</label> 
            <label id='productname'></label>  
            <label>재고 수량</label>
            <input type='hidden' id='stocknum' name='stocknum' value='${stocknum }'>
            <input type='hidden' id='productno' name='productno' value='${productno }'>
            <input type='number' id='stockno' name='stockno' required="required" value='1' required="required" min='0' max='1000' step='1' style='width: 10%;'>     
                        
            <label>폐기 예정 수량</label>
            <input type='number' id='productwa' name='productwa' required="required" min='0' max='1000' step='1' style='width: 10%;'>     
            
            <label>입고 예정 수량</label>
            <input type='number' id='productst' name='productst' required="required" min='0' max='1000' step='1' style='width: 10%;'>     
            
            <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">등록</button>
            <button type="button" id='update_cancel' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
        </FORM>
  </DIV> 
   
   <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center; display:none;'>
    <div class="msg_warning">삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete'>
      <input type='hidden' name='stocknum' id='stocknum' >
      
       <label>재고 수량</label>:<span id='stockno_output'></span> 
       <label>상품명</label>:<span id='productclass_output'></span>
       <label>폐기 예정 수량</label>:<span id='productwa_output'></span>
       <label>입고 예정 수량</label>:<span id='productst_output'></span> 
      
      <button type="submit" id='submit' class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">삭제</button>
      <button type="button" id='delete_cancel'  class='btn btn-primary btn-xs' style="height: 22px; margin-bottom: 3px;">취소</button>
    </FORM>
  </DIV>
    
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
      <TH class="th_bs">재고 번호</TH>
      <TH class="th_bs">상품명</TH>
      <TH class="th_bs">상품번호</TH>
      <TH class="th_bs">재고 수량</TH>
      <TH class="th_bs">폐기 예정 수량</TH>
      <TH class="th_bs">입고 예정 수량</TH>

      <TH class="th_bs"> <A href="javascript:create_ajax()" title="등록"><span class="glyphicon glyphicon-plus-sign"></span></A></TH>
    </TR>
    </thead>   
    <tbody>
    <c:forEach var="stockVO" items="${list}">      
      <c:set var="stocknum" value="${stockVO.stocknum }" />  
      <c:set var="stockno" value="${stockVO.stockno }" />          
      <c:set var="productwa" value="${stockVO.productwa }" />      
      <c:set var="productst" value="${stockVO.productst }" />      
      <c:set var="productno" value="${stockVO.productno }" />
      <c:set var="productname" value="${stockVO.productname }" />
      <TR>
        <TD class="td_bs">${stocknum }</TD> 
        <TD class="td_bs">${productname }</TD>   
        <TD class="td_bs">${productno }</TD>                  
        <TD class="td_bs">${stockno }</TD>   
        <TD class="td_bs">${productwa }</TD>
        <TD class="td_bs">${productst }</TD>
        
        <TD class="td_bs"> 
          <A href="javascript:update_read_ajax(${productno })"  title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="javascript:delete_read_ajax(${productno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>         
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
 
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>