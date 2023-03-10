package com.youngtvjobs.ycc.club;

import java.util.List;
import java.util.Map;

public interface ClubDao {

	List<ClubDto> clubListSelect(SearchItem sc) throws Exception;

	List<ClubDto> myClubSelect(Map<String, Object> map) throws Exception;

	int clubInsert(Map<String, Object> map) throws Exception;

	List<ClubDto> clubSelect(Map<String, Object> map) throws Exception;

	int commentInsert(Map<String, Object> map) throws Exception;

	int postInsert(Map<String, Object> map) throws Exception;

	ClubDto postSelect(Integer club_article_id) throws Exception;

	int updatePost(Map<String, Object> map) throws Exception;

	int deletePost(Integer club_article_id) throws Exception;

	List<ClubDto> selectClubComment(Integer club_article_id) throws Exception;

	int clubTitleCheck(String club_title) throws Exception;

	int insertMember(Map<String, Object> map) throws Exception;

	int deleteMember(Map<String, Object> map) throws Exception;

	List<ClubDto> popularClub() throws Exception;
	
	int increaseClubViewCnt(Integer club_article_id) throws Exception;
}
