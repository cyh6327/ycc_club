package com.youngtvjobs.ycc.board;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Setter
@Getter
public class BoardDto {

	//inq_board
	private String inq_cate;
	private Integer inq_id;
	private String inq_title;
	private String inq_content;
	private Date inq_date;
	private boolean inq_YN;

	//article
	private Integer article_id ;			// 번호PK
	@JsonFormat(pattern="yyyy-MM-dd")
	private Date  article_date;				// 게시글 등록 날짜
	private String  article_Board_type;		// 게시글 유형
	private String user_id;					// 작성자
	private String  article_title;			// 제목
	private String article_contents;		// 내용
	private int  article_viewcnt;			// 조회수 
	private int preId;						// 이전글 no
	private int nextId;						// 다음글 no
	private String preTitle;				// 이전글 Title
	private String nextTitle;				// 다음글 Title
	private int count;
	
}	