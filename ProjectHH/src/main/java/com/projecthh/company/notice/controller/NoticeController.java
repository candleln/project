package com.projecthh.company.notice.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.projecthh.common.PageMaker;
import com.projecthh.company.notice.service.NoticeService;
import com.projecthh.company.notice.vo.NoticeVO;

@Controller
public class NoticeController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "noticeService")
	private NoticeService noticeService;

	@RequestMapping(value = "noticeList")
	public ModelAndView selectNoticeList(HttpServletRequest request, ArrayList<NoticeVO> vo) throws Exception {
		ModelAndView mv = new ModelAndView("/company/NOTICE/NOTLIS01");

		int startPage = 0;
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			startPage = (page - 1) * 10;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", startPage);
			
		//검색
		if ((request.getParameter("search")) == null) {
			vo = noticeService.noticeList(map);
		} else {
			map.put("search", request.getParameter("search"));
			vo = noticeService.search(map);
			mv.addObject("search", map.get("search"));			
		}

		PageMaker pm = new PageMaker();	
		pm.setTotalCount(noticeService.searchNoticeCount(map), page);
		mv.addObject("page", pm);		
		mv.addObject("list", vo);
		
		return mv;
	}

	@RequestMapping(value = "noticeDetail")
	public ModelAndView selectNoticeDetail(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("company/NOTICE/NOTDET01");
		NoticeVO vo = new NoticeVO();
		vo = noticeService.noticeDetail(request.getParameter("notice_no"));
		mv.addObject("detail", vo);
		return mv;
	}

	@RequestMapping(value = "noticeEdit")
	public ModelAndView editNotice(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("company/NOTICE/NOTEDI01");
		NoticeVO vo = new NoticeVO();
		vo = noticeService.noticeEdit(request.getParameter("notice_no"));
		mv.addObject("edit", vo);
		return mv;
	}

	@RequestMapping(value = "noticeUpdate")
	public ModelAndView updateNotice(HttpServletRequest request) throws Exception {
		noticeService.edit(notice(request));
		String no = request.getParameter("notice_no");
		return new ModelAndView("redirect:noticeDetail?notice_no=" + no);
	}

	@RequestMapping(value = "noticeInsert")
	public ModelAndView noticeInsert(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("company/NOTICE/NOTINS01");

		if (request.getParameter("title") != null && request.getParameter("content") != null) {
			noticeService.insert(notice(request));
			return new ModelAndView("redirect:noticeList");
		}

		return mv;
	}

	@RequestMapping(value = "noticeDelete")
	public ModelAndView deleteNotice(HttpServletRequest request) throws Exception {
		noticeService.noticedelete(Integer.parseInt(request.getParameter("notice_no")));
		return new ModelAndView("redirect:noticeList");
	}

	public NoticeVO notice(HttpServletRequest request) throws Exception {
		NoticeVO vo = new NoticeVO();
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		if ((request.getParameter("notice_no")) != null) {
			vo.setNotice_no(request.getParameter("notice_no"));
		}
		return vo;
	}

}