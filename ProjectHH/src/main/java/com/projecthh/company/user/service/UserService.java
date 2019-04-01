package com.projecthh.company.user.service;

import java.util.ArrayList;
import java.util.Map;

import com.projecthh.company.notice.vo.NoticeVO;
import com.projecthh.company.qna.vo.QnaVO;
import com.projecthh.company.user.vo.UserVO;

public interface UserService {

	UserVO login(UserVO vo) throws Exception;

	void insertUser(UserVO vo);

	void updateUserState(Map<String, Object> map);

	void updateAuthKey(Map<String, Object> map);

	int selectUser(Map<String, Object> map);

	UserVO userInfo(String no) throws Exception;

	void infoupdate(UserVO dto);

	int checkID(String id);

	ArrayList<NoticeVO> notice() throws Exception;

	ArrayList<QnaVO> qna() throws Exception;
}