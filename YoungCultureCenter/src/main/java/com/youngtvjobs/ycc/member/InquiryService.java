package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.List;

public interface InquiryService {
	
	List<InquiryDto> getPage(String id, SearchByPeriod sp) throws Exception;
	int getPageCnt(String id, SearchByPeriod sp)throws Exception;
	
	List<InquiryDto> getPageByInput(String id, SearchByPeriod sp) throws Exception;
	int getPageByInputCnt(String id, SearchByPeriod sp) throws Exception;
	
	//쓰기, 읽기
	int wirteInq(InquiryDto inquiryDto) throws Exception;
	InquiryDto read(String id, Integer inq_id) throws Exception;
	
	

}
