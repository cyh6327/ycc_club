package com.youngtvjobs.ycc.search;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youngtvjobs.ycc.board.BoardDto;
import com.youngtvjobs.ycc.club.ClubDto;
import com.youngtvjobs.ycc.course.CourseDto;
import com.youngtvjobs.ycc.search.SearchItem;
@Repository
public class SearchDaoImpl implements SearchDao {
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.search.SearchMapper.";
	
	// 테스트용
	@Override
	public int insert(BoardDto boardDto) throws Exception {
		return session.insert(namespace+"insert", boardDto);
	}
	
	// 각각 검색결과 select
	@Override
	public List<BoardDto> selectNoticePage(SearchItem sc) throws Exception {
		return session.selectList(namespace+"selectNoticePage", sc);
	}
	@Override
	public List<BoardDto> selectEventPage(SearchItem sc) throws Exception {
		return session.selectList(namespace+"selectEventPage", sc);
	}
	@Override
	public List<ClubDto> selectClubPage(SearchItem sc) throws Exception {
		return session.selectList(namespace+"selectClubPage", sc);
	}
	@Override
	public List<CourseDto> selectCoursePage(SearchItem sc) throws Exception {
		return session.selectList(namespace+"selectCoursePage", sc);
	}
	
	// 파라미터 type을 받아서 해당되는 분류(공지사항, 이벤트, ...)의 검색결과 카운트
	@Override
	public int searchResultCnt(Map map) throws Exception {
		return session.selectOne(namespace+"searchResultCnt", map);
	}

	// 모든 검색결과 카운트
	@Override
	public int searchAllResultCnt(SearchItem sc) throws Exception {
		return session.selectOne(namespace+"searchAllResultCnt", sc);
	}

	// 게시글 선택 시 가져와야할 데이터 select
	@Override
	public BoardDto select(Integer article_id) throws Exception {
		return session.selectOne(namespace + "select", article_id);
	}

	// 조회수 증가
	@Override
	public int increaseViewCnt(Integer article_id) throws Exception {
		return session.update(namespace+"increaseViewCnt", article_id);
	}

	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) throws Exception {
		return session.selectList(namespace+"autocomplete", paramMap);
	}
	@Override
	public List<Map<String, Object>> autocomplete2(Map<String, Object> paramMap) throws Exception {
		return session.selectList(namespace+"autocomplete2", paramMap);
	}
	@Override
	public List<Map<String, Object>> autocompleteAll(Map<String, Object> paramMap) throws Exception {
		return session.selectList(namespace+"autocompleteAll", paramMap);
	}

}



















