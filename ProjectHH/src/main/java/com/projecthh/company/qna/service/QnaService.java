package com.projecthh.company.qna.service;

import java.util.ArrayList;
import java.util.Map;

import com.projecthh.company.qna.vo.QnaVO;

public interface QnaService {

	ArrayList<QnaVO> qnalist(Map<String, Object> map) throws Exception;

	QnaVO qnaDetail(String qna_no) throws Exception;

	void qnaInsert(QnaVO vo) throws Exception;

	String deletepass(Map<String, Object> map) throws Exception;

	String password(String parameter) throws Exception;

	void qnaUpdate(QnaVO vo) throws Exception;

	void qnaDelete(String no) throws Exception;

	void qnacomment(QnaVO vo) throws Exception;

	QnaVO qnaEdit(String no) throws Exception;

	ArrayList<QnaVO> search(Map<String, Object> map) throws Exception;

	int searchQnaCount(Map<String, Object> map) throws Exception;

}