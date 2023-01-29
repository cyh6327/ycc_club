package com.youngtvjobs.ycc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;

import com.youngtvjobs.ycc.course.CourseDto;

@Repository
public class MemberDaoImpl implements MemberDao
{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.member.memberMapper.";
	MemberDto memberDto;
	JavaMailSender mailSender;
	

	@Override
	public MemberDto loginSelect(String id) throws Exception
	{
		// 로그인 셀렉트 
		return session.selectOne(namespace + "loginSelect", id);
	}
	//권한
	@Override
	public int insertAuth(String user_id) throws Exception {

		return session.insert(namespace + "insertAuth" , user_id) ;
	}

	//회원가입_아이디중복체크 
	@Override
	public int idCheck(String user_id) throws Exception {
		return session.selectOne(namespace + "idCheck", user_id);
	}
	
	//회원가입_INSERT
	@Override
	public void signupMember(MemberDto dto) throws Exception {

		session.insert(namespace + "signupMember" , dto);
		
	}

	//회원 정보 수정
	@Override
	public int update(MemberDto memberDto) throws Exception {
		
		return session.update(namespace+"update", memberDto);
	}

	//회원 탈퇴
	@Override
	public int delete(String id) throws Exception {
		
		return session.delete(namespace+"delete", id);
	}
	
	@Override
	public int deleteAll() throws Exception
	{
		return session.delete(namespace+"deleteAll");
		
	}

	//아이디 찾기
	@Override
	public String findId(String user_email, String user_name) throws Exception {
		Map map = new HashMap();
		map.put("user_email", user_email);
		map.put("user_name", user_name);
		
		return session.selectOne(namespace + "findId", map);
	}
	
	//패스워드 찾기
	@Override
	public String findPw(String user_id, String user_name) throws Exception {
		Map map = new HashMap();
		map.put("user_id", user_id);
		map.put("user_name", user_name);
		return session.selectOne(namespace + "findPw", map);
	}
	
	//임시 비밀번호 DB 업로드
	public void uploadPw(MemberDto dto) throws Exception {
		session.selectOne(namespace + "uploadPw", dto);
	}


	//시큐리티 
	@Override
	public MemberDto read(String user_id) throws Exception {
		
		return session.selectOne(namespace + "read" ,user_id);
	}
	
	@Override
	public List<CourseDto> selectMyCourse(String user_id) throws Exception {

		return session.selectList(namespace+"selectMyCourse", user_id);
	}


}
