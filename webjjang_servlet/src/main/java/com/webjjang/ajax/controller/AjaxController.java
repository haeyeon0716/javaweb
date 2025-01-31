package com.webjjang.ajax.controller;

import javax.servlet.http.HttpServletRequest;

import com.webjjang.main.controller.Init;
import com.webjjang.util.exe.Execute;



// Member Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class AjaxController {

	public String execute(HttpServletRequest request) {
		System.out.println("MemberController.execute() --------------------------");

		// 로그인 처리를 session으로 한다.
		// login된 정보 중에서 id를 많이 사용한다.
		String id = null;

		// uri
		String uri = request.getRequestURI();

		String jsp = null;

		try { // 정상 처리

			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {

			case "/ajax/checkId.do":
				System.out.println("1.아이디 중복 체크 처리");

				// 데이터 수집(사용자->서버 : form - input - name)
				id = request.getParameter("id");

				// [MemberController] - MemberCheckIdService - MemberDAO.checkId(id)
				id = (String) Execute.execute(Init.get(uri), id);

				request.setAttribute("id", id);
				// jsp 정보 앞에 "redirect:"가 붙어 있어 redirect를
				// 아니면 jsp로 forward로 시킨다.
				jsp = "member/checkId";

				break;

			default:
				jsp = "error/nomodule_404";
				break;
			} // end of switch
		} catch (Exception e) {
			request.setAttribute("e", e);

			jsp = "error/nomodule_500";

		} // end of try~catch
		return jsp;
	} // end of execute()

} // end of class
