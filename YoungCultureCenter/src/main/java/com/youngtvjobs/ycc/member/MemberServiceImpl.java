package com.youngtvjobs.ycc.member;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.youngtvjobs.ycc.course.CourseDto;
import com.youngtvjobs.ycc.member.mail.MailHandler;
import com.youngtvjobs.ycc.member.mail.TempKey;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao memberDao;
	@Autowired
	JavaMailSender mailSender;

	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override	//회원 가입
	public void signupMember(MemberDto dto) throws Exception {
		String year = dto.getBirthYear();
		String month = dto.getBirthMonth();
		String day = dto.getBirthDay();
		
		Date birth = Date.valueOf(year +"-"+ month +"-"+ day);
		dto.setUser_birth_date(birth);
		
		
		memberDao.signupMember(dto);
		System.out.println(dto);
	}
	
	@Override	//권한 insert
	public int insertAuth(String user_id) throws Exception {
		return memberDao.insertAuth(user_id);
	}
	
	@Override	//아이디체크 
	public int idCheck(String user_id) throws Exception {
		return memberDao.idCheck(user_id);
	}

	@Override	//회원 탈퇴
	public int withdraw(String id) throws Exception {
		
		return memberDao.delete(id);
	}

	@Override	//회원 정보 수정
	public int ModifyMemberInfo(MemberDto memberDto) throws Exception {

		return memberDao.update(memberDto);
	}
	
	//아이디 찾기
	@Override
	public String findId(HttpServletResponse response, String user_email, String user_name) {

		String user_id = null;
		try {
			user_id = memberDao.findId(user_email, user_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (user_id == null) {
			return null;
		} else {
			return user_id;
		}
	}
	
	//패스워드 찾기
	@Override
	public String findPw(HttpServletResponse response, String user_id, String user_name) {
		
		String user_email = null;
		try {
			user_email = memberDao.findPw(user_id, user_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (user_email == null) {
			return null;
		} else {
			return user_email;
		}
	}
	
	//이메일인증: mail_key값 생성하여 메일 발송세팅
	@Override 
	public String insertMember(String user_email){
		
			//랜덤 문자열을 생성해서 mail_key 컬럼에 넣어주기
			String mail_key = new TempKey().getKey(7, false);	//랜덤키 길이 설정
			
			String mail_title = "[Young문화체육센터 인증메일 입니다.]";
			String mail_text = "<h1>Young문화체육센터 메일인증</h1>" +
					"<br>Young문화체육센터에 오신것을 환영합니다!" +
					"<br>아래 인증번호를 인증번호 입력창에 입력해주세요." +
					"<p><b>인증번호: "+ mail_key +"</b></p>";
			
			try {
				this.sendEmail(user_email, mail_title, mail_text);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			return mail_key;
		}
	
	//패스워드 찾을때 이메일 발송 세팅
	public String pwSendEmail(String user_email) {
		
		
		//1. 난수 생성, 이메일 발송 세팅
		String temp_pw = new TempKey().getKey(15, false);
		
		String email_title = "[Young문화체육센터 비밀번호 입니다.]";
		String email_text = "<h1>Young문화체육센터 비밀번호 찾기</h1>" +
				"<p><b>비밀 번호 : "+ temp_pw +"</b></p>";
		
		try {
			this.sendEmail(user_email, email_title, email_text);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//2. 발생시킨 난수를 암호화시켜 DB 업로드
		try {
			MemberDto dto = new MemberDto();
			String pwd = passwordEncoder.encode(temp_pw);
			dto.setUser_email(user_email);
			dto.setUser_pw(pwd);
			memberDao.uploadPw(dto);
		} catch (Exception e) {e.printStackTrace();}

		
		return user_email;
		
	}
	
	//이메일 발송 함수
	public void sendEmail(String user_email, String email_title, String email_text) throws Exception {
		//회원가입 완료하면 인증을 위한 이메일 발송
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject(email_title); 	//메일제목
		sendMail.setText(email_text);
		sendMail.setFrom("soojeontest01@gmail.com", "Young문화체육센터");
		sendMail.setTo(user_email);
		sendMail.send();
	}
	
	//권한
	@Override
	public MemberDto read(String user_id) throws Exception {
		
		return memberDao.read(user_id);
	}
	
	//나의 수강 목록
	@Override
	public List<CourseDto> readMyCourse(String user_id) throws Exception {
		return memberDao.selectMyCourse(user_id);
	}

	
	
	
}