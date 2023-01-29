package com.youngtvjobs.ycc.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardDao boardDao;
	
	//글쓰기
	@Override
	public void writeInsert(BoardDto boardDto) throws Exception {
		boardDao.writeInsert(boardDto);
		
	}
	
	//수정하기 : 데이터 가져오기
	@Override
	public BoardDto getArticleEdit(Integer article_id) throws Exception {
		
		return boardDao.articleEdit(article_id);
	}
	
	//수정하기 : 등록하기 버튼
	@Override
	public void modify(BoardDto boardDto) throws Exception {
		
		boardDao.update(boardDto);
	}
	
	//삭제하기
	@Override
	public int remove(Integer article_id) throws Exception {
		
		return boardDao.delete(article_id);
	}


	//공지사항 : 검색 결과 개수 
	@Override
	public int nSearchResultCnt(SearchItem sc) throws Exception {
		return boardDao.nSearchResultCnt(sc) ;
	}
	//공지사항 : 검색 결과 페이지 
	@Override
	public List<BoardDto> nSearchSelectPage(SearchItem sc) throws Exception {
		return boardDao.nSearchSelectPage(sc);
	}

	//이벤트-행사 : 검색 결과 개수 
	@Override
	public int eSearchResultCnt(SearchItem sc) throws Exception {
		return boardDao.eSearchResultCnt(sc);
	}
	//이벤트-행사 : 검색 결과 페이지
	@Override
	public List<BoardDto> eSearchSelectPage(SearchItem sc) throws Exception {
		return boardDao.eSearchSelectPage(sc);
	}
	//상세보기 
	@Override
	public BoardDto postSelect(Integer article_id) throws Exception {
		//조회수 증가 로직 추가 
		boardDao.PlusViewCnt(article_id);		
		BoardDto boardDto = boardDao.postSelect(article_id);
		
		return boardDto;
	}
	//상세보기 : 이전글, 다음글 
	@Override
	public BoardDto movePage(Integer article_id) throws Exception {
		return boardDao.movePage(article_id);
	}

	
}
