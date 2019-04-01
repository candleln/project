package com.projecthh.company.notice.service;

import java.util.ArrayList;
import java.util.Map;

import com.projecthh.company.notice.vo.NoticeVO;

public interface NoticeService {

	void insert(NoticeVO vo) throws Exception;

	NoticeVO noticeDetail(String parameter) throws Exception;

	void noticedelete(int parseInt) throws Exception;

	NoticeVO noticeEdit(String parameter) throws Exception;

	void edit(NoticeVO vo) throws Exception;

	ArrayList<NoticeVO> noticeList(Map<String, Object> map) throws Exception;

	ArrayList<NoticeVO> search(Map<String, Object> map) throws Exception;

	int searchNoticeCount(Map<String, Object> map);

}