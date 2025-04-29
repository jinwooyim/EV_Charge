package com.boot.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.MemberDAO;
import com.boot.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("MemberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void registUser(HashMap<String, String> param) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		dao.registUser(param);
	}

	@Override
	public int login(String id, String pw) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		dao.login(id, pw);
		return 0;
	}

	@Override
	public int user_id_check(String id) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		int count = dao.user_id_check(id);

		return count;
	}

	@Override
	public MemberDTO select_area(String id) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		MemberDTO dto = dao.select_area(id);
		return dto;
	}
}