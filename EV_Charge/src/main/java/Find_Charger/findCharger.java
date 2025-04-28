package Find_Charger;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class findCharger {
	public static void main(String[] args) {
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder parser = dbf.newDocumentBuilder();
			Document xmlDoc = parser.parse(
					"https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?serviceKey=ha6Vs0w2TW5hmQMnGjVefZDfIMjkFiXLXhNYfw0kPcJd470rlZfa95pVgwgLfQYMXmMVe0%2BjwHptLmAGdhXaCw%3D%3D&dataType=XML&numOfRows=0");

			Element root = xmlDoc.getDocumentElement();
			NodeList itemList = root.getElementsByTagName("item");

			System.out.println("var positions = [];");
			StringBuffer strbuf = new StringBuffer();

			for (int i = 0; i < itemList.getLength(); i++) {
				Element itemElement = (Element) itemList.item(i);

				String title = getTagValue("statNm", itemElement);
				String lat = getTagValue("lat", itemElement);
				String lng = getTagValue("lng", itemElement);

				if (title != null && lat != null && lng != null) {
					String str1 = "positions.push({";
					String str2 = "    title: '" + title + "',";
					String str3 = "    latlng: new kakao.maps.LatLng(" + lat + ", " + lng + ")";
					String str4 = "});";

					strbuf.append(str1 + str2 + str3 + str4);

				}
			}
			System.out.println(strbuf);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String getTagValue(String tag, Element element) {
		NodeList nodeList = element.getElementsByTagName(tag);
		if (nodeList.getLength() > 0) {
			Node node = nodeList.item(0);
			if (node != null && node.getFirstChild() != null) {
				return node.getFirstChild().getNodeValue();
			}
		}
		return null;
	}
}