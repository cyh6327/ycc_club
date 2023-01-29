package com.youngtvjobs.ycc.board;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private SqlSession session;
	
	private static String namespace = "com.youngtvjobs.ycc.board.boardMapper.";
	//글쓰기
	@Override
	public void writeInsert(BoardDto boardDto) throws Exception {
		session.insert(namespace + "writeInsert", boardDto);
	}
	
	//수정하기 : 데이터 가져오기
	@Override
	public BoardDto articleEdit(Integer article_id) throws Exception {
		
		return session.selectOne(namespace + "articleEdit", article_id);
	}

	//수정하기 : 데이터 등록하기
	@Override
	public void update(BoardDto boardDto) throws Exception {
		 session.update(namespace+"update", boardDto);
	}
	
	//삭제하기
	@Override
	public int delete(Integer article_id) throws Exception {
		
		return session.delete(namespace+"delete", article_id);
	}

	//공지사항 : 검색 결과 개수 
	@Override
	public int nSearchResultCnt(SearchItem sc) throws Exception {
		return session.selectOne(namespace + "nSearchResultCnt", sc);
	}
	//공지사항 : 검색 결과 페이지 
	@Override
	public List<BoardDto> nSearchSelectPage(SearchItem sc) throws Exception {
		return session.selectList(namespace + "nSearchSelectPage" , sc);
	}

	//이벤트-행사 : 검색 결과 개수 
	@Override
	public int eSearchResultCnt(SearchItem sc) throws Exception {
		return session.selectOne(namespace + "eSearchResultCnt", sc);
	}
	//이벤트-행사 : 검색 결과 페이지 
	@Override
	public List<BoardDto> eSearchSelectPage(SearchItem sc) throws Exception {
		return session.selectList(namespace + "eSearchSelectPage", sc);
	}
	//상세보기 
	@Override
	public BoardDto postSelect(Integer article_id) throws Exception {
		return session.selectOne(namespace + "postSelect", article_id );
	}
	//상세보기 : 이전글, 다음글 
	@Override
	public BoardDto movePage(Integer article_id) throws Exception {
		return session.selectOne(namespace + "movePage", article_id);
	}
	//조회수증가
	@Override
	public int PlusViewCnt(Integer article_id) throws Exception {
		return session.update(namespace + "PlusViewCnt" , article_id);
	}
	
	
	
}
