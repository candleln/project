package com.projecthh.company.qna.DAO;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.projecthh.common.AbstractDAO;
import com.projecthh.company.qna.vo.QnaVO;


@Repository("qnaDAO")
public class QnaDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public ArrayList<QnaVO> qnaList(Map<String, Object> map) {
		return (ArrayList<QnaVO>) selectList("qnaList", map);
	}

	public QnaVO qnaDetail(String qna_no) {
		return (QnaVO) selectOne("qnaDetail", qna_no);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<QnaVO> search(Map<String, Object> map) {
		return (ArrayList<QnaVO>) selectList("qna.search", map);
	}

	public void qnaInsert(QnaVO vo) {
		insert("qnaInsert", vo);
	}

	public String updatepass(Map<String, Object> map) {
		return (String) update("updatepass", map);
	}

	public String deletepass(Map<String, Object> map) {
		return (String) delete("deletepass", map);
	}

	public String password(String parameter) {
		return (String) selectOne("qnapass", parameter);
	}

	public void qnaupdate(QnaVO vo) {
		update("qnaUpdate", vo);
	}

	public void qnaDelete(String no) {
		update("qnaDelete", no);
	}

	public void qnacomment(QnaVO vo) {
		update("qnacomment", vo);
	}

	public QnaVO qnaEdit(String no) {
		return (QnaVO) selectOne("qnaEdit", no);
	}

	public int searchQnaCount(Map<String, Object> map) {
		return (Integer) selectOne("qnaListCount", map);
	}
	

}