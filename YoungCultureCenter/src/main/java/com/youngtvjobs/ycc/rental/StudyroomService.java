/*
 * 작성자 : alwaysFinn(김지호)
 * 최초 작성일 : '22. 12. 02
 * 마지막 업데이트 : '23.01.05
 * 업데이트 내용 : code clean up
 * 기능 : 독서실 현재 예약된 내역 불러오기 및 예약하기 + 유효성 검사 하는 service 파일 
 */

package com.youngtvjobs.ycc.rental;

import java.util.List;


public interface StudyroomService {
	
	List<StudyroomDto> showRentaled() throws Exception;	//현재 예약된 목록 가져오는 select
	int sroomInsert(StudyroomDto studyroomDto) throws Exception; //예약 하는 insert
	int validationChkRentaled(StudyroomDto studyroomDto) throws Exception; //유효성 체크 #1 예약한 user인지 체크
	
	
}
