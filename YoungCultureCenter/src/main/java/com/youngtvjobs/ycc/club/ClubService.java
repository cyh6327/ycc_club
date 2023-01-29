package com.youngtvjobs.ycc.club;

import java.util.List;
import java.util.Map;

public interface ClubService {

	List<ClubDto> getClubList() throws Exception;

	List<ClubDto> getPopularClub() throws Exception;

	List<ClubDto> getMyClub(String user_id) throws Exception;

	int createClub(Map map) throws Exception;

	List<ClubDto> clubSelect(Integer club_id) throws Exception;

	int commentRegist(Map<String, Object> map) throws Exception;

	int postRegist(Map<String, Object> map) throws Exception;

	List<ClubDto> postSelect(Integer club_article_id) throws Exception;

	int updatePost(Map<String, Object> map) throws Exception;

	int deletePost(Integer club_article_id) throws Exception;

}
