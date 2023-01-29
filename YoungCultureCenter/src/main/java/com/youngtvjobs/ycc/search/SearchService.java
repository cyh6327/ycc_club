package com.youngtvjobs.ycc.search;

import java.util.List;
import java.util.Map;

import com.youngtvjobs.ycc.board.BoardDto;
import com.youngtvjobs.ycc.club.ClubDto;
import com.youngtvjobs.ycc.course.CourseDto;
public interface SearchService {
	
	
	// 각각 검색결과 select
	List<BoardDto> getNoticePage(SearchItem sc) throws Exception;
	List<BoardDto> getEventPage(SearchItem sc) throws Exception;
	List<ClubDto> getClubPage(SearchItem sc) throws Exception;
	List<CourseDto> getCoursePage(SearchItem sc) throws Exception;
	
	// 파라미터 type을 받아서 해당되는 분류(공지사항, 이벤트, ...)의 검색결과 카운트
	int getSearchResultCnt(Map map) throws Exception;
	
	// 모든 검색결과 카운트
	int getSearchAllResultCnt(SearchItem sc) throws Exception;
	
	// 조회수 증가
	BoardDto read(Integer article_id) throws Exception;
	
	
	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) throws Exception;
	List<Map<String, Object>> autocomplete2(Map<String, Object> paramMap) throws Exception;
	List<Map<String, Object>> autocompleteAll(Map<String, Object> paramMap) throws Exception;

}
