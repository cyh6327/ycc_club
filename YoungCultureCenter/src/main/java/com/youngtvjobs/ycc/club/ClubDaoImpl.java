package com.youngtvjobs.ycc.club;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ClubDaoImpl implements ClubDao{

	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.club.clubMapper.";
	
	@Override
	public List<ClubDto> clubListSelect() throws Exception {
		return session.selectList(namespace+"clubListSelect");
	}
	
	@Override
	public List<ClubDto> popularClub() throws Exception {
		return session.selectList(namespace+"popularClub");
	}

	@Override
	public List<ClubDto> myClubSelect(String user_id) throws Exception {
		return session.selectList(namespace+"myClubSelect",user_id);
	}

	@Override
	public int clubInsert(Map map) throws Exception {
		return session.insert(namespace+"clubInsert", map);
	}

	@Override
	public List<ClubDto> clubSelect(Integer club_id) throws Exception {
		return session.selectList(namespace+"clubSelect", club_id);
	}

	@Override
	public int commentInsert(Map<String, Object> map) throws Exception {
		return session.insert(namespace+"commentInsert", map);
	}

	@Override
	public int postInsert(Map<String, Object> map) throws Exception {
		return session.insert(namespace+"postInsert", map);
	}

	@Override
	public List<ClubDto> postSelect(Integer club_article_id) throws Exception {
		return session.selectList(namespace+"postSelect", club_article_id);
	}

	@Override
	public int updatePost(Map<String, Object> map) throws Exception {
		return session.update(namespace+"updatePost", map);
	}

	@Override
	public int deletePost(Integer club_article_id) throws Exception {
		return session.delete(namespace+"deletePost", club_article_id);
	}

	@Override
	public List<ClubDto> selectClubComment(Integer club_article_id) throws Exception {
		return session.selectList(namespace+"selectClubComment", club_article_id);
	}
}
