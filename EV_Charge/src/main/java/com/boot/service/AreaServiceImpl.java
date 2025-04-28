package com.boot.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.dao.AreaDAO;
import com.boot.dto.AreaDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("AreaService")
public class AreaServiceImpl implements AreaService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<AreaDTO> select_area_province() {
		AreaDAO dao = sqlSession.getMapper(AreaDAO.class);
		ArrayList<AreaDTO> area_province_list = dao.select_area_province();
		return area_province_list;
	}

	@Override
	public ArrayList<AreaDTO> select_area_city(String param) {
		AreaDAO dao = sqlSession.getMapper(AreaDAO.class);
		ArrayList<AreaDTO> area_province_list = dao.select_area_city(param);
		return area_province_list;
	}

}