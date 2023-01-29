/*
 * 작성자 : alwaysFinn(김지호)
 * 최초 작성일 : '22. 12. 02
 * 마지막 업데이트 : '23.01.05
 * 업데이트 내용 : code clean up
 * 기능 : 독서실 현재 예약된 내역 불러오기 및 예약하기 + 유효성 검사하는 파일로 mapper와 연결되어 있음
 */

package com.youngtvjobs.ycc.rental;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StudyroomDaoImpl implements StudyroomDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.rental.studyroomMapper.";

	@Override	//좌석 예약 현황 select from DB
	public List<StudyroomDto> sroomSelect() throws Exception {
		return session.selectList(namespace + "studyroomRentalChk");
	}

	@Override	//좌석 예약 insert from DB
	public int insertStudyroomrental(StudyroomDto studyroomDto) throws Exception {
		return session.insert(namespace + "insertRentalInfo", studyroomDto);
	}

	@Override	//유효성 체크 #1 예약한 user인지 체크 select from DB
	public int chkRental(StudyroomDto studyroomDto) throws Exception{
		return session.selectOne(namespace + "rentalChk", studyroomDto);
	}
	

}
