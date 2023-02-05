package com.youngtvjobs.ycc.club;

import java.util.List;
import java.util.Map;

public interface ClubService {

	List<ClubDto> getClubList(SearchItem sc) throws Exception;

	List<ClubDto> getMyClub(String user_id) throws Exception;

	int createClub(Map map) throws Exception;

	List<ClubDto> clubSelect(Map<String, Object> map) throws Exception;

	int commentRegist(Map<String, Object> map) throws Exception;

	int postRegist(Map<String, Object> map) throws Exception;

	List<ClubDto> postSelect(Integer club_article_id) throws Exception;

	int updatePost(Map<String, Object> map) throws Exception;

	int deletePost(Integer club_article_id) throws Exception;

	List<ClubDto> selectClubComment(Integer club_article_id) throws Exception;

	int clubTitleCheck(String club_title) throws Exception;

	int joinClub(Map<String, Object> map) throws Exception;

	int deleteMember(Map<String, Object> map) throws Exception;

	List<ClubDto> getPopularClub() throws Exception;
	
}
