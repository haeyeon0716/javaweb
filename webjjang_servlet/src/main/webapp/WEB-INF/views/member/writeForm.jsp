<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<script type="text/javascript">
$(function(){
	// 이벤트 처리
	// 아이디 체크 처리
	$("#id").keyup(function(){
		let id = $("#id").val();
		// data  확인하기
		console.log("id = " + id);
		// 3자 미만인 경우의 처리
		if(id.length < 3){
			// class 지정 - 디자인
			// alert("3자 미만");
			$("#checkIdDiv").text("아이디는 필수 입력 입니다. 3글자 이상입니다.");
			$("#checkIdDiv").removeClass("alert-success alert-danger")
			.addClass("alert-danger");
			
		} else {
			// alert("3자 이상");
			// 서버에 가서 데이터를 확인하고 온다. - 결과를 JSP로 받는다.
			// $("#checkIdDIV") 안에 넣을 문구를 가져 와서 넣는다.
			// ajax의 load 함수 사용 load(url, data, function(){}); 
			$("#checkIdDiv").load("/ajax/checkId.do?id=" + id, 
					
			// callback 함수 - function(결과, 상태:success/error, 통신객체) {
			function(result) {
			
				if(result.indexOf("중복") >= 0) {
	                $("#checkIdDiv").removeClass("alert-success alert-danger alert-warning")
	                    .addClass("alert-warning");
	            } else {
	                $("#checkIdDiv").removeClass("alert-success alert-danger alert-warning")
	                    .addClass("alert-success");
	            };
            
			}); // checkId Ajax 처리의 끝 
		}; // if(id.length < 3) else 의 끝
	}); // $("#id").keyup의 끝
	
	// 비밀번호와 비밀번호 확인의 이벤트 시작 
	$("#pw, #pw2").keyup(function () {
		
		let pw = $("#pw").val();
		let pw2 = $("#pw2").val();
		// 비밀번호 길이 체크
		if(pw.length < 4){
			// 디자인
			$("#pwDiv").removeClass("alert-success alert-danger")
			.addClass("alert-danger");
			// 글자 오류 적용 
			$("#pwDiv").text("비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
		} else {
			$("#pwDiv").removeClass("alert-success alert-danger")
			.addClass("alert-success");
			
			$("#pwDiv").text("적당한 비밀번호를 입력하셨습니다.");
		}
		// 비밀번호 확인 길이 체크
		if(pw2.length < 4){
			// 디자인
			$("#pwDiv2").removeClass("alert-success alert-danger")
			.addClass("alert-danger");
			// 글자 오류 적용 
			$("#pwDiv2").text("비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
			
		} else {
			// 비밀번호와 비밀번호 확인이 같은지 물어봐야 함
			if( pw != pw2 ) {
				
				//디자인 부분		
				$("#pwDiv2").removeClass("alert-success alert-danger")
				.addClass("alert-danger");
				// 글자 오류 적용 
				$("#pwDiv2").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			} else {
				//디자인 부분		
				$("#pwDiv2").removeClass("alert-success alert-danger")
				.addClass("alert-success");
				// 글자 오류 적용 
				$("#pwDiv2").text("적당한 비밀번호를 입력하셨습니다.");
			}
		}
	
	});// 비밀번호와 비밀번호 확인의 이벤트 끝
});
</script>
</head>
<body>
<div class="container">
	<h2>회원가입 폼</h2>
	<form action="write.do" method="post" enctype="multipart/form-data">
		 <div class="form-group">
		    <label for="id">아이디</label>
			<input id="id" name="id" required autocomplete="off"
				class="form-control" maxlength="20"
				pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$"
				title="맨앞 글자는 영문자 뒤에는 영숫자 입력. 3~20 이내로 입력"
				placeholder="아이디 입력"
			>
		  </div>
		  <div id="checkIdDiv" class="alert alert-danger">
		  	아이디는 필수 입력 입니다. 3글자 이상입니다.
		  </div>
		  
		  <div class="form-group">
		    <label for="pw">비밀번호</label>
			<input id="pw" name="pw" required autocomplete="off"
				class="form-control" maxlength="20" type = "password"
				pattern="^{4,20}$"
				title="4~20 이내로 입력"
				placeholder="비밀번호 입력"
			>
		  </div>
		  
		  <div id="pwDiv" class="alert alert-danger">
		  	비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.
		  </div>
		  
		  <div class="form-group">
		    <label for="pw2">비밀번호 확인</label>
			<input id="pw2" required autocomplete="off"
				class="form-control" maxlength="20" type = "password"
				pattern="^{4,20}$"
				title="4~20 이내로 입력"
				placeholder="비밀번호 확인 입력"
			>
		  </div>
		  <div id="pw2Div" class="alert alert-danger">
		  	비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.
		  </div>

		  <div class="form-group">
		    <label for="content">내용</label>
			<textarea class="form-control" id="content" name="content"  required
			rows="7" placeholder="첫글자는 공백문자나 줄바꿈을 입력할 수 없습니다."></textarea>
		  </div>

		 <div class="form-group">
		    <label for="imageFile">첨부 이미지</label>
			<input id="imageFile" name="imageFile" required 
				class="form-control" type="file"
			>
		  </div>
		  
		<button class="btn btn-primary">등록</button>
		<button type="reset" class="btn btn-secondary">다시입력</button>
		<button type="button" onclick="history.back();" class="btn btn-warning">취소</button>
		
	</form>
</div>
</body>
</html>