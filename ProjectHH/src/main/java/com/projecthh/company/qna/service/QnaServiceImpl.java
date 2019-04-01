package com.projecthh.company.qna.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.projecthh.company.qna.DAO.QnaDAO;
import com.projecthh.company.qna.vo.QnaVO;

@Service("qnaService")
public class QnaServiceImpl implements QnaService {
	
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "qnaDAO")
	private QnaDAO qnaDAO;

	@Override
	public ArrayList<QnaVO> qnalist(Map<String, Object> map) throws Exception {
		return qnaDAO.qnaList(map);
	}

	@Override
	public QnaVO qnaDetail(String qna_no) throws Exception {
		return qnaDAO.qnaDetail(qna_no);
	}

	@Override
	public void qnaInsert(QnaVO vo) throws Exception {	
		qnaDAO.qnaInsert(vo);
	}

	@Override
	public String deletepass(Map<String, Object> map) {
		return qnaDAO.deletepass(map);
	}

	@Override
	public String password(String parameter) {
		return qnaDAO.password(parameter);
	}

	@Override
	public void qnaUpdate(QnaVO vo) {
		qnaDAO.qnaupdate(vo);
	}

	@Override
	public void qnaDelete(String no) throws Exception {
		qnaDAO.qnaDelete(no);
	}

	@Override
	public void qnacomment(QnaVO vo) {
		qnaDAO.qnacomment(vo);
		
	}

	@Override
	public QnaVO qnaEdit(String no) {
		return qnaDAO.qnaEdit(no);
	}

	@Override
	public ArrayList<QnaVO> search(Map<String, Object> map) throws Exception {
		return qnaDAO.search(map);
	}

	@Override
	public int searchQnaCount(Map<String, Object> map) {
		return qnaDAO.searchQnaCount(map);
	}

}