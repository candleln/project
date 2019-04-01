package com.projecthh.company.user.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.projecthh.common.AuthKeyCreator;
import com.projecthh.common.MailUtils;
import com.projecthh.company.notice.vo.NoticeVO;
import com.projecthh.company.qna.vo.QnaVO;
import com.projecthh.company.user.service.UserService;
import com.projecthh.company.user.vo.UserVO;

@Controller
public class UserController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "userService")
	private UserService userService;

	//메인
	@RequestMapping(value = "/")
	public ModelAndView main() throws Exception {
		ModelAndView mv = new ModelAndView("/company/MAIN/main");
		ArrayList<NoticeVO> nvo = userService.notice();
		ArrayList<QnaVO> qvo = userService.qna();
		mv.addObject("notice", nvo);
		mv.addObject("qna", qvo);
		return mv;
	}
	
	@RequestMapping(value = "ulogin")
	public ModelAndView userLogin(HttpServletRequest request, UserVO vo, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/company/USER/USELOG01");
		//로그인 상태로 로그인 페이지
		session = request.getSession();
		if (session.getAttribute("id") != null || session.getAttribute("user_type") != null) {
			return new ModelAndView("redirect:/");
		}

		if (request.getParameter("id") != null) {
			vo.setId(request.getParameter("id"));
			vo.setPw(request.getParameter("pw"));
			
			vo = userService.login(vo);
			if (vo != null) {
				String userid = vo.getId();
				//관리자
				if (vo.getGrant().equals("1")) {
					session.setAttribute("manager", "manager");
				//개인
				} else if (request.getParameter("user_type").equals("P")) {
					session.setAttribute("user_type", "P");
				//비회원
				} else if (request.getParameter("user_type").equals("G")) {
					session.setAttribute("user_type", "G");
				}
				session.setAttribute("id", userid);
				//이메일 미인증
				if (vo.getState().equals("N")) {
					String id = vo.getId();
					return new ModelAndView("redirect:signInConfirm?userid=" + id + "");
				}
				return new ModelAndView("redirect:/");
			} else {
				return new ModelAndView("redirect:ulogin");								
			}
		} 
		return mv;
	}

	@RequestMapping(value = "userSignIn")
	public String userSignIn() throws Exception {
		return "/company/USER/USESIG01";
	}
	
	//아이디중복체크
	@ResponseBody
	@RequestMapping(value = "/idCheck")
	public Map<String, Object> checkID(@RequestParam("id") String id, Map<String, Object> map) throws Exception {
		int idCheck = 0;
		idCheck = userService.checkID(id);
		map.put("idCheck", idCheck);
		return map;
	}
	
	@RequestMapping(value = "/signInAction")
	public String insertUser(Model model, UserVO vo, HttpServletRequest request) throws Exception {
		String authKey = new AuthKeyCreator().getKey(20); //인증키 생성
		vo.setId(request.getParameter("id"));
		vo.setName(request.getParameter("name"));
		vo.setPw(request.getParameter("pw"));
		vo.setAddress(request.getParameter("address"));
		vo.setTel(request.getParameter("tel"));
		vo.setAuthKey(authKey);
		userService.insertUser(vo);

		model.addAttribute("id", vo.getId());

		sendMail(vo.getId(), authKey);
		return "redirect:/signInConfirm";
	}
	
	//인증
	@RequestMapping(value = "/signInConfirm")
	public String confirmSignIn(Model model, HttpServletRequest request, Map<String, Object> map) throws Exception {
		String authKey = request.getParameter("authKey");
		String id = request.getParameter("id");
		map.put("authKey", authKey);
		map.put("id", id);
		
		//인증키 만료 확인
		model.addAttribute("checkExpr", userService.selectUser(map));

		userService.updateUserState(map);
		model.addAttribute("user", map);
		return "/company/USER/USESIG02";
	}
	
	//재인증
	@RequestMapping(value = "/reSignInConfirm")
	public String confirmSignIn(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String newAuthKey = new AuthKeyCreator().getKey(20);

		map.put("id", id);
		map.put("newAuthKey", newAuthKey);

		userService.updateAuthKey(map);

		sendMail(id, newAuthKey);
		return "redirect:/signInConfirm";
	}

	//인증메일 발송
	@Autowired
	private JavaMailSender mailSender;

	public MailUtils sendMail(String id, String authKey) throws Exception {
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("HH 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>이메일 인증</h1>").append("<p>링크를 클릭하면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='http://localhost:8080/signInConfirm?id=" + id + "&authKey=" + authKey)
				.append("'target='_blenk'>이메일 인증 확인</a>").toString());
		sendMail.setFrom("hellhoundstest@gmail.com", "HH");
		sendMail.setTo(id);
		sendMail.send();
		return sendMail;
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest request) throws Exception {
		session = request.getSession();
		if (session.getAttribute("user_type") != null) {
			session.removeAttribute("user_type");
		}
		if (session.getAttribute("id") != null) {
			session.removeAttribute("id");
		}
		if (session.getAttribute("manager") != null) {
			session.removeAttribute("manager");
		}
		return new ModelAndView("redirect:/");
	}

	@RequestMapping(value = "userInfo")
	public ModelAndView qnaDetail(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("/company/USER/USEINF01");
		String no = request.getParameter("no");
		UserVO vo = userService.userInfo(no);
		mv.addObject("vo", vo);

		return mv;
	}

	@RequestMapping(value = "infedit")
	public ModelAndView qnaedit(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/company/USER/INFEDI01");
		UserVO vo = new UserVO();
		String no = request.getParameter("no");
		vo = userService.userInfo(no);

		mv.addObject("vo", vo);
		return mv;
	}

	@RequestMapping(value = "infupdate")
	public ModelAndView qnaEdit(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF-8");
		UserVO vo = new UserVO();

		vo.setUser_no(Integer.parseInt(request.getParameter("user_no")));
		vo.setName(request.getParameter("name"));
		vo.setAddress(request.getParameter("addr"));
		vo.setTel(request.getParameter("tel"));

		userService.infoupdate(vo);
		return new ModelAndView("redirect:/");
	}

	@RequestMapping(value = "userfind")
	public String find() {
		return "/company/USER/USEFIN01";
	}
}