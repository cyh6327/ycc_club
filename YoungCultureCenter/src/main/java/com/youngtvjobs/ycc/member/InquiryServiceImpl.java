package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InquiryServiceImpl implements InquiryService{

	@Autowired
	InquiryDao inquiryDao;
	//설정된 기간(버튼) 조회
	@Override
	public List<InquiryDto> getPage(String id, SearchByPeriod sp) throws Exception {

		return inquiryDao.selectPage(id, sp);
	}
	@Override
	public int getPageCnt(String id, SearchByPeriod sp) throws Exception {
		return inquiryDao.selectPageCnt(id, sp);
	}
	//기간 직접입력 조회
	@Override
	public List<InquiryDto> getPageByInput(String id, SearchByPeriod sp) throws Exception {

		return inquiryDao.selectPageByInput(id, sp);
	}
	@Override
	public int getPageByInputCnt(String id, SearchByPeriod sp) throws Exception {
		return inquiryDao.selectPageByInputCnt(id, sp);
	}
	//문의글 쓰기
	@Override
	public int wirteInq(InquiryDto inquiryDto) throws Exception {

		return inquiryDao.insert(inquiryDto);
	}
	//문의글 읽기
	@Override
	public InquiryDto read(String id, Integer inq_id) throws Exception{

		return inquiryDao.select(id, inq_id);
	}





	

}
