package com.boot.dao;

import java.util.ArrayList;

import com.boot.dto.AreaDTO;

public interface AreaDAO {
	public ArrayList<AreaDTO> select_area_province();

	public ArrayList<AreaDTO> select_area_city(String param);

}