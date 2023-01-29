package com.youngtvjobs.ycc.search;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youngtvjobs.ycc.board.BoardDto;
import com.youngtvjobs.ycc.club.ClubDto;
import com.youngtvjobs.ycc.course.CourseDto;

@Service
public class SearchServiceImpl implements SearchService{
	
	@Autowired
	SearchDao searchDao;
	
	// 각각 검색결과 select
	@Override
	public List<BoardDto> getNoticePage(SearchItem sc) throws Exception {
		return searchDao.selectNoticePage(sc);
	}
	@Override
	public List<BoardDto> getEventPage(SearchItem sc) throws Exception {
		return searchDao.selectEventPage(sc);
	}
	@Override
	public List<ClubDto> getClubPage(SearchItem sc) throws Exception {
		return searchDao.selectClubPage(sc);
	}
	@Override
	public List<CourseDto> getCoursePage(SearchItem sc) throws Exception {
		return searchDao.selectCoursePage(sc);
	}
	
	// 파라미터 type을 받아서 해당되는 분류(공지사항, 이벤트, ...)의 검색결과 카운트
	@Override
	public int getSearchResultCnt(Map map) throws Exception {
		return searchDao.searchResultCnt(map);
	}
	
	// 모든 검색결과 카운트
	@Override
	public int getSearchAllResultCnt(SearchItem sc) throws Exception {
		return searchDao.searchAllResultCnt(sc);
	}

	// 조회수 증가
	@Override
	public BoardDto read(Integer article_id) throws Exception {
		// 게시글 선택시 가져와야할 데이터 select 
		BoardDto boardDto = searchDao.select(article_id);
		// 조회수 증가
		searchDao.increaseViewCnt(article_id);
		
		return boardDto;
	}
	
	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) throws Exception {
		return searchDao.autocomplete(paramMap);
	}
	@Override
	public List<Map<String, Object>> autocomplete2(Map<String, Object> paramMap) throws Exception {
		return searchDao.autocomplete2(paramMap);
	}
	@Override
	public List<Map<String, Object>> autocompleteAll(Map<String, Object> paramMap) throws Exception {
		return searchDao.autocompleteAll(paramMap);
	}

}
