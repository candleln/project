package com.projecthh.company.notice.service;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.projecthh.company.notice.DAO.NoticeDAO;
import com.projecthh.company.notice.vo.NoticeVO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "noticeDAO")
	private NoticeDAO noticeDAO;

	@Override
	public void insert(NoticeVO vo) throws Exception {
		noticeDAO.insert(vo);
	}

	@Override
	public NoticeVO noticeDetail(String parameter) {
		return noticeDAO.noticeDetail(parameter);
	}

	@Override
	public void noticedelete(int parseInt) {
		noticeDAO.noticeDelete(parseInt);
	}

	@Override
	public NoticeVO noticeEdit(String parameter) {
		return noticeDAO.noticeEdit(parameter);
	}

	@Override
	public void edit(NoticeVO vo) throws Exception {
		noticeDAO.edit(vo);
	}

	@Override
	public ArrayList<NoticeVO> noticeList(Map<String, Object> map) throws Exception {
		return noticeDAO.noticeList(map);
	}

	@Override
	public ArrayList<NoticeVO> search(Map<String, Object> map) throws Exception {
		return noticeDAO.search(map);
	}

	@Override
	public int searchNoticeCount(Map<String, Object> map) {
		return noticeDAO.searchNoticeCount(map);
	}

}