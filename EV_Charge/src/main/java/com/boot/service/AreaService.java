package com.boot.service;

import java.util.ArrayList;

import com.boot.dto.AreaDTO;

public interface AreaService {
	public ArrayList<AreaDTO> select_area_province();

	public ArrayList<AreaDTO> select_area_city(String param);
}