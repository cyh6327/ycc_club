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
		
		String user_id = auth.getName(); 
		m.addAttribute("user_id", user_id);
	    System.out.println("user_id = " + user_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("user_id", user_id);
		
		try {
			
			List<ClubDto> cList = clubService.getClubList(sc);
			m.addAttribute("cList", cList);
			System.out.println("cList = " + cList);
			
			List<ClubDto> pClubList = clubService.getPopularClub();
			m.addAttribute("pClubList", pClubList);
			System.out.println("pClubList = " + pClubList);
		    
		    List<ClubDto> myClubList = clubService.getMyClub(map);
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
	

	@GetMapping("/club/myClubList")
	public String myClubList(Authentication auth, Model m, SearchItem sc) {
		
		String user_id = auth.getName(); 
		m.addAttribute("user_id", user_id);
		
		int totalCnt;
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("user_id", user_id);
	    map.put("pageSize", sc.getPageSize());
	    map.put("offset", sc.getOffset());
		
		try {
		    List<ClubDto> myClubList = clubService.getMyClub(map);
		    m.addAttribute("myClubList", myClubList);
		    
		    totalCnt = clubService.getMyClub(map).get(0).getCount();
		    PageResolver pageResolver = new PageResolver(totalCnt, sc);
		    m.addAttribute("totalCnt", totalCnt);
			m.addAttribute("pr", pageResolver);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "club/myClubList";
	}
	
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
			
			List<ClubDto> myClubList = clubService.getMyClub(map);
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
	public String viewClubPost(HttpServletRequest request, Model m, Authentication auth, SearchItem sc,
			@RequestParam("club_article_id") String str) {
		
		Integer club_article_id = Integer.parseInt(str);
		System.out.println("club_article_id = " + club_article_id);
		String user_id = auth.getName(); 
		m.addAttribute("user_id", user_id);
		
		Map<String, Object> map = new HashMap<String, Object>();
	    map.put("user_id", user_id);
		
		try {
			ClubDto postSelect = clubService.postSelect(club_article_id);
			m.addAttribute("postSelect", postSelect);
			System.out.println("postSelect=" + postSelect);
		
			List<ClubDto> commentSelect = clubService.selectClubComment(club_article_id);
			m.addAttribute("commentSelect", commentSelect);
			System.out.println("commentSelect=" + commentSelect);
		 
			List<ClubDto> myClubList = clubService.getMyClub(map);
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
	
	// PutMapping?????? ???????????? ???
	@PostMapping("club/board/edit") 
	public String updateClubPost(HttpServletRequest request, Model m, RedirectAttributes re) {
		
		String club_article_title = request.getParameter("post_title");
		String club_article_content = request.getParameter("post_content");
		String str = request.getParameter("club_article_id");
		String str2 = request.getParameter("club_id");
		Integer club_article_id = Integer.parseInt(str);
		System.out.println("club_article_id" + club_article_id);
		// redirect??? /club/board/view??? ??????????????? ??????
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
	
	// DeleteMapping?????? ???????????? ???
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
			// insert??? ???????????? club_article_id ??? ?????????
			String key = map.get("keyNum").toString();
			
			// redirect??? /club/boar/view??? ??????????????? ??????
			re.addAttribute("club_id", str);
		 	re.addAttribute("club_article_id", key);
		 	return "redirect:/club/board/view";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    return "club/club_board";
	}
	
	/* ?????? ?????? ????????? */
	@PostMapping(value = "club/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ClubDto> uploadAjaxActionPOST(MultipartFile uploadFile) {
		
		logger.info("uploadAjaxActionPOST..........");
		
		// view?????? ???????????? ??????(uploadFile)
		File checkfile = new File(uploadFile.getOriginalFilename());
		String type = null;  //MIME TYPE??? ????????? ??????
		try {
			// probeContentType() : ??????????????? ???????????? ????????? MIME TYPE??? ?????????(Stirng) ??????????????? ?????????
			type = Files.probeContentType(checkfile.toPath());
			logger.info("MIME TYPE : " + type);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(!type.startsWith("image")) {
			// ?????? ?????? ????????? ????????? ????????? ?????? ????????? ResponseEntity<ClubImgDto>?????? ????????? ?????? ??????
			ClubDto clubDto = null;
			return new ResponseEntity<>(clubDto, HttpStatus.BAD_REQUEST);	//?????? ?????? 400
		}
		
		String uploadFolder = "C:\\upload";
		
		//?????? ???????????? ????????? ????????? ???????????? ??????????????? ?????? ????????? ???????????? ?????? ???????????? ????????? ??? ?????? ????????? ?????????
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
		Date date = new Date();	//????????? ?????? ?????????
		String str = sdf.format(date);
		
		/* '-'??? ?????? ???????????? '/'(?????????) ?????? '\'(?????????)??? ???????????? ?????? replace ????????? ??????
		File.separator: ???????????? ??????(?????????, ?????????, ...)??? ?????? ?????? ?????? ?????? ???????????? ???????????? */
		String datePath = str.replace("-", File.separator);
		
		/* ?????? ?????? => "c://upload//yyyy//MM//dd" ????????? ??????????????? ???????????? ?????? File ????????? ?????????
		new File(?????? ??????, ?????? ??????) */
		File uploadPath = new File(uploadFolder, datePath);
		
		// ????????? ?????? ???????????? ???????????? ????????? ???????????? ????????? ???????????? ?????? ??????
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();	//???????????? ????????? ???????????? ?????????
		}
		
		/* ????????? ?????? ?????? */
		ClubDto clubDto = new ClubDto();
		
		/* ?????? ??????. ???????????? ???????????? ?????? ????????? ????????? */
		String uploadFileName = uploadFile.getOriginalFilename();
		clubDto.setFile_name(uploadFileName);
		clubDto.setUpload_path(datePath);
		
		/* uuid(?????? ?????? ?????????) ?????? ?????? ?????? 
		 * UUID ????????? ???????????? toString??? ?????? String?????? ?????? */
		String uuid = UUID.randomUUID().toString();
		clubDto.setUuid(uuid);
		
		// ?????? ?????? ????????? uploadFileName ????????? "UUID_?????? ??????" ????????? ????????? ?????????
		uploadFileName = uuid + "_" + uploadFileName;
		
		/* ?????? ??????, ?????? ????????? ?????? File ?????? */
		File saveFile = new File(uploadPath, uploadFileName);
		
		
		try {
			/* ?????? ??????. transferTo() ?????? */
			uploadFile.transferTo(saveFile);
			
			/* thumbnailaotor ?????????????????? ????????? ????????? ?????? ??? ?????? */
			File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
			
			BufferedImage bo_image = ImageIO.read(saveFile);

				//?????? 
				double ratio = 5;
				//?????? ??????
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);					
			
			Thumbnails.of(saveFile)
	        .size(width, height)
	        .toFile(thumbnailFile);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		logger.info("?????? ?????? : " + uploadFile.getOriginalFilename());
		logger.info("?????? ?????? : " + uploadFile.getContentType());
		logger.info("?????? ?????? : " + uploadFile.getSize());
		
		ResponseEntity<ClubDto> result = new ResponseEntity<ClubDto>(clubDto, HttpStatus.OK);
		
		return result;
		
	}
	
	@PostMapping("/club/deleteImage")
	public ResponseEntity<String> deleteImage(String fileName) {
		
		logger.info("deleteImage()........" + fileName);
		
		File file = null;
		
		try {
			/* ????????? ?????? ?????? */
			// view?????? ?????? UTF-8????????? ???????????????(fileName)??? ?????????
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			/* ?????? ?????? ?????? */
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
			// ResponseEntity??? Response??? header??? ????????? ????????? ????????? ??????????????? ?????? ?????? ??????
			HttpHeaders header = new HttpHeaders();
			// header??? 'Content Type' ?????? ?????? ????????? ?????? MIME TYPE??? ??????
			header.add("Content-type", Files.probeContentType(file.toPath()));
			// copyToByteArray(file): ??????????????? ???????????? File ??????(=?????? ??????)??? ???????????? Byte ????????? ?????????
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
