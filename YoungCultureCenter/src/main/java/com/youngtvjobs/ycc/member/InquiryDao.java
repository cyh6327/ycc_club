package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface InquiryDao {
	//설정된 기간(버튼) 조회
	List<InquiryDto> selectPage(String id, SearchByPeriod sp) throws Exception;
	int selectPageCnt(String id, SearchByPeriod sp) throws Exception;
	
	//기간 직접입력 조회
	List<InquiryDto> selectPageByInput(String id,SearchByPeriod sp) throws Exception;
	int selectPageByInputCnt(String id,SearchByPeriod sp) throws Exception;
	
	int insert(InquiryDto inquiryDto) throws Exception;
	
	InquiryDto select(String id, Integer inq_id) throws Exception;
	


}
