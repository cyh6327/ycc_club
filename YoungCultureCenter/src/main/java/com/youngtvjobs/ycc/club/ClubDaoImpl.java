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
	public List<ClubDto> clubListSelect(SearchItem sc) throws Exception {
		return session.selectList(namespace+"clubListSelect", sc);
	}

	@Override
	public List<ClubDto> myClubSelect(Map<String, Object> map) throws Exception {
		return session.selectList(namespace+"myClubSelect",map);
	}

	@Override
	public int clubInsert(Map map) throws Exception {
		return session.insert(namespace+"clubInsert", map);
	}

	@Override
	public List<ClubDto> clubSelect(Map<String, Object> map) throws Exception {
		return session.selectList(namespace+"clubSelect", map);
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
	public ClubDto postSelect(Integer club_article_id) throws Exception {
		return session.selectOne(namespace+"postSelect", club_article_id);
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

	@Override
	public int clubTitleCheck(String club_title) throws Exception {
		return session.selectOne(namespace+"clubTitleCheck", club_title);
	}

	@Override
	public int insertMember(Map<String, Object> map) throws Exception {
		return session.insert(namespace+"insertMember", map);
	}

	@Override
	public int deleteMember(Map<String, Object> map) throws Exception {
		return session.delete(namespace+"deleteMember", map);
	}

	@Override
	public List<ClubDto> popularClub() throws Exception {
		return session.selectList(namespace+"popularClub");
	}

	@Override
	public int increaseClubViewCnt(Integer club_article_id) throws Exception {
		return session.update(namespace+"increaseClubViewCnt", club_article_id);
	}

}
