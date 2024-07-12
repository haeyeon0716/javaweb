package com.webjjang.notice.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.webjjang.main.controller.Init;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.notice.vo.NoticeVO;
import com.webjjang.util.page.PageObject;
import com.webjjang.util.exe.Execute;


// Board Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class NoticeController {

	public String execute(HttpServletRequest request) {
		System.out.println("NoticeController.execute() --------------------------");
		// uri
		String uri = request.getRequestURI();
		
		HttpSession session = request.getSession();
		
		int gradeNo = 0;
		
		LoginVO login = (LoginVO) session.getAttribute("login");
		if(login != null) {
			gradeNo = login.getGradeNo();
		}
		
		Object result = null;
		
		String jsp = null;
		
		// 처리 결과를 화면에 표시하기 위함
			
		
		// 입력 받는 데이터 선언
		Long no = 0L;
		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/notice/list.do":
				// [BoardController] - (Execute) - BoardListService - BoardDAO.list()
				System.out.println("1.공지사항 리스트");
				// 페이지 처리를 위한 객체
				// getInstance - 기본 값이 있고 넘어오는 페이지와 검색 정보를 세팅 처리
				PageObject pageObject = PageObject.getInstance(request);
				
				String period = request.getParameter("period");
				
				if (gradeNo == 9) {
					if(period == null || period == "") {
						pageObject.setPeriod("all");
						
					}else {
						pageObject.setPeriod(period);
		
					}
				}
				else {
					pageObject.setPeriod("pre");
				}
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<BoardVO>
				result = Execute.execute(Init.get(uri), pageObject);
				
				// pageObject 데이터 확인
				System.out.println("NoticeController.execute().pageObject = " + pageObject);
				// 가져온 데이터 request에 저장 -> jsp까지 전달된다.
				request.setAttribute("list", result);
				// pageObject 담기
				request.setAttribute("pageObject", pageObject);
				// /WEB-INF/views/ + board/list + .jsp
				jsp = "notice/list";
				break;
				
			case "/notice/view.do":
				System.out.println("2.공지사항 글보기");
				// 1. 조회수 1증가(글보기), 2. 일반게시판 글보기 데이터 가져오기 : 글보기, 글수정
				// 넘어오는 글번호와 조회수 1증가를 수집한다.(request에 들어 있다.)
				String strNo = request.getParameter("no");
				no = Long.parseLong(strNo);
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map
				result = Execute.execute(Init.get(uri), no);
				// 가져온 데이터를 JSP로 보내기 위해서 request에 담는다.
				request.setAttribute("vo", result);
				
				// 댓글 페이지 객체
				// 데이터 전달 - page / perPageNum / no / replyPage / replyPerPageNum 
//				ReplyPageObject replyPageObject 
//					= ReplyPageObject.getInstance(request);
//				// 가져온 댓글 데이터 request에 담기
//				request.setAttribute("replyList",
//						Execute.execute(Init.get("/boardreply/list.do"),replyPageObject));
//				// 댓글 페이지 객체 담기
//				request.setAttribute("replyPageObject", replyPageObject);
				
				jsp = "notice/view";
				break;
				
			case "/notice/writeForm.do":
				System.out.println("3-1.일반게시판 글등록 폼");
				jsp="notice/writeForm";
				break;
				
			case "/notice/write.do":
				System.out.println("3.공지사항 글등록 처리");
				
				// 데이터 수집(사용자->서버 : form - input - name)
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");
				
				
				// 변수 - vo 저장하고 Service
				NoticeVO vo = new NoticeVO();
				vo.setTitle(title);
				vo.setContent(content);
				vo.setStartDate(startDate);
				vo.setEndDate(endDate);
				
				
				// [BoardController] - BoardWriteService - BoardDAO.write(vo)
				Execute.execute(Init.get(uri), vo);
				
				session.setAttribute("msg", "공지사항 등록이 완료 되었습니다");
				
				// jsp 정보 앞에 "redirect:"가 붙어 있어 redirect를
				// 아니면 jsp로 forward로 시킨다.
				jsp = "redirect:list.do?perPageNum=" 
						+ request.getParameter("perPageNum");
				
				break;
				
			case "/notice/updateForm.do":
				System.out.println("4-1.일반게시판 글수정 폼");
				
				// 사 -> 서버 : 글번호
				no = Long.parseLong(request.getParameter("no"));
				
				// no맞는 데이터 DB에서 가져온다. BoardViewService
				result = Execute.execute(Init.get("/notice/view.do"),no);
				// 가져온 데이터를 JSP로 보내기 위해서 request에 담는다.
				request.setAttribute("vo", result);
				
				// jsp 정보
				jsp = "notice/updateForm";
				
				break;
				
			case "/notice/update.do":
				System.out.println("4-2.일반게시판 글수정 처리");
				
				// 데이터 수집(사용자->서버 : form - input - name)
				no = Long.parseLong(request.getParameter("no"));
				title = request.getParameter("title");
				content = request.getParameter("content");
				startDate = request.getParameter("startDate");
				endDate = request.getParameter("endDate");
				
				
				// 변수 - vo 저장하고 Service
				vo = new NoticeVO();
				vo.setNo(no);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setStartDate(startDate);
				vo.setEndDate(endDate);

				// DB 적용하는 처리문 작성. BoardUpdateservice
				Execute.execute(Init.get(uri), vo);
				
				// 페이지 정보 받기 & uri에 붙이기
				pageObject = PageObject.getInstance(request);
				
				// 메세지 출력
				session.setAttribute("msg", "공지사항 수정이 완료 되었습니다");
				
				// 글보기로 자동 이동 -> jsp 정보를 작성해서 넘긴다.
				jsp = "redirect:view.do?no=" + no 
						+ "&"
						+ pageObject.getPageQuery()
						;
				break;
			case "/notice/delete.do":
				System.out.println("5.일반게시판 글삭제");
				// 데이터 수집 - DB에서 실행에 필요한 데이터 - 글번호, 비밀번호 - BoardVO
				
				no = Long.parseLong(request.getParameter("no"));	
			
				
				// DB 처리
				Execute.execute(Init.get(uri), no);
				
				// 메세지 
				session.setAttribute("msg", "공지사항 삭제가 완료 되었습니다");
				
				jsp = "redirect:list.do?perPageNum=" 
						+ request.getParameter("perPageNum");
				
				break;
				
			default:
				jsp = "error/404";
				break;
			} // end of switch
		} catch (Exception e) {
			// TODO: handle exception
			// e.printStackTrace();
			// 예외 객체를 jsp에서 사용하기 위해 request에 담는다
			request.setAttribute("e", e);
			
			jsp = "error/500";
		} // end of try~catch
		return jsp;
	} // end of execute()
	
} // end of class
