package com.projecthh.company.notice.DAO;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.projecthh.common.AbstractDAO;
import com.projecthh.company.notice.vo.NoticeVO;

@Repository("noticeDAO")
public class NoticeDAO extends AbstractDAO {

	public void insert(NoticeVO vo) {
		insert("notice.insert", vo);
	}

	public NoticeVO noticeDetail(String parameter) {
		return (NoticeVO) selectOne("notice.noticeDetail", parameter);
	}

	public void noticeDelete(int parseInt) {
		delete("notice.noticeDelete", parseInt);
	}

	public NoticeVO noticeEdit(String parameter) {
		return (NoticeVO) selectOne("notice.noticeEdit", parameter);
	}

	public void edit(NoticeVO vo) {
		selectOne("notice.edit", vo);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<NoticeVO> noticeList(Map<String, Object> map) {
		return (ArrayList<NoticeVO>) selectList("notice.noticeList", map);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<NoticeVO> search(Map<String, Object> map) {
		return (ArrayList<NoticeVO>) selectList("notice.search", map);
	}

	public int searchNoticeCount(Map<String, Object> map) {
		return (Integer) selectOne("notice.totalCount", map);
	}

}