package com.boot.controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.boot.dto.MemberDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class FindLocationController {

	@Value("${kakao.api.key}") // API Key를 application.properties에서 주입
	private String kakaoApiKey;

	@PostMapping("/updateMapCoordinates")
	public String updateMapCoordinates(@RequestBody MemberDTO address) {
		String[] coordinates = new String[2]; // [0] -> latitude, [1] -> longitude

		try {
			String addressString = buildAddress(address, true);
			JSONArray documents = getJSONResponse(addressString);

			if (documents == null || documents.length() == 0) {
				// 읍/면/동이 없는 주소로 fallback
				addressString = buildAddress(address, false);
				documents = getJSONResponse(addressString);
			}

			if (documents != null && documents.length() > 0) {
				JSONObject firstDocument = documents.getJSONObject(0);
				coordinates[0] = firstDocument.getString("y"); // 위도
				coordinates[1] = firstDocument.getString("x"); // 경도
			} else {
				return new JSONObject().put("error", "주소에 대한 좌표를 찾을 수 없습니다.").toString();
			}

		} catch (JSONException e) {
			e.printStackTrace();
			return new JSONObject().put("error", "응답에서 JSON 파싱 중 오류가 발생했습니다.").toString();
		} catch (Exception e) {
			e.printStackTrace();
			return new JSONObject().put("error", "알 수 없는 오류가 발생했습니다.").toString();
		}

		// 성공적으로 위도와 경도를 반환
		return new JSONObject().put("latitude", coordinates[0]).put("longitude", coordinates[1]).toString();
	}

	// kakao API를 이용해서 주소값을 위도와 경도를 가진 JSON 배열로 반환하는 메소드
	public JSONArray getJSONResponse(String addressString) {
		try {
			String encodedAddress = java.net.URLEncoder.encode(addressString, "UTF-8");

			String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json?query=" + encodedAddress;

			// API 요청
			URL url = new URL(apiUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Authorization", "KakaoAK " + kakaoApiKey); // Kakao API Key

			// 응답 받기
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// JSON 응답 파싱
			JSONObject jsonResponse = new JSONObject(response.toString());
			JSONArray documents = jsonResponse.getJSONArray("documents");

			return documents;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	// 읍면동 주소값이 있는지 없는지 판별하는 메소드
	private String buildAddress(MemberDTO address, boolean includeEmd) {
		String addr = address.getArea_ctpy_nm() + " " + address.getArea_sgg_nm();
		if (includeEmd && address.getArea_emd_nm() != null && !address.getArea_emd_nm().isEmpty()) {
			addr += " " + address.getArea_emd_nm();
		}
		return addr;
	}

	// 센터점 주변 충전소 찾기
	@RequestMapping("/findStationsNear")
	@ResponseBody
	public List<Map<String, Object>> findStationsNear(@RequestParam String area_ctpy_nm,
			@RequestParam String area_sgg_nm) {

		log.info("@# area_ctpy_nm =>" + area_ctpy_nm);
		log.info("@# area_sgg_nm =>" + area_sgg_nm);

		// 저장된 파일 읽어서 결과 찾기
		List<Map<String, Object>> station_list = new ArrayList<>();

		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder parser = dbf.newDocumentBuilder();

			Document xmlDoc = null; // 참조 변수
			String url = "C:\\Users\\user\\test.xml";
			xmlDoc = parser.parse(url);

			Element root = xmlDoc.getDocumentElement();

//	         Node item_node = root.getElementsByTagName("item").item(0);

			int length = root.getElementsByTagName("item").getLength();

			NodeList itemList = root.getElementsByTagName("item");

			for (int i = 0; i < length; i++) {
				Node itemNode = itemList.item(i);

				if (itemNode.getNodeType() == Node.ELEMENT_NODE) {
					Element itemElement = (Element) itemNode;
					Node stat_node = itemElement.getElementsByTagName("stat").item(0);
					Node statId_node = itemElement.getElementsByTagName("statId").item(0);

					if (stat_node != null) {
						String stat = stat_node.getTextContent();
						String statId = statId_node.getTextContent();
						Map<String, Object> stat_map = new HashMap<>();
						stat_map.put(statId, stat);

						station_list.add(stat_map);
					}
				}
			}
			log.info(station_list + "");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return station_list;
	}

	@RequestMapping("/update")
	public void dataUpdate() {
		// 파일 저장
		try {
			String urlString = "https://apis.data.go.kr/B552584/EvCharger/getChargerStatus?serviceKey=ha6Vs0w2TW5hmQMnGjVefZDfIMjkFiXLXhNYfw0kPcJd470rlZfa95pVgwgLfQYMXmMVe0%2BjwHptLmAGdhXaCw%3D%3D&pageNo=1&numOfRows=10&period=5&zcode=11";
			URL url = new URL(urlString);

			InputStream inputStream = url.openStream();
			String savePath = "C:\\Users\\user\\test.xml"; // 예: "C:/data/page1.xml"
			Files.copy(inputStream, Paths.get(savePath));
			inputStream.close();

			System.out.println("파일 저장 완료: " + savePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}