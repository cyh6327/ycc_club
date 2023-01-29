/*
 * 작성자 : alwaysFinn(김지호)
 * 최초 작성일 : '22. 12. 02
 * 마지막 업데이트 : '23.01.05
 * 업데이트 내용 : code clean up
 * 기능 : 독서실 현재 예약된 내역 불러오기 및 예약하기 + 유효성 검사 하는 파일로 dao와 연결되어있음
 */

package com.youngtvjobs.ycc.rental;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudyroomServiceImpl implements StudyroomService{
	
	@Autowired
	StudyroomDao studyroomDao;

	@Override	//좌석 예약 현황 select
	public List<StudyroomDto> showRentaled() throws Exception {
		return studyroomDao.sroomSelect();
	}

	@Override	//좌석 예약 insert
	public int sroomInsert(StudyroomDto studyroomDto) throws Exception {
		return studyroomDao.insertStudyroomrental(studyroomDto);
	}

	@Override	//유효성 체크 #1 예약한 user인지 체크
	public int validationChkRentaled(StudyroomDto studyroomDto) throws Exception {
		return studyroomDao.chkRental(studyroomDto);
	}
	
	
}
	