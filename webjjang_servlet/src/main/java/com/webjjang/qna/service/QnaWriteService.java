package com.webjjang.qna.service;

import com.webjjang.board.dao.BoardDAO;
import com.webjjang.board.vo.BoardVO;
import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.qna.dao.QnaDAO;
import com.webjjang.qna.vo.QnaVO;

public class QnaWriteService implements Service {

	private QnaDAO dao;
	
	// dao setter
	public void setDAO(DAO dao) {
		this.dao = (QnaDAO) dao;
	}

	@Override
	public Integer service(Object obj) throws Exception {
		
		QnaVO vo = (QnaVO) obj;
		
		Long no = dao.getNo();
		vo.setNo(no);
		
		if(vo.isQuestion()) {
			// 질문 - refNo를 no 와 같은 번호로 세팅
			vo.setRefNo(no);
		
		} else {
			// 답변 - refNo와 순서번호가 같거나 큰 경우 순서번호를 1증가 시켜야 함
			dao.increaseOrdNo(vo);
		}
		
		
		// DB board에서 리스트 쿼리 실행해서 데이터 가져오기 - 리턴
		// DB 처리는 DAO에서 처리 - QnaDAO.write()
		// QnaController - (Execute) - [QnaListService] - QnaDAO.list()
		return dao.write((QnaVO)obj);
	}

}
