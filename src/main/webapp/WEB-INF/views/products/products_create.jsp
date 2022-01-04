<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Mukjang</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> <!-- bootstrap사용코드 -->

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>${sub_categoryname } > 상품등록</DIV>
 
<DIV class=>
  <FORM name='frm' method='POST' action='./create' class="form-horizontal"
                        enctype="multipart/form-data">
    <div class="form-group">
       <label class="control-label col-md-4">상품명</label>
       <div class="col-md-8">
       <input type="hidden" name='categoryno' value=${categoryno }></input>
       <input type="hidden" name='sub_categoryno' value=${sub_categoryno }></input>
         <input type='text' name='productname' value='' required="required" placeholder="상품명"
                    autofocus="autofocus" class="form-control" style='width: 50%;'>                                  
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-4">제품 설명</label>
       <div class="col-md-8">
         <textarea name='product_Explanation'  placeholder="상품설명" style='width: 30%;' >
          </textarea> 
       </div>
   </div>   
   <div class="form-group">
       <label class="control-label col-md-2">상품가격</label>
       <div class="col-md-10">
         <input type='number' name='product_price' value='' required="required"
                    min="0" max="10000000" step="100" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">상품 이미지</label>
       <div class="col-md-8">
         <input type='file' class="form-control" name='file1M1' id='file1M1' 
                    value='' placeholder="파일 선택">
       </div>
    </div>   
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn">목록</button>
    </div>
  
  </FORM>
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>