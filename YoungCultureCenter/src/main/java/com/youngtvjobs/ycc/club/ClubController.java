package com.youngtvjobs.ycc.club;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youngtvjobs.ycc.course.CourseController;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class ClubController {
	
	private static final Logger logger = LoggerFactory.getLogger(CourseController.class);
	
	@Autowired
	ClubService clubService;
	ClubDao clubDao;

	@GetMapping("/club")
	public String clubMain(HttpServletRequest request, Model m, SearchItem sc, Authentication auth,
			@RequestParam(required=false, value="keyword") String keyword,
			@RequestParam(required=false, value="array") String array) {
		
		sc.setArray(array);
		int totalCnt;
		
		try {
			
			List<ClubDto> cList = clubService.getClubList(sc);
			m.addAttribute("cList", cList);
			System.out.println("cList = " + cList);
			
			List<ClubDto> pClubList = clubService.getPopularClub();
			m.addAttribute("pClubList", pClubList);
			System.out.println("pClubList = " + pClubList);
			
			String user_id = auth.getName(); 
			m.addAttribute("user_id", user_id);
		    System.out.println("user_id = " + user_id);
		    
		    List<ClubDto> myClubList = clubService.getMyClub(user_id);
		    m.addAttribute("myClubList", myClubList);
		    System.out.println("myClubList = " + myClubList);
		    
		    totalCnt = clubService.getClubList(sc).get(0).getCount();
		    System.out.println("totalCnt = " + totalCnt);
			m.addAttribute("totalCnt", totalCnt);
			
			PageResolver pageResolver = new PageResolver(totalCnt, sc);
			m.addAttribute("pr", pageResolver);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "club/clubmain";
	}
	
	@GetMapping("/club/createForm")
	public String clubCreateForm() {
		return "club/clubCreateForm";
	}
	
	/*
	@GetMapping("/club/joinForm")
	public String clubJoinForm() {
		return "club/clubJoinForm";
	}
	*/
	
	@PostMapping("/club/dbCheckClubTitle")
	@ResponseBody
	public int clubTitleCheck(SearchItem sc, Model m, String club_title,
			RedirectAttributes rattr) {
		
		int result = 0;
		
		try {
			result = clubService.clubTitleCheck(club_title);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping("/club/create")
	public String createClub(HttpServletRequest request, Authentication auth, ClubDto clubDto) {
		
		logger.info("createClub....." + clubDto);
		
		String club_title = request.getParameter("club_title");
		System.out.println("club_title = " + club_title);
		
		String club_info = request.getParameter("club_info");
		System.out.println("club_info = " + club_info);
		
		String club_master_id = auth.getName(); 
	    System.out.println("club_master_id = " + club_master_id);
	    
	    String uuid = clubDto.getUuid();
	    String upload_path = clubDto.getUpload_path();
	    String file_name = clubDto.getFile_name();
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_title", club_title);
	    map.put("club_info", club_info);
	    map.put("club_master_id", club_master_id);
	    map.put("uuid", uuid);
	    map.put("upload_path", upload_path);
	    map.put("file_name", file_name);
		
	    
	    try {
	    	int clubCreate = clubService.createClub(map);
			if (clubCreate != 1) {
				throw new Exception("Create Failed");
			}
			return "redirect:/club";
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/club";
	}
	
	@PostMapping("/club/join")
	public ResponseEntity<String> joinClub(HttpServletRequest request, Authentication auth, 
			RedirectAttributes rattr, @RequestParam("club_id") String str) {
		
		String user_id = auth.getName();
		Integer club_id = Integer.parseInt(str);
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_id", club_id);
	    map.put("user_id", user_id);
		
	    try {
	    	int joinClub = clubService.joinClub(map);
			if (joinClub != 1) {
				throw new Exception("Join Member Failed");
			}
			return new ResponseEntity<String>("JOIN_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
		}
	}

	@RequestMapping("/club/board")
	public String clubBoard(HttpServletRequest request, Model m, Authentication auth, SearchItem sc,
			@RequestParam("club_id") String str) {
		
		Integer club_id = Integer.parseInt(str);
		String user_id = auth.getName(); 
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_id", club_id);
	    map.put("pageSize", sc.getPageSize());
	    map.put("offset", sc.getOffset());
		
		try {
			List<ClubDto> clubSelect = clubService.clubSelect(map);
			m.addAttribute("clubSelect", clubSelect);
			System.out.println("clubSelect = " + clubSelect);
			
			List<ClubDto> myClubList = clubService.getMyClub(user_id);
		    m.addAttribute("myClubList", myClubList);
		    
		    int totalCnt = clubService.clubSelect(map).get(0).getCount();
		    m.addAttribute("totalCnt", totalCnt);
		    PageResolver pageResolver = new PageResolver(totalCnt, sc);
			m.addAttribute("pr", pageResolver);
		    
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	    
		return "club/club_board";
	}

	@RequestMapping("club/board/view")
	public String viewClubPost(HttpServletRequest request, Model m, Authentication auth,
			@RequestParam("club_article_id") String str) {
		
		Integer club_article_id = Integer.parseInt(str);
		System.out.println("club_article_id = " + club_article_id);
		String user_id = auth.getName(); 
		m.addAttribute("user_id", user_id);
		
		try {
			ClubDto postSelect = clubService.postSelect(club_article_id);
			m.addAttribute("postSelect", postSelect);
			System.out.println("postSelect=" + postSelect);
		
			List<ClubDto> commentSelect = clubService.selectClubComment(club_article_id);
			m.addAttribute("commentSelect", commentSelect);
			System.out.println("commentSelect=" + commentSelect);
		 
			List<ClubDto> myClubList = clubService.getMyClub(user_id);
			m.addAttribute("myClubList", myClubList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "club/clubPost";
	}
	
	@GetMapping("club/board/edit")
	public String clubEdit(HttpServletRequest request, Model m, Authentication auth,
			@RequestParam("club_article_id") String str) {
		
		Integer club_article_id = Integer.parseInt(str);
		
		try {
			ClubDto postSelect = clubService.postSelect(club_article_id);
			m.addAttribute("postSelect", postSelect);
			
			String user_id = auth.getName(); 
			m.addAttribute("user_id", user_id);
		    System.out.println("user_id = " + user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "club/clubWrite";
	}
	
	// PutMapping으로 바꿔줘야 함
	@PostMapping("club/board/edit") 
	public String updateClubPost(HttpServletRequest request, Model m, RedirectAttributes re) {
		
		String club_article_title = request.getParameter("post_title");
		String club_article_content = request.getParameter("post_content");
		String str = request.getParameter("club_article_id");
		String str2 = request.getParameter("club_id");
		Integer club_article_id = Integer.parseInt(str);
		System.out.println("club_article_id" + club_article_id);
		// redirect시 /club/board/view의 파라미터를 전달
		re.addAttribute("club_article_id", str);
		re.addAttribute("club_id", str2);

		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_article_title", club_article_title);
	    map.put("club_article_content", club_article_content);
	    map.put("club_article_id", club_article_id);
	    
	    try {
			int updatePost = clubService.updatePost(map);
			if (updatePost != 1) {
				throw new Exception("Edit Failed");
			}
			return "redirect:/club/board/view";
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
		
		return "club/club_board";
	}
	
	// DeleteMapping으로 바꿔줘야 함
	@PostMapping("club/board/delete")
	public String deletePost(HttpServletRequest request, Model m, Authentication auth,
			@RequestParam("club_article_id") String str, @RequestParam("club_id") String str2,
			RedirectAttributes re) {
		
		Integer club_article_id = Integer.parseInt(str);
		
		try {
			int deletePost = clubService.deletePost(club_article_id);
			if (deletePost != 1) {
				throw new Exception("Delete Failed");
			}
			re.addAttribute("club_id", str2);
			return "redirect:/club/board";
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "club/club_board";
	}
	
	@PostMapping("club/member/delete")
	public ResponseEntity<String> deleteMember(HttpServletRequest request, Model m, Authentication auth,
			@RequestParam("club_id") String str) {
		
		Integer club_id = Integer.parseInt(str);
		String user_id = auth.getName(); 
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_id", club_id);
	    map.put("user_id", user_id);
		
		try {
			int deleteMember = clubService.deleteMember(map);
			if (deleteMember != 1) {
				throw new Exception("Delete Failed");
			}
			return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("club/board/comment")
	public ResponseEntity<String> writeClubCmt(HttpServletRequest request, Model m,
			@RequestParam("club_comment") String club_comment, 
			@RequestParam("user_id") String user_id, @RequestParam("club_article_id") String str) {
		
		Integer club_article_id = Integer.parseInt(str);
		
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_comment", club_comment);
	    map.put("user_id", user_id);
	    map.put("club_article_id", club_article_id);
	    
	    try {
			int commentRegist = clubService.commentRegist(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping("club/board/write")
	public String writeClubPost() {
		
		return "club/clubWrite";
	}
	
	@PostMapping("club/board/write")
	public String insertClubPost(HttpServletRequest request, Authentication auth, RedirectAttributes re) {
		
		String club_article_title = request.getParameter("post_title");
		System.out.println("club_article_title = " + club_article_title);
		String club_article_content = request.getParameter("post_content");
		System.out.println("club_article_content = " + club_article_content);
		String user_id = auth.getName();
		System.out.println("user_id = " + user_id);
		String str = request.getParameter("club_id");
		
		Integer club_id = Integer.parseInt(str);
		System.out.println("club_article_content = " + club_article_content);
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_article_title", club_article_title);
	    map.put("club_article_content", club_article_content);
	    map.put("user_id", user_id);
	    map.put("club_id", club_id);
	 		
	    try {
			int postRegist = clubService.postRegist(map);
			if (postRegist != 1) {
				throw new Exception("Write Failed");
			}
			// insert된 게시글의 club_article_id 를 가져옴
			String key = map.get("keyNum").toString();
			
			// redirect시 /club/boar/view의 파라미터를 전달
			re.addAttribute("club_id", str);
		 	re.addAttribute("club_article_id", key);
		 	return "redirect:/club/board/view";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    return "club/club_board";
	}
	
	/* 첨부 파일 업로드 */
	@PostMapping(value = "club/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ClubDto> uploadAjaxActionPOST(MultipartFile uploadFile) {
		
		logger.info("uploadAjaxActionPOST..........");
		
		// view에서 전달받은 파일(uploadFile)
		File checkfile = new File(uploadFile.getOriginalFilename());
		String type = null;  //MIME TYPE을 저장할 변수
		try {
			// probeContentType() : 파라미터로 전달받은 파일의 MIME TYPE을 문자열(Stirng) 반환해주는 메서드
			type = Files.probeContentType(checkfile.toPath());
			logger.info("MIME TYPE : " + type);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(!type.startsWith("image")) {
			// 전달 해줄 파일의 정보는 없지만 반환 타입이 ResponseEntity<ClubImgDto>이기 때문에 변수 선언
			ClubDto clubDto = null;
			return new ResponseEntity<>(clubDto, HttpStatus.BAD_REQUEST);	//상태 코드 400
		}
		
		String uploadFolder = "C:\\upload";
		
		//날짜 데이터를 지정된 문자열 형식으로 변환하거나 날짜 문자열 데이터를 날짜 데이터로 변환할 수 있게 해주는 클래스
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		Date date = new Date();	//오늘의 날짜 데이터
		String str = sdf.format(date);
		
		/* '-'을 경로 구분자인 '/'(리눅스) 혹은 '\'(윈도우)로 변경하기 위해 replace 메서드 사용
		File.separator: 실행되는 환경(리눅스, 윈도우, ...)에 따라 그에 맞는 경로 구분자를 반환해줌 */
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 => "c://upload//yyyy//MM//dd" 경로의 디렉터리를 대상으로 하는 File 객체로 초기화
		new File(부모 경로, 자식 경로) */
		File uploadPath = new File(uploadFolder, datePath);
		
		// 폴더가 이미 존재하는 상황에서 폴더를 생성하는 코드가 실행되는 것을 방지
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();	//여러개의 폴더를 생성하는 메서드
		}
		
		/* 이미지 정보 객체 */
		ClubDto clubDto = new ClubDto();
		
		/* 파일 이름. 뷰로부터 전달받은 파일 이름을 가져옴 */
		String uploadFileName = uploadFile.getOriginalFilename();
		clubDto.setFile_name(uploadFileName);
		clubDto.setUpload_path(datePath);
		
		/* uuid(범용 고유 식별자) 적용 파일 이름 
		 * UUID 타입의 데이터를 toString을 통해 String으로 변환 */
		String uuid = UUID.randomUUID().toString();
		clubDto.setUuid(uuid);
		
		// 기존 파일 이름인 uploadFileName 변수를 "UUID_파일 이름" 형식이 되도록 재할당
		uploadFileName = uuid + "_" + uploadFileName;
		
		/* 파일 위치, 파일 이름을 합친 File 객체 */
		File saveFile = new File(uploadPath, uploadFileName);
		
		
		try {
			/* 파일 저장. transferTo() 사용 */
			uploadFile.transferTo(saveFile);
			
			/* thumbnailaotor 라이브러리를 사용해 썸네일 생성 및 저장 */
			File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
			
			BufferedImage bo_image = ImageIO.read(saveFile);

				//비율 
				double ratio = 5;
				//넓이 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);					
			
			Thumbnails.of(saveFile)
	        .size(width, height)
	        .toFile(thumbnailFile);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		logger.info("파일 이름 : " + uploadFile.getOriginalFilename());
		logger.info("파일 타입 : " + uploadFile.getContentType());
		logger.info("파일 크기 : " + uploadFile.getSize());
		
		ResponseEntity<ClubDto> result = new ResponseEntity<ClubDto>(clubDto, HttpStatus.OK);
		
		return result;
		
	}
	
	@PostMapping("/club/deleteImage")
	public ResponseEntity<String> deleteImage(String fileName) {
		
		logger.info("deleteImage()........" + fileName);
		
		File file = null;
		
		try {
			/* 썸네일 파일 삭제 */
			// view에서 받은 UTF-8타입의 이미지파일(fileName)을 디코딩
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			logger.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			file.delete();
			
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping("club/display")
	public ResponseEntity<byte[]> getImage(String file_name){
		
		logger.info("getImage()......." + file_name);

		File file = new File("c:\\upload\\" + file_name);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			// ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해 객체 생성
			HttpHeaders header = new HttpHeaders();
			// header의 'Content Type' 속성 값에 이미지 파일 MIME TYPE을 추가
			header.add("Content-type", Files.probeContentType(file.toPath()));
			// copyToByteArray(file): 파라미터로 부여하는 File 객체(=대상 파일)을 복사하여 Byte 배열로 반환함
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
