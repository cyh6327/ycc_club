package com.youngtvjobs.ycc.member;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.youngtvjobs.ycc.course.CourseDto;

@Repository
public interface MemberDao {
	MemberDto loginSelect(String id) throws Exception;

	// 회원가입 insert
	void signupMember(MemberDto dto) throws Exception;

	// 권한 insert
	int insertAuth(String user_id) throws Exception;

	// 회원가입 아이디중복체크
	int idCheck(String user_id) throws Exception;

	int delete(String id) throws Exception;

	int deleteAll() throws Exception;

	// 회원 정보 수정
	int update(MemberDto memberDto) throws Exception;

	// 아이디 찾기
	String findId(String user_email, String user_name) throws Exception;

	// 패스워드 찾기
	String findPw(String user_id, String user_name) throws Exception;

	// 임시 비밀번호 이메일로 발송
	void uploadPw(MemberDto dto) throws Exception;

	// 시큐리티
	MemberDto read(String user_id) throws Exception;

	// 나의 수강 목록
	List<CourseDto> selectMyCourse(String user_id) throws Exception;

}
