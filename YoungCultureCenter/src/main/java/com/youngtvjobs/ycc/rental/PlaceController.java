package com.youngtvjobs.ycc.rental;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PlaceController {

	@Autowired
	PlaceService placeService;

		@GetMapping("/rental/place")
		// Dto에서 장소들 이름 받아와 selectBox에 출력해주는 메서드
		public String placeRental(Model m, PlaceDto placeDto, Authentication auth) {
			try {
				// 대관 장소 (classroom) 리스트 출력
				List<PlaceDto> placelist = placeService.selectRentalPlace();
				m.addAttribute("placelist", placelist);
				System.out.println("placelist = " + placelist);
				
				String user_id = auth.getName();
				m.addAttribute("user_id", user_id);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "rental/place";
		}
		
		// 장소 선택시 classroom 데이터를 받아와서 해당 장소와 동일한 날짜의 예약정보를 모아놓은 새 배열 생성
		@ResponseBody
		@GetMapping("/rental/place/select")
		public Map<String, Object> rentalPlaceSelect(PlaceDto placeDto, @RequestParam("croom_id") String croom_id) throws Exception {
			
			List<PlaceDto> placeList = placeService.selectPlace(croom_id);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("placeList", placeList);
			
			return map;
		}
		
		// 예약 정보 insert해주는 메서드
		@PostMapping("/rental/place/do")
		public String rentalInfoInsert(PlaceDto placeDto, 
				@RequestParam("date") String date, @RequestParam("croom_id") String croom_id, 
				@RequestParam("timeList") String timeList, Authentication auth) throws Exception {

			String user_id = auth.getName();
			placeDto.setUser_id(user_id);
			System.out.println(user_id);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date prental_de = sdf.parse(date);
			placeDto.setPrental_de(prental_de);
			
			// timeList를 string 타입으로 받아오기 때문에 timeList의 time1, tim2, ... 값을 꺼낼 수 없음 
			// ==> string을 object로 변환하기 위해 json object로 파싱
			JSONParser parser = new JSONParser();
			Object timeListObj = parser.parse(timeList);
			JSONObject jsonObj = (JSONObject) timeListObj;
			  
			boolean time1 = Boolean.parseBoolean((String)jsonObj.get("time1"));
			boolean time2 = Boolean.parseBoolean((String)jsonObj.get("time2"));
			boolean time3 = Boolean.parseBoolean((String)jsonObj.get("time3"));
			boolean time4 = Boolean.parseBoolean((String)jsonObj.get("time4"));
			boolean time5 = Boolean.parseBoolean((String)jsonObj.get("time5"));
			boolean time6 = Boolean.parseBoolean((String)jsonObj.get("time6"));
			
			placeDto.setTime1(time1);
			placeDto.setTime2(time2);
			placeDto.setTime3(time3);
			placeDto.setTime4(time4);
			placeDto.setTime5(time5);
			placeDto.setTime6(time6);

			placeService.insertInfo(placeDto);
		
			return null;
		}
		
		@ResponseBody
		@GetMapping("/rental/place/send")
		// 장소, 날짜 선택 후 조회하기 눌렀을 때 prental_info 데이터를 불러와서 선택한 장소, 날짜의 예약 가능한 시간대만 출력해주는 메서드
		public Map<String, Object> rentalSelect(Model m, @RequestParam(value = "croom_id", required = false) String croom_id, 
				@RequestParam(value = "date", required = false) String date, HttpServletRequest req, HttpServletResponse response, 
				PlaceDto placeDto) throws Exception {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date prental_de = sdf.parse(date);
			
			List<PlaceDto> infoList = placeService.selectInfo(croom_id, prental_de);
			m.addAttribute("infoList", infoList);
			m.addAttribute("croom_id", croom_id);
			map.put("infoList", infoList);
			map.put("croom_id", croom_id);
			map.put("date", date);
			
			System.out.println("croom_id = " + croom_id);
			System.out.println("date = " + date);
			System.out.println("prental_de = " + prental_de);
			return map;
		}

}