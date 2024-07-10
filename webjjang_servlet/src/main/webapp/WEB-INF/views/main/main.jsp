<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
	<div class="container">
		<h2>웹짱 닷컴</h2>
		<div class="row">
			<div class="col-sm-12">
				<jsp:include page="boardList.jsp"></jsp:include>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<jsp:include page="imageList.jsp"></jsp:include>
			</div>
		</div>
	</div>
</body>
</html>