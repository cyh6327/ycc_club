/*
 * 작성자 : alwaysFinn(김지호)
 * 최초 작성일 : '22. 12. 02
 * 마지막 업데이트 : '23.01.05
 * 업데이트 내용 : code clean up
 * 기능 : 독서실 현재 예약된 내역 불러오기 및 예약하기 + 유효성 검사 
 */

package com.youngtvjobs.ycc.rental;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class StudyroomController {

	@Autowired
	StudyroomService studyroomService;

	// 독서실 페이지 이동 시 현재 조건(날짜)에 부합되는 내역들만 받아옴
	@GetMapping("/rental/studyroom")
	public String studyRoom(Model m) throws Exception {
		try {
			List<StudyroomDto> list = studyroomService.showRentaled();
			m.addAttribute("list", list);	//list라는 이름으로 예약내역 controller로 보냄
			System.out.println(list); //예약된 내역 제대로 불러와 지는지 확인용
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "rental/studyRoom";
	}

	// 독서실 페이지에서 넘어오는 값들 db로 insert 후 결제 진행 페이지로 넘겨줌
	@PostMapping("/rental/studyroom")
	public String studyRoom(String sroom_rental_etime,
			Integer sroom_seat_id, Authentication auth) throws Exception {

		try {
			System.out.println("종료 시간 : " + sroom_rental_etime);	//값 제대로 넘어오는지 확인용
			System.out.println("좌석 no : " + sroom_seat_id);	//값 제대로 넘어오는지 확인용
			StudyroomDto studyroomDto = new StudyroomDto();	//DTO에 담아서 보내기 위해 새로 선언
			String user_id = auth.getName();	//user_id는 로그인한 사람의 id를 가져옴

			studyroomDto.setSroom_seat_id(sroom_seat_id);	//보낼값 dto에 저장(좌석번호)
			studyroomDto.setUser_id(user_id);

			  /* 날짜 포맷이 넘어올때는 string형식이므로 db에 제대로 넣어주기 위해서는 형식을 바꿔줘야 함 따라서 포맷 변경해주는 부분 */
			  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS"); 
			  Date date_sroom_rental_etime = sdf.parse(sroom_rental_etime);
			  studyroomDto.setSroom_rental_etime(date_sroom_rental_etime);

			  //유효성체크 - #1 이미 예약한 사람인지 확인하는 유효성체크
			  if(studyroomService.validationChkRentaled(studyroomDto) == 1) {
				  return "redirect:/error/403";
			  }else {
				  		//유효성체크 - #2 insert가 제대로 됐는지 확인하는 유효성체크
				  if (studyroomService.sroomInsert(studyroomDto) != 1) {
						throw new Exception("예약오류");
					  } else {
						System.out.println("예약 성공");
					  }
			  }

			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("예약 실패");
		}

		return "/course/courseRegComplete";
	}

}
