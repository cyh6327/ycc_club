package com.youngtvjobs.ycc.member;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youngtvjobs.ycc.admin.AdminDto;
import com.youngtvjobs.ycc.admin.AdminService;
import com.youngtvjobs.ycc.common.YccMethod;
import com.youngtvjobs.ycc.course.CourseDto;
import com.youngtvjobs.ycc.member.security.CustomUser;

//회원관리 컨트롤러
@Controller
public class MemberController {

	MemberDao memberDao;
	MemberService memberService;

	InquiryService inquiryService;
	InquiryDao inquiryDao;

	JavaMailSender mailSender;

	AdminService adminService;

	@Qualifier("BCryptPasswordEncoder")
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public MemberController(MemberDao memberDao, MemberService memberService, InquiryService inquiryService,
			InquiryDao inquiryDao, JavaMailSender mailSender, AdminService adminService,
			BCryptPasswordEncoder passwordEncoder) {
		super();
		this.memberDao = memberDao;
		this.memberService = memberService;
		this.inquiryService = inquiryService;
		this.inquiryDao = inquiryDao;
		this.mailSender = mailSender;
		this.adminService = adminService;
		this.passwordEncoder = passwordEncoder;
	}

	
	// 회원약관동의
	@GetMapping("/signup/agree")
	public String siagree(Model m) throws Exception{

		AdminDto adminDto = adminService.select();

		try {
			m.addAttribute("adminDto",adminDto);
		}catch(Exception e) {e.printStackTrace();}

		return "member/siAgree";
	}

	// 회원가입
	@GetMapping("/signup/form")
	public String siform() {
		return "member/siForm";
	}

	// 아이디중복체크
	@PostMapping("/signup/idcheck")
	@ResponseBody
	public int idcheck(String user_id) {

		int result = 0;

		try {
			result = memberService.idCheck(user_id);
		} catch (Exception e) {e.printStackTrace();}

		return result;
	}

	// 회원가입
	@PostMapping("/signup/form")
	public String siform(MemberDto dto, String user_id) {


		try {
			// 비밀번호 암호화
			String inputPass = dto.getUser_pw();
			String pwd = passwordEncoder.encode(inputPass);
			dto.setUser_pw(pwd);
			memberService.signupMember(dto);
			// 권한 insert
			memberService.insertAuth(user_id);

			System.out.println(dto.getAuthList());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "member/siComple";

	}

	// 이메일 인증 : siForm.jsp에서 넘겨받은 값을 memberService.java에 memberdto.getUser_email()에
	// 담아서 전달해줌
	@PostMapping("/signin/registerEmail")
	@ResponseBody
	public String emailConfirm1(@RequestBody MemberDto memberdto) throws Exception {

		return memberService.insertMember(memberdto.getUser_email());
	}

	// 이메일로 비밀번호 보내기
	@PostMapping("/signin/pwEmail")
	@ResponseBody
	public String emailSendPw(@RequestBody MemberDto memberdto) throws Exception {
		
		return memberService.pwSendEmail(memberdto.getUser_email());
	}

	// 마이페이지1 : 본인인증
	@GetMapping("/mypage/pwcheck")
	public String pwCheck() throws Exception {

		return "member/pwCheck";
	}

	@PostMapping("/mypage/pwcheck")
	public String pwCheck(String inputPassword, Model m, Authentication auth) throws Exception {

		CustomUser user = (CustomUser) auth.getPrincipal();
		String user_pw = user.getMember().getUser_pw();
		// DB의 pw와 입력된 pw가 같으면 modify로 리다이렉트, 그렇지 않으면 pwCheck로 돌아감
		if (passwordEncoder.matches(inputPassword, user_pw)) {

			return "redirect:/mypage/modify";
		}

		m.addAttribute("alert", "<script>alert('비밀번호가 일치하지 않습니다.')</script>");

		return "member/pwCheck";
	}

	// 마이페이지 2: 회원 정보 수정
	@GetMapping("/mypage/modify")
	public String modify(Model m, Authentication auth) {

		try {

			CustomUser user = (CustomUser) auth.getPrincipal();

			// 이메일 아이디/도메인 분리하여 모델에 저장 (회원정보수정 이메일란에 출력)
			String emailId = user.getMember().getUser_email().split("@")[0];
			String emailDomain = user.getMember().getUser_email().split("@")[1];

			m.addAttribute("emailId", emailId);
			m.addAttribute("emailDomain", emailDomain);

			// 생년월일 String으로 형변환 & 포맷 지정하여 모델에 저장 (회원정보수정 생년월일란에 출력)
			String birth_date = YccMethod.date_toString(user.getMember().getUser_birth_date());

			m.addAttribute("birth_date", birth_date);

			return "member/modify";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}

	@PostMapping("/mypage/modify")
	public String modify(MemberDto dto) {
		try {
			String inputPass = dto.getUser_pw();
			String pwd = passwordEncoder.encode(inputPass);
			dto.setUser_pw(pwd);
			memberService.ModifyMemberInfo(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}

	// 마이페이지3 : 회원탈퇴
	@RequestMapping("/mypage/withdraw")
	public String withdraw(Authentication auth) throws Exception {
		String user_id = auth.getName();

		// tb_user테이블에서 Authentication에 저장된 id와 같은 user_id를 가진 회원을 삭제시킨후 
		// 인증정보를 담고있는 SecurityContextHolder 객체를 삭제
		memberService.withdraw(user_id);
		SecurityContextHolder.clearContext();

		return "member/withdraw";
	}

	// 마이페이지4 : 내 수강목록
	@RequestMapping("/mypage/mycourse")
	public String myCourse(Authentication auth, Model m) {

		
		try {
			List<CourseDto> courseList = memberService.readMyCourse(auth.getName());
			m.addAttribute("courseList", courseList);
		
		} catch (Exception e) {
			e.printStackTrace();

			return "redirect:/";
		}

		return "member/mycourse";
	}

	// 마이페이지5 : id/pw 찾기
	@RequestMapping("/mypage/forget")
	public String forget() {
		return "member/forget";
	}

	// 아이디 찾기
	@PostMapping("/mypage/findId")
	@ResponseBody
	public String findId(HttpServletResponse response, @RequestBody MemberDto memberDto) throws Exception {

		return memberService.findId(response, memberDto.getUser_email(), memberDto.getUser_name());
	}

	// 패스워드 찾기
	@PostMapping("/mypage/findPw")
	@ResponseBody
	public String findPw(HttpServletResponse response, @RequestBody MemberDto memberDto) throws Exception {

		return memberService.findPw(response, memberDto.getUser_id(), memberDto.getUser_name());
	}

	// 1:1 문의
	// 나의 문의 내역 - 기간별 조회
	@GetMapping("/mypage/inquiry")
	public String inquiryHistory(SearchByPeriod sp, String settedInterval, Model m, Authentication auth,
			String startDate, String endDate) {
		
		// startDate / endDate 유효성체크를 위한 값 (최대 1년 전 ~ 오늘)
		LocalDate nowdate = LocalDate.now();
		m.addAttribute("nowdate", nowdate);
		LocalDate aYearAgo = LocalDate.now().minusYears(1);
		m.addAttribute("aYearAgo",aYearAgo);
		
		
		try {
			int totalCnt;
			InqPageResolver pr;

			// 서비스 메소드에 파라미터로 넣어줄 id 
			String id = auth.getName();

			if (settedInterval == null) {
				settedInterval = sp.getSettedInterval();
			}
			// 조회기간을 직접 설정해 주었을 때 동작
			if (startDate != null && endDate != null && !startDate.equals("") && !endDate.equals("")) {
				
				settedInterval = null;
				
				// 나의 문의내역 목록 
				List<InquiryDto> inqList = inquiryService.getPageByInput(id, sp);

				m.addAttribute("inqList", inqList);
				m.addAttribute("startDate", sp.getStartDate());
				m.addAttribute("endDate", sp.getEndDate());

				// pagination
				totalCnt = inquiryService.getPageByInputCnt(id, sp);
				pr = new InqPageResolver(sp, totalCnt);
				m.addAttribute("pr", pr);
				m.addAttribute("totalCnt", totalCnt);

				return "member/inquiryHistory";
			}			
			// 1개월,3개월 버튼을 클릭했을 때 동작(name="settedInterval")
			else if (settedInterval.equals("3month") || settedInterval.equals("6month")) {
				// 나의 문의내역 목록 
				List<InquiryDto> inqList = inquiryService.getPage(id, sp);
				m.addAttribute("inqList", inqList);

				// pagination
				totalCnt = inquiryService.getPageCnt(id, sp);
				pr = new InqPageResolver(sp, totalCnt);
				m.addAttribute("pr", pr);
				m.addAttribute("totalCnt", totalCnt);

				return "member/inquiryHistory";
			}
			
			// 버튼조작, 기간설정 없을시 기본 1개월 조회 동작
			// 나의 문의내역 목록 
			List<InquiryDto> inqList = inquiryService.getPage(id, sp);
			m.addAttribute("inqList", inqList);

			// pagination
			totalCnt = inquiryService.getPageCnt(id, sp);
			pr = new InqPageResolver(sp, totalCnt);
			m.addAttribute("pr", pr);
			m.addAttribute("totalCnt", totalCnt);

			return "member/inquiryHistory";

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "member/inquiryHistory";
	}

	// 1:1 문의글: 작성하기
	@GetMapping("/mypage/inquiry/write")
	public String inquiryWrite() {

		return "member/inquiryWrite";
	}

	// 1:1 문의글: 작성한 글 등록하기
	@PostMapping("/mypage/inquiry/write")
	public String inquiryWrite(InquiryDto inquiryDto, Authentication auth, RedirectAttributes rattr, Model m) {
		// 글 작성자와 현재 날짜 설정
		String id = auth.getName();
		inquiryDto.setUser_id(id);
		inquiryDto.setInq_date(new Date());

		try {
			// 등록에 실패하면 예외처리
			if (inquiryService.wirteInq(inquiryDto) != 1) {
				throw new Exception("Write Failed");
			}

			rattr.addFlashAttribute("msg", "WRT_OK");

			return "redirect:/mypage/inquiry";

		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("inquiryDto", inquiryDto);
			m.addAttribute("msg", "WRT_ERR");

			return "member/inquiryWrite";
		}

	}

	// 1:1 문의글 읽기 페이지
	@GetMapping("/mypage/inquiry/read")
	public String inquiryRead(Integer inq_id, Authentication auth, Model m) {
		try {
			// id 와 inq_id로 문의글 내용 불러오기
			String id = auth.getName();
			InquiryDto inquiryDto = inquiryService.read(id, inq_id);

			m.addAttribute(inquiryDto);

		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/mypage/inquiry";
		}

		return "member/inquiryRead";
	}
	
}
