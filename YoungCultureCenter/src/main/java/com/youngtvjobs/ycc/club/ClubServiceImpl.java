package com.youngtvjobs.ycc.club;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ClubServiceImpl implements ClubService {
	
	@Autowired
	ClubDao clubDao;

	@Override
	public List<ClubDto> getClubList(SearchItem sc) throws Exception {
		return clubDao.clubListSelect(sc);
	}

	@Override
	public List<ClubDto> getMyClub(String user_id) throws Exception {
		return clubDao.myClubSelect(user_id);
	}

	@Override
	public int createClub(Map map) throws Exception {
		
		log.info("(service)createClub.......");
    	
		return clubDao.clubInsert(map);
	}

	@Override
	public List<ClubDto> clubSelect(Map<String, Object> map) throws Exception {
		return clubDao.clubSelect(map);
	}

	@Override
	public int commentRegist(Map<String, Object> map) throws Exception {
		return clubDao.commentInsert(map);
	}

	@Override
	public int postRegist(Map<String, Object> map) throws Exception {
		return clubDao.postInsert(map);
	}

	@Override
	public List<ClubDto> postSelect(Integer club_article_id) throws Exception {
		return clubDao.postSelect(club_article_id);
	}

	@Override
	public int updatePost(Map<String, Object> map) throws Exception {
		return clubDao.updatePost(map);
	}

	@Override
	public int deletePost(Integer club_article_id) throws Exception {
		return clubDao.deletePost(club_article_id);
	}

	@Override
	public List<ClubDto> selectClubComment(Integer club_article_id) throws Exception {
		return clubDao.selectClubComment(club_article_id);
	}

	@Override
	public int clubTitleCheck(String club_title) throws Exception {
		return clubDao.clubTitleCheck(club_title);
	}

	@Override
	public int joinClub(Map<String, Object> map) throws Exception {
		return clubDao.insertMember(map);
	}

	@Override
	public int deleteMember(Map<String, Object> map) throws Exception {
		return clubDao.deleteMember(map);
	}

	@Override
	public List<ClubDto> getPopularClub() throws Exception {
		return clubDao.popularClub();
	}

}
