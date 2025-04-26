package com.boot.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;

	// main.jsp
	@RequestMapping("/main")
	public String main() {
		log.info("main");
		return "main";
	}

	// regist.jsp
	@RequestMapping("/registe")
	public String registe() {
		log.info("registe");
		return "registe";
	}

	// login.jsp
	@RequestMapping("/login")
	public String login() {
		log.info("login");
		return "login";
	}

	// 회원가입
	@RequestMapping("/registe_user")
	public String registe_user(@RequestParam HashMap<String, String> param) {
		log.info("@# registe_user()");

		memberService.registUser(param);

		return "main";
	}

	// 아이디 중복체크
	@RequestMapping("/user_id_check")
	@ResponseBody
	public String userIdCheck(@RequestParam("user_id") String id) {
		int count = memberService.user_id_check(id);
		if (count == 0) {
			return "ok";
		} else {
			return "fail";
		}
	}

}