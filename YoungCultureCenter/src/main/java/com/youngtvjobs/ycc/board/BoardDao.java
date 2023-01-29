package com.youngtvjobs.ycc.board;

import java.util.List;

public interface BoardDao {
	
	//CRUD(글쓰기, 읽기, 수정, 삭제)
	void writeInsert(BoardDto boardDto)throws Exception ;
	int delete(Integer article_id) throws Exception;
	void update(BoardDto boardDto) throws Exception;
	BoardDto articleEdit(Integer article_id) throws Exception;
	

	//공지사항 : 검색 결과 개수 
	int nSearchResultCnt(SearchItem sc) throws Exception;
	
	//공지사항 : 검색 결과 페이지 
	List<BoardDto> nSearchSelectPage(SearchItem sc) throws Exception;
	
	//이벤트-행사 : 검색 결과 개수 
	int eSearchResultCnt(SearchItem sc) throws Exception;
	
	//이벤트-행사 : 검색 결과 페이지 
	List<BoardDto> eSearchSelectPage(SearchItem sc) throws Exception;

	//상세보기 
	BoardDto postSelect(Integer article_id) throws Exception;

	//상세보기 : 이전글, 다음글 
	BoardDto movePage(Integer article_id) throws Exception;
	
	//조회수 증가 
	int PlusViewCnt(Integer article_id) throws Exception; 


	


	
}
