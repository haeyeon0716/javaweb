<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500 Error</title>
<style type="text/css">
	#errorDiv > div {
		padding: 10px;
		border-bottom: 1px dotted #ddd;
	}
	
	#errorDiv{
		padding
	}

</style>

</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-header">
				<h3>처리 프로세스 오류(500)</h3>
			</div>
			<div class="card-body" id = "errorDiv">
			<div>
			<i class="material-icons" style="font-size:48px;color:red">error</i>
			</div>
				<div class="row">
					<div class="col-sm-3">오류 객체</div>
					<div class="col-sm-9">${e.getClass().simpleName }</div>
				</div>
				<div class="row">
					<div class="col-sm-3">오류 메세지</div>
					<div class="col-sm-9">${e.message }</div>
				</div>
				<div class="row">
					<div class="col-sm-3">조치사항</div>
					<div class="col-sm-9">오류로 인해 불편을 드려 죄송합니다.<br>
						다시 한번 시도 해 주세요.
						<p>오류가 계속 발생 되시면 전산 담장자에게 연락 해 주세요.
					</div>
				</div>
			</div>
			<div class="card-footer">
				<a href="/board/list.do" class="btn btn-primary">일반 게시판으로 이동</a>
			</div>
		</div>
	</div>
</body>
</html>