package com.youngtvjobs.ycc.search;

import java.util.List;
import java.util.Map;

import com.youngtvjobs.ycc.board.BoardDto;
import com.youngtvjobs.ycc.club.ClubDto;
import com.youngtvjobs.ycc.course.CourseDto;

public interface SearchDao {
	
	// 테스트용
	int insert(BoardDto boardDto) throws Exception;
	
	// 각각 검색결과 select
	List<BoardDto> selectNoticePage(SearchItem sc) throws Exception;
	List<BoardDto> selectEventPage(SearchItem sc) throws Exception;
	List<ClubDto> selectClubPage(SearchItem sc) throws Exception;
	List<CourseDto> selectCoursePage(SearchItem sc) throws Exception;
	
	// 파라미터 type을 받아서 해당되는 분류(공지사항, 이벤트, ...)의 검색결과 카운트
	int searchResultCnt(Map map) throws Exception;
	
	// 모든 검색결과 카운트
	int searchAllResultCnt(SearchItem sc) throws Exception;
	
	// 게시글 선택 시 가져와야할 데이터 select
	BoardDto select(Integer article_id) throws Exception;
	// 조회수 증가
	int increaseViewCnt(Integer article_id) throws Exception;

	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) throws Exception;
	List<Map<String, Object>> autocomplete2(Map<String, Object> paramMap) throws Exception;

	List<Map<String, Object>> autocompleteAll(Map<String, Object> paramMap) throws Exception;
	
	
}
