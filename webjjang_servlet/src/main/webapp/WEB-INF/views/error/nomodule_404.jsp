<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>

<%
	// Dispatcher Servlet을 걸치지 않고 들어온 경우
	// uri 가 없어서 request에서 꺼내고 넘어옴
	if(session.getAttribute("uri") == null) {
		session.setAttribute("uri", request.getRequestURI());
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>404 Error</title>
<!-- Bootstrap 4 + jquery 라이브러리 등록 - CDN 방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"
></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
></script>

<!-- icon 라이브러리 등록 - Font Awesome 4 / google -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet"
>

<style type="text/css">
#errorDiv>div {
	padding: 10px;
	border-bottom: 1px dotted #ddd;
	margin: 0 10px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-header">
				<h3>요청 자원 오류(404)</h3>
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
					<div class="col-sm-9">요청하신 페이지의 주소가 존재하지 않거나 지원하지 않습니다.</div>
				</div>
				<div class="row">
					<div class="col-sm-3">
						<i class="fa fa-check"></i>
						조치사항
					</div>
					<div class="col-sm-9">
						오류로 인해 불편을 드려 죄송합니다.<br> 요청 하신 페이지의 주소를 확인하시고 다시 한번 시도 해 주세요.
						<p>
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