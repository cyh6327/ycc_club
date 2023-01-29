package com.youngtvjobs.ycc.course;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class CourseController {
	
	private static final Logger logger = LoggerFactory.getLogger(CourseController.class);

	@Autowired
	CourseService courseService;

	@RequestMapping("/integratedPayment")
	public String courseip() {
		return "/integratedPayment";
	}
	
	@RequestMapping("/course/courseinfo")
	public String courseinfo() {
		return "/course/courseinfo";
	}

	@RequestMapping("/course/schedule")
	public String courseSchedule() {
		return "/course/courseSchedule";
	}

	@GetMapping("/payment")
	public String IntegratedPayment() {
		return "/integratedPayment";
	}
	
	// 수강신청 클릭 후 이동하는 페이지
	@GetMapping("/course/regcomplete")
	public String courseRegComplete(Integer course_id, AttendDto attendDto, Model m , Authentication auth, RedirectAttributes rattr, HttpServletRequest request) {
		String user_id = auth.getName(); // 세션에 저장되어 있는 id 불러오기
		Date nowdate = new Date(); // 오늘날짜 객체 생성

		attendDto.setUser_id(user_id);
		attendDto.setCourse_id(course_id);

		try {
			m.addAttribute("attendDto", attendDto);

			// 등록강좌 상세불러오기
			CourseDto courseDto = courseService.readCourseDetail(course_id);
			m.addAttribute("courseDto", courseDto);

			// 수강신청
			// 중복 방지
			if (courseService.attendDuplicateCheck(course_id, user_id) == 0) {
				// 강좌 상태 확인
				// 접수기간
				// reg_start_date는 nowdate보다 이전이다(reg_start_date < nowdate) && reg_end_date는
				// nowdate보다 이후이다(nowdate < reg_end_date)
				if ((courseDto.getCourse_reg_start_date().before(nowdate) == true
						&& courseDto.getCourse_reg_end_date().before(nowdate) == true)
						|| (courseDto.getCourse_reg_start_date().before(nowdate) == true
								&& courseDto.getCourse_reg_end_date().after(nowdate) == true)) { 
					// 수강신청 시 attend에 insert & 신청인원 1명 증가
					courseService.attendInsert(attendDto); 
					System.out.println("수강신청이 성공적으로 완료되었습니다. 감사합니다.");
					rattr.addFlashAttribute("msg", "REG_COMPLETE");
				// 신청인원을 총정원과 비교	
				} else if (courseDto.getCourse_applicants() >= courseDto.getCroom_mpop()) {
					System.out.println("정원이 마감되었습니다. 새로고침 후 신청인원을 확인해주세요.");
					rattr.addFlashAttribute("msg", "overcapacity");
					return "redirect:/course/search";
				} else {
					System.out.println("접수기간이 아닙니다. 접수기간을 확인해주세요.");
					rattr.addFlashAttribute("msg", "NO_PERIOD");
					return "redirect:/course/search";
				}
			} else {
				System.out.println("중복 신청은 할 수 없습니다. 나의 수강목록에서 확인해주세요.");
				rattr.addFlashAttribute("msg", "OVERLAP");
				return "redirect:/course/search";
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();

			return "redirect:/course/detail?toURL=" + request.getRequestURL();
		}
		
		return "/course/courseRegComplete";
	}
	
	/* 이미지 파일 삭제 */
	@PostMapping("/course/deleteimage")
	public ResponseEntity<String> deleteImage(String fileName) { // HTTP Body에 String 데이터를 추가하기 위해 타입 매개 변수로서 String을 부여
		logger.info("deleteImage........" + fileName);
		File file = null;
		
		// URLDecoder.decode(), file.delete() 두 개 모두 예외를 발생시킬 가능성이 큰 메서드
		try {
			/* 썸네일 파일 삭제 */
			// decode() 메서드는 static 메서드이기 때문에 인스턴스화 없이 사용이 가능
			file = new File(URLDecoder.decode(fileName, "UTF-8")); 
			file.delete();
			/* 원본 파일 삭제 */
			// getAbsolutePath() 메서드를 호출하면 대상 File 객체의 경로를 문자열(String) 타입의 데이터로 반환
			String originFileName = file.getAbsolutePath().replace("s_", ""); 
			// 원본 파일 경로가 정상적인 값을 가지는지 확인을 하기 위해
			logger.info("originFileName : " + originFileName); 
			file = new File(originFileName);
			file.delete();
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	/* 이미지 보여주기 */
	@GetMapping("/course/imagedisplay")
	public ResponseEntity<byte[]> getImage(String fileName) { // ResponseEntity 객체를 통해 body에 byte[] 데이터를 보내야 하기 때문에 
															  // ResponseEntity<byte[]>를 반환 타입으로 작성
		logger.info("getImage()........" + fileName);
		File file = new File(fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath())); // add() 메서드의 첫 번째 파라미터에는 Response header의 '속성명'을, 
																			   // 두 번째 파라미터에는 해당 '속성명'에 부여할 값(value)을 삽입
			// 대상 이미지 파일, header 객체, 상태 코드를 인자 값으로 부여한 생성자
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK); // copyToByteArray() 메서드는 대상 파일을 복사하여 Byte 배열로 반환해주는 클래스
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 첨부파일 업로드 */
	@PostMapping(value = "/course/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CourseImageDto>> uploadAjaxActionPOST(MultipartFile[] uploadFile) { // MultiparFile : 뷰(View)에서 전송한 multipart 타입의 파일을 다룰 수 있도록 해주는 인터페이스 
					 								   											   // 해당 인터페이스의 메서드들은 파일의 이름 반환, 파일의 사이즈 반환, 파일을 특정 경로에 저장 등을 수행 
		logger.info("uploadAjaxActionPOST..........");
		
		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile : uploadFile) { // 전달받은 모든 파일(uploadfile)의 유형을 체크
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			// probeContentType() 메서드의 경우 IOException 예외를 일으킬 가능성이 크므로 probeContentType() 메서드를 try/catch 문으로 감싸줌.
			try {
				type = Files.probeContentType(checkfile.toPath()); 
				logger.info("MIME TYPE : " + type);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(!type.startsWith("image")) {
				List<CourseImageDto> imageList = null;
				return new ResponseEntity<>(imageList, HttpStatus.BAD_REQUEST);
			}
		} // 향상된 for
		
		String uploadFolder = "C:\\upload";
		
		/* 날짜 폴더 경로 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Date 클래스를 통해 얻은 오늘의 날짜를 지정된 형식의 문자열 데이터로 생성하기 위해서 사용
		Date date = new Date(); // 오늘의 날짜 데이터를 얻기 위해서
		String str = sdf.format(date); // 오늘의 날짜 데이터 값을 가지고 있는 date 변수를 "yyyy-MM-dd" 형식의 문자열로 변환을 해주기 위해서
		String datePath = str.replace("-", File.separator); // str 변수의 값의 문자열 중 '-'을 String 클래스의 replace 메서드를 사용하여 File.separator로 변경
		
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath); // 'c:\\upload\\yyyy\\MM\\dd' 경로의 디렉터리를 대상으로 하는 File 객체로 초기화
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 여러개의 폴더를 생성해야 하기 때문에 mkdirs() 메서드 사용
		}
		
		/* 이미지 정보 담는 객체 */
		List<CourseImageDto> imageList = new ArrayList();
		
		// 향상된 for
		for(MultipartFile multipartFile : uploadFile) {
			/* 이미지 정보 객체 */
			CourseImageDto courseImageDto = new CourseImageDto();
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename(); // 파일의 이름을 사용하기 위해 
			courseImageDto.setFileName(uploadFileName);
			courseImageDto.setUploadPath(uploadPath.toString());
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			courseImageDto.setUuid(uuid);
			uploadFileName = uuid + "_" + uploadFileName; // 기존 파일 이름인 uploadFileName 변수를 "UUID_파일 이름" 형식이 되도록 변경
			
			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName); // 파일 경로와 파일 이름을 포함하는 File 객체로 초기화
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile); // 뷰로부터 전달 받은전달받은 파일을 지정한 폴더에 저장하기 위해서
													// 파일을 저장하는 메서드인 transferTo()
				
//				/* 썸네일 생성 방법 1(ImageIO) : Java내에서 크기를 지정한 이미지를 만들고, 그 이미지에 맞게 원본 이미지를 그려 넣은 다음 해당 이미지를 파일로 저장 */
//				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName); // 썸네일의 이미지는 "s_"+"이미지 이름"으로 작성
//				BufferedImage bo_image = ImageIO.read(saveFile); // buffered original image 
//				
//				/* 비율 */
//				double ratio = 3;
//				/* 넓이 높이 */
//				int width = (int) (bo_image.getWidth() / ratio); // 원본 이미지의 넓이와 높이를 알아내기 위해 
//				int heigth = (int) (bo_image.getHeight() / ratio); // BufferedImage 클래스의 getWidth(), getHeight() 메서드를 사용
//				
//				BufferedImage bt_image = new BufferedImage(width, heigth, BufferedImage.TYPE_3BYTE_BGR); // '넓이', '높이', '생성될 이미지의 타입'
//																										 // 이 과정은 일종의 크기를 지정하여 흰색 도화지를 만드는 것과 같음.
//				Graphics2D graphic = bt_image.createGraphics(); // 앞서 만든 도화지에 그림을 그릴 수 있도록 하는 과정
//				graphic.drawImage(bo_image, 0, 0, width, heigth, null); // 도화지에 이미지를 그리는 과정 ('그려놓고자 하는 이미지', 'x값', 'y값', '넓이', '높이', 'ImageObserver')
//																  		// ImageObserver는 이미지의 정보를 전달받아서 이미지를 업데이트시키는 역할 (일반적인 경우 null)
//				ImageIO.write(bt_image, "jpg", thumbnailFile); // 제작한 썸네일 이미지(bt_image)를 파일로 만듦 
				
				/* 썸네일 생성 방법 2 : pom.xml에 thumbnailator추가 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				// 비율
				double ratio = 3;
				// 넓이, 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);
				
				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);
				
			} catch (Exception e) {					
				e.printStackTrace();
			}
			
			imageList.add(courseImageDto); // 이미지 정보가 저장된 CourseImageDto객체를 List의 요소로 추가
			
			logger.info("-----------------------------------------------");
			logger.info("파일 이름 : " + multipartFile.getOriginalFilename());
			logger.info("파일 타입 : " + multipartFile.getContentType());
			logger.info("파일 크기 : " + multipartFile.getSize());
		} // 향상된 for
		
		ResponseEntity<List<CourseImageDto>> result = new ResponseEntity<List<CourseImageDto>>(imageList, HttpStatus.OK);
		System.out.println("이미지 업로드 성공");
		
		return result;
		
		// 기본 for
//		for(int i=0; i<uploadFile.length; i++) {
//			logger.info("-----------------------------------------------");
//			logger.info("파일 이름 : " + uploadFile[i].getOriginalFilename());
//			logger.info("파일 타입 : " + uploadFile[i].getContentType());
//			logger.info("파일 크기 : " + uploadFile[i].getSize());			
//		}
	}
	
	/* 강좌 수정 */
	@PostMapping("/course/modify")
	public String courseModify(CourseDto courseDto, Integer page, Integer pageSize, 
								RedirectAttributes rattr, Model m, Authentication auth) {
		String user_id = auth.getName();
		courseDto.setUser_id(user_id);
		
		try {
			if(courseService.coursemodify(courseDto) != 1)
				throw new Exception("Modify failed");
			
			rattr.addAttribute("page", page);
			rattr.addAttribute("pageSize", pageSize);
			rattr.addFlashAttribute("msg", "MOD_OK");
			
			return "redirect:/course/search";
		} catch (Exception e) {
			e.printStackTrace();
			
			m.addAttribute(courseDto);
			
			rattr.addAttribute("page", page);
			rattr.addAttribute("pageSize", pageSize);
			
			m.addAttribute("msg", "MOD_ERR");
			
			return "/course/coursedetail";
		}
	}
	
	/* 강좌 수정 페이지 */
	@GetMapping("/course/modify")
	public String courseModify(Model m, Integer course_id, CourseSearchItem sc) {
		try {
			CourseDto courseDto = courseService.readCourseDetail(course_id);
			List<CourseDto> classroomList = courseService.getcroomId();
			List<CourseDto> typeList = courseService.getCourseType();
			
			m.addAttribute("mode", "modify");
			m.addAttribute(courseDto);
			m.addAttribute("classroomList", classroomList);
			m.addAttribute("typeList", typeList);
			
			// 수정페이지에 queryString을 넘겨주기 위해서
			int totalCnt = courseService.getsearchResultCnt(sc);
			PageResolver pageResolver = new PageResolver(totalCnt, sc);
			m.addAttribute("pr", pageResolver);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/course/coursedetail"; // board.jsp 읽기와 쓰기에 사용. 쓰기에 사용할 때는 mode=new
	}

	/* 강좌 삭제 */
	@PostMapping("/course/remove")
	public String courseRemove(Integer course_id, @RequestParam("user_id")String user_id, Integer page, Integer pageSize
			, RedirectAttributes rattr, Authentication auth, HttpServletRequest request) {
		
		String msg = "DEL_OK";
		System.out.println(request.isUserInRole("ROLE_ADMIN") );
		
		try {
			if(auth.getName().equals(user_id) || request.isUserInRole("ROLE_ADMIN")) {
				List<CourseImageDto> fileList = courseService.getCourseImageList(course_id);
			
				// 강좌 삭제시 서버 내 원본 파일, 썸네일 파일 삭제
				if(fileList != null) {
					List<Path> pathList = new ArrayList();
					
					fileList.forEach(dto -> {
						
						// 원본 이미지
						Path path = Paths.get(dto.getUploadPath(), dto.getUuid() + "_" + dto.getFileName());
						pathList.add(path);
						
						// 썸네일 이미지
						path = Paths.get(dto.getUploadPath(), "s_" + dto.getUuid() + "_" + dto.getFileName());
						pathList.add(path);
					});
					
					pathList.forEach(path -> {
						path.toFile().delete();
					});
				}
			
				if (courseService.courseRemove(course_id) != 1) 
					throw new Exception("Delete failed.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			msg = "DEL_ERR";
		}
		
		rattr.addAttribute("page", page);
		rattr.addAttribute("pageSize", pageSize);
		rattr.addFlashAttribute("msg", msg);

		return "redirect:/course/search";
	}
	
	/* 강좌 등록 */
	@PostMapping("/course/write")
	public String courseWrite(CourseDto courseDto, RedirectAttributes rattr, Model m, Authentication auth) {
		String user_id = auth.getName();
		
		courseDto.setUser_id(user_id);
		logger.info("writePOST........" + courseDto);

		try {
			courseService.courseWrite(courseDto);
			rattr.addFlashAttribute("msg", "WRT_OK");

			return "redirect:/course/search";
		} catch (Exception e) {
			e.printStackTrace();

			m.addAttribute("mode", "new");
			m.addAttribute("courseDto", courseDto);
			m.addAttribute("msg", "WRT_ERR");

			return "/course/coursedetail";
		}

	}

	/* 강좌 등록 페이지 */
	@GetMapping("/course/write")
	public String courseWrite(Model m) {
		m.addAttribute("mode", "new");
		
		try {
			List<CourseDto> classroomList = courseService.getcroomId();
			m.addAttribute("classroomList", classroomList);
			List<CourseDto> typeList = courseService.getCourseType();
			m.addAttribute("typeList", typeList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/course/coursedetail"; // board.jsp 읽기와 쓰기에 사용. 쓰기에 사용할 때는 mode=new
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value = "/course/getCourseImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CourseImageDto>> getCourseImageList(int course_id, Model m) {
		
		logger.info("getCourseImageList........" + course_id);
		
		try {
			return new ResponseEntity(courseService.getCourseImageList(course_id), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity("SELECT_FAIL", HttpStatus.BAD_REQUEST);
		}
	}

	@GetMapping("/course/detail")
	public String coursedetail(CourseSearchItem sc, Integer course_id, Model m) {
		
		try {
			CourseDto courseDto = courseService.readCourseDetail(course_id);
			m.addAttribute(courseDto);

			// 수강신청완료페이지에 queryString을 넘겨주기 위해서
			int totalCnt = courseService.getsearchResultCnt(sc);
			PageResolver pageResolver = new PageResolver(totalCnt, sc);
			m.addAttribute("pr", pageResolver);

			// 리뷰 개수가 0개일 경우 발생하는 NullPointerException으로 인해 추가
			if (courseDto.getReview_cnt() == 0) {
				double rating = 0;
				m.addAttribute("rating", rating);
			} else {
				System.out.println("리뷰개수=" + courseDto.getReview_cnt());
				System.out.println(course_id);
				double rating = courseService.avgReviewRating(course_id);
				System.out.println(rating);
				m.addAttribute("rating", rating);
			}
		} catch (Exception e) {
			System.out.println("catch문 진입");
			e.printStackTrace();
			
			return "redirect:/course/search";
		}

		return "/course/coursedetail";
	}

	@GetMapping("/course/search")
	public String courseSearch(CourseSearchItem sc, Model m) {
		try {
			int totalCnt = courseService.getsearchResultCnt(sc);
			m.addAttribute("totalCnt", totalCnt);

			PageResolver pageResolver = new PageResolver(totalCnt, sc);
			CourseDto courseDto = new CourseDto();

			List<CourseDto> list = courseService.getsearchResultPage(sc);
			m.addAttribute("list", list);
			m.addAttribute("pr", pageResolver);

			System.out.println(list.get(0).toString());
			System.out.println(courseDto.toString());
			System.out.println(sc.toString());
			System.out.println(sc.getQueryString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/course/courseSearch";
	}
}