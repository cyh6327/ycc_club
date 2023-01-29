package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class InquiryDaoImpl implements InquiryDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace= "com.youngtvjobs.ycc.member.inquiryMapper.";
	
	
	//설정된 기간(버튼) 조회
		@Override
		public List<InquiryDto> selectPage(String id, SearchByPeriod sp) throws Exception {
				Map map = new HashMap();
				map.put("id", id);
				map.put("settedInterval", sp.getSettedInterval());
				map.put("pageSize", sp.getPageSize());
				map.put("offset",sp.getOffset());
			return session.selectList(namespace+"selectPage" ,map);	
		}
		@Override
		public int selectPageCnt(String id, SearchByPeriod sp) throws Exception {
			Map map = new HashMap();
			map.put("id", id);
			map.put("settedInterval", sp.getSettedInterval());
			
			return session.selectOne(namespace+"selectPageCnt", map);
		}
	
	//기간 직접입력 조회
	@Override
	public List<InquiryDto> selectPageByInput(String id, SearchByPeriod sp) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		map.put("startDate", sp.getStartDate());
		map.put("endDate", sp.getEndDate());
		map.put("pageSize", sp.getPageSize());
		map.put("offset",sp.getOffset());
		return session.selectList(namespace+"selectPageByInput", map);
	}

	@Override
	public int selectPageByInputCnt(String id, SearchByPeriod sp) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		map.put("startDate", sp.getStartDate());
		map.put("endDate", sp.getEndDate());
		return session.selectOne(namespace +"selectPageByInputCnt", map);
	}
	
	//문의글 작성
	@Override
	public int insert(InquiryDto inquiryDto) throws Exception {

		return session.insert(namespace+"insert", inquiryDto);
	}

	@Override
	public InquiryDto select(String id, Integer inq_id) throws Exception{
		Map map = new HashMap();
		map.put("id", id);
		map.put("inq_id", inq_id);
		return session.selectOne(namespace+"select" , map);
	}





}
