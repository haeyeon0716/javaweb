<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 Error</title>
</head>
<body>
	<div class="container">
		<div class="card-header">
			<h3>권한 오류(404)</h3>
		</div>
		<div class="card-body" id="errorDiv">
			<div>
				<i class="material-icons" style="font-size: 48px; color: red">error</i>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<i class="fa fa-check"></i>
					요청 URI
				</div>
				<div class="col-sm-9">${uri }</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<i class="fa fa-check"></i>
					오류 메세지
				</div>
				<div class="col-sm-9">페이지 접근 권한이 없습니다.</div>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<i class="fa fa-check"></i>
					조치사항
				</div>
				<div class="col-sm-9">
					로그인 정보의 등급으 확인 해주세요. 오류가 있는 경우 관리자에게 문의 해주세요.
					<p>
				</div>
			</div>
		</div>
		<div class="card-footer">
			<a href="/board/list.do" class="btn btn-primary">일반 게시판으로 이동</a>
		</div>
	</div>
</body>
</html>