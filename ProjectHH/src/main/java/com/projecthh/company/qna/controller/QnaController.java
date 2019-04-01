package com.projecthh.company.qna.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.projecthh.common.PageMaker;
import com.projecthh.company.qna.service.QnaService;
import com.projecthh.company.qna.vo.QnaVO;
import com.projecthh.company.user.service.UserService;
import com.projecthh.company.user.vo.UserVO;

@Controller
public class QnaController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "qnaService")
	private QnaService qnaService;
	
	@Resource(name = "userService")
	private UserService userService;

	@RequestMapping(value = "/qnaList")
	public ModelAndView qnaList(HttpServletRequest request, ArrayList<QnaVO> qnalist) throws Exception {
		ModelAndView mv = new ModelAndView("/company/QNA/QNALIS01");
		
		int startPage = 0;
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			startPage = (page - 1) * 10;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", startPage);

		//검색
		if ((request.getParameter("category")) == null) {
			qnalist = qnaService.qnalist(map);			
		} else {
			map.put("fromDate", request.getParameter("fromDate"));
			map.put("toDate", request.getParameter("toDate"));
			map.put("category",request.getParameter("category"));			
			map.put("search", request.getParameter("search"));			
			qnalist = qnaService.search(map);
			mv.addObject("map", map);
		}

		PageMaker pm = new PageMaker();	
		pm.setTotalCount(qnaService.searchQnaCount(map), page);
		
		mv.addObject("page", pm);		
		mv.addObject("qnalist", qnalist);

		return mv;
	}

	@RequestMapping(value = "qnaDetail")
	public ModelAndView qnaDetail(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/company/QNA/QNADET01");
		String qna_no = request.getParameter("no");
		QnaVO vo = qnaService.qnaDetail(qna_no);
		mv.addObject("qnaDetail", vo);
		return mv;
	}

	@RequestMapping(value = "/qnaInsert")
	public ModelAndView qnainsert() {
		return new ModelAndView("/company/QNA/QNAINS01");
	}

	@RequestMapping(value = "qnaIns")
	public ModelAndView qnaInsert(HttpServletRequest request, HttpSession session, MultipartFile file) throws Exception {
		QnaVO vo = new QnaVO();
		
		String id = (String) session.getAttribute("id");
		UserVO uvo = userService.userInfo(id);
		if (uvo == null) {
			vo.setName(request.getParameter("name"));
			vo.setPass(request.getParameter("pass"));
		}else {
			vo.setName(uvo.getId());
			vo.setPass(uvo.getPw());
		}
		vo.setTitle(request.getParameter("title"));
		vo.setPrivate_key(request.getParameter("private"));
		vo.setContent(request.getParameter("content"));
		if (request.getParameter("file") != null) {
			vo.setFile1(fileUp(request, file));
		} 
		qnaService.qnaInsert(vo);

		return new ModelAndView("redirect:qnaList");
	}

	@RequestMapping(value = "qnacomment")
	public ModelAndView qnacomment(HttpServletRequest request, HttpSession session) throws Exception{
		QnaVO vo = new QnaVO();
		vo.setQna_no(request.getParameter("no"));
		vo.setComment(request.getParameter("comment"));
		qnaService.qnacomment(vo);
		
		return new ModelAndView("redirect:qnaDetail?no="+request.getParameter("no"));
	}
	
	@RequestMapping(value = "qnaEdit")
	public ModelAndView updateQna(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/company/QNA/QNAEDI01");
		QnaVO vo = new QnaVO();
		vo = qnaService.qnaEdit(request.getParameter("no"));
		mv.addObject("vo", vo);
		return mv;
	}
	
	@RequestMapping(value = "qnaUpdate")
	public ModelAndView editQna(HttpServletRequest request, MultipartFile file) throws Exception {			
		QnaVO vo = new QnaVO();		
		vo.setQna_no (request.getParameter("qna_no"));
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		vo.setPrivate_key(request.getParameter("private"));
		if (request.getParameter("file") != null) {
			vo.setFile1(fileUp(request, file));
		}
		qnaService.qnaUpdate(vo);
		return new ModelAndView("redirect:qnaDetail?no="+request.getParameter("qna_no"));
	}

	@RequestMapping(value = "qnaDelete")
	public ModelAndView delete(HttpServletRequest request) throws Exception {
		qnaService.qnaDelete(request.getParameter("no"));
		
		return new ModelAndView("redirect:qnaList");
	}
	
	@RequestMapping(value = "/qnaPass")
	public ModelAndView qnapass(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/company/QNA/QNAPASS");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", request.getParameter("no"));
		map.put("type", request.getParameter("type"));
		String pass = qnaService.password(request.getParameter("no"));
		map.put("pass", pass);
		mv.addObject("map",map);
		return mv;
	}
	
	public String fileUp(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = sdf.format(new Date());
		String saveFileName = today + file.getOriginalFilename();
		String path = request.getSession().getServletContext().getRealPath("");
		File f = new File(path + "file/" + saveFileName);
		file.transferTo(f);
		System.out.println(path);
		return saveFileName;
	}
}