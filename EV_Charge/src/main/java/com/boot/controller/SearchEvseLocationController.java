package com.boot.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.EvseLocationDto;
import com.boot.dto.SearchStationsDto;
import com.boot.service.SearchEvseLocationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class SearchEvseLocationController {

	private final SearchEvseLocationService searchEvseLocationService;

	@GetMapping("/search")
	public String searchNearbyStations(@RequestParam("address") String address,
			@RequestParam("radiusKm") String radiusKm, Model model) {
		SearchStationsDto dto = new SearchStationsDto();
		dto.setAddress(address);
		dto.setRadiusKm(Integer.parseInt(radiusKm));

		List<EvseLocationDto> ELList = searchEvseLocationService.searchNearbyStations(dto);
		model.addAttribute("stationList", ELList);

		log.info("@# ELList =>" + ELList);
		return "search";
	}

}
