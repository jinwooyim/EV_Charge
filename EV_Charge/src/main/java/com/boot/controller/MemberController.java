package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.dto.AreaDTO;
import com.boot.service.AreaService;
import com.boot.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private AreaService ereaService;

	// main.jsp
	@RequestMapping("/main")
	public String main() {
		log.info("main");
		return "main";
	}

	// regist.jsp
	@RequestMapping("/registe")
	public String registe(Model model) {
		log.info("registe");

		ArrayList<AreaDTO> erea_province_list = ereaService.select_area_province();
		model.addAttribute("erea_province_list", erea_province_list);

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
	public String user_id_check(@RequestParam("user_id") String id) {
		int count = memberService.user_id_check(id);
		if (count == 0) {
			return "ok";
		} else {
			return "fail";
		}
	}

	// '시'
	@RequestMapping("/province_of_city")
	@ResponseBody
	public ArrayList<AreaDTO> province_of_city(@RequestParam("user_province") String param) {
		log.info("province_of_city");
		log.info("@# param =>" + param);
		ArrayList<AreaDTO> cites = ereaService.select_area_city(param);
		log.info("" + cites);

		return cites;
	}

}