package com.youngtvjobs.ycc.rental;

import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LockerController {
	
	@Autowired
	LockerService lockerService;
	
	// 사물함 예약
	@PostMapping("/rental/locker/reservation")
	public String lockerReservation(LockerDto lockerDto, RedirectAttributes rattr, Authentication auth) {
		String user_id = auth.getName();
		lockerDto.setUser_id(user_id);
		
		try {
			// 중복 예약 방지용 유저별 현재 예약 개수
			int rsvCnt = lockerService.getReservationCnt(user_id);
			
			// 예약 개수가 0이 아니면 예약 불가
			if(rsvCnt == 0) {
				// 예약메서드
				lockerService.lockerReservation(lockerDto);
				lockerService.getReservationStat(user_id);
				return "redirect:/rental/locker";
			} else {
				rattr.addFlashAttribute("msg", "NO_DUPLICATE");
				lockerService.getReservationStat(user_id);
				return "redirect:/rental/locker";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "rental/locker";
	}
	
	// 사물함 신청 페이지
	@RequestMapping(value = "/rental/locker")
	public String locker(String user_id, LockerDto lockerDto, Model m, Authentication auth) {
		System.out.println(lockerDto);
		if(auth != null) {
			user_id = auth.getName();
			lockerDto.setUser_id(user_id);
		} else { user_id = null; }
		
		LocalDate nowdate = LocalDate.now();
		m.addAttribute("nowdate", nowdate);
		LocalDate afterMonth = LocalDate.now().plusDays(30);
		m.addAttribute("afterMonth", afterMonth);
		
		try {
			// 사물함 장소 불러오기
			List<LockerDto>locList = lockerService.getLockerLocation();
			m.addAttribute("locList", locList);
			
			// 예약된 사물함 불러오기
			List<LockerDto>rsvList = lockerService.getLockerRsvList(lockerDto);
			m.addAttribute("rsvList", rsvList);
			
			if(lockerDto.getLocker_start_date() != null && lockerDto.getLocker_start_date() != "") {
				LocalDate startDate = LocalDate.parse(lockerDto.getLocker_start_date());
				LocalDate endDate = LocalDate.parse(lockerDto.getLocker_end_date());
				
				int period = (int) startDate.until(endDate, ChronoUnit.DAYS);
				
				m.addAttribute("period", period);
			}
			
			// 나의 예약 현황 불러오기
			List<LockerDto>myRsvList = lockerService.getReservationStat(user_id);
			m.addAttribute("myRsvStat", myRsvList);
			int myRsvCnt = lockerService.getReservationCnt(user_id);
			m.addAttribute("myRsvCnt", myRsvCnt);
			
			Integer[] diffS = new Integer[myRsvList.size()]; // 시작일 - 현재날짜
			Integer[] diffE = new Integer[myRsvList.size()]; // 현재날짜 - 종료일(기준 00시)
			
			for(int i=0; i<myRsvList.size(); i++) {
				LockerDto dto = (LockerDto) myRsvList.toArray()[i];
				LocalDate startDate = LocalDate.parse(dto.getLocker_start_date()); // 대여 시작일
				LocalDate endDate = LocalDate.parse(dto.getLocker_end_date()); // 대여 종료일
				
				diffS[i] = Period.between(nowdate, startDate).getDays(); // 현재날짜 - 시작일 => 음수이면 대여 시작 X 
				diffE[i] = Period.between(nowdate, endDate).getDays(); // 현재날짜 - 종료일 => 음수이면 대여 종료 O
			}
			m.addAttribute("diffS", diffS);
			m.addAttribute("diffE", diffE);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "rental/locker";
	}
	
	// 사물함 안내
	@GetMapping("/rental/locker/info")
	public String lockerInfo() { return "rental/lockerinfo"; }
}
