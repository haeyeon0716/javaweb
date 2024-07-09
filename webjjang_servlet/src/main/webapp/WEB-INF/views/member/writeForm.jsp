<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
    <title>회원가입 폼</title>
    <script type="text/javascript">
        $(function() {
            let now = new Date();
            let startYear = now.getFullYear();
            let yearRange = (startYear - 100) + ":" + startYear;

            // 날짜 입력 설정 - datepicker
            $(".datepicker").datepicker({
                dateFormat: "yy-mm-dd",
                changeMonth: true,
                changeYear: true,
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                yearRange: yearRange,
                maxDate: new Date(),
            });

            // 이벤트 처리
            $("#id").keyup(function() {
                let id = $("#id").val();
                console.log("id = " + id);
                if (id.length < 3) {
                    $("#checkIdDiv").text("아이디는 필수 입력 입니다. 3글자 이상입니다.");
                    $("#checkIdDiv").removeClass("alert-success alert-danger").addClass("alert-danger");
                } else {
                    $("#checkIdDiv").load("/ajax/checkId.do?id=" + id, function(result) {
                        if (result.indexOf("중복") >= 0) {
                            $("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");
                        } else {
                            $("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-success");
                        }
                    });
                }
            });

            $("#pw, #pw2").keyup(function() {
                let pw = $("#pw").val();
                let pw2 = $("#pw2").val();
                if (pw.length < 4) {
                    $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-danger");
                    $("#pwDiv").text("비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
                } else {
                    $("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-success");
                    $("#pwDiv").text("적당한 비밀번호를 입력하셨습니다.");
                }
                if (pw2.length < 4) {
                    $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
                    $("#pw2Div").text("비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
                } else {
                    if (pw != pw2) {
                        $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
                        $("#pw2Div").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
                    } else {
                        $("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-success");
                        $("#pw2Div").text("적당한 비밀번호를 입력하셨습니다.");
                    }
                }
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>회원가입 폼</h2>
        <form action="write.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="id">아이디</label>
                <input id="id" name="id" required autocomplete="off" class="form-control" maxlength="20" pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$" title="맨앞 글자는 영문자 뒤에는 영숫자 입력. 3~20 이내로 입력" placeholder="아이디 입력">
            </div>
            <div id="checkIdDiv" class="alert alert-danger">아이디는 필수 입력 입니다. 3글자 이상입니다.</div>

            <div class="form-group">
                <label for="pw">비밀번호</label>
                <input id="pw" name="pw" required autocomplete="off" class="form-control" maxlength="20" type="password" pattern="^{4,20}$" title="4~20 이내로 입력" placeholder="비밀번호 입력">
            </div>
            <div id="pwDiv" class="alert alert-danger">비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.</div>

            <div class="form-group">
                <label for="pw2">비밀번호 확인</label>
                <input id="pw2" required autocomplete="off" class="form-control" maxlength="20" type="password" pattern="^{4,20}$" title="4~20 이내로 입력" placeholder="비밀번호 확인 입력">
            </div>
            <div id="pw2Div" class="alert alert-danger">비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.</div>

            <div class="form-group">
                <label for="name">이름</label>
                <input id="name" name="name" required autocomplete="off" class="form-control" maxlength="10" pattern="^[가-힣]{2,10}$" title="한글로 2-10자 이내로 입력" placeholder="이름 입력">
            </div>

            <div class="form-group">
                <label>성별</label>
                <div class="form-check-inline">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="gender" checked value="남자">남자
                    </label>
                </div>
                <div class="form-check-inline">
                    <label class="form-check-label">
                        <input type="radio" class="form-check-input" name="gender" value="여자">여자
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="birth">생년월일</label>
                <input id="birth" name="birth" required class="form-control datepicker" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="tel">연락처</label>
                <input id="tel" name="tel" class="form-control" placeholder="xxx-xxxx-xxxx">
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input id="email" name="email" required class="form-control" placeholder="id@domain">
            </div>
            <div class="form-group">
                <label for="photoFile">첨부 이미지</label>
                <input id="photoFile" name="photoFile" class="form-control" type="file">
            </div>

            <button class="btn btn-primary">가입</button>
            <button type="reset" class="btn btn-secondary">다시입력</button>
            <button type="button" onclick="history.back();" class="btn btn-warning">취소</button>
        </form>
    </div>
</body>
</html>
