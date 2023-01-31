package com.youngtvjobs.ycc.club;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ClubController
{
	
	@Autowired
	ClubService clubService;
	ClubDto clubDto;

	@GetMapping("/club")
	public String clubMain(HttpServletRequest request, Model m, Authentication auth) {
		
		try {
			List<ClubDto> cList = clubService.getClubList();
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
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "club/clubmain";
	}
	
	@PostMapping("/club/create")
	public String createClub(HttpServletRequest request, Authentication auth) {
		
		String club_title = request.getParameter("club_title");
		System.out.println("club_title = " + club_title);
		
		String club_info = request.getParameter("club_info");
		System.out.println("club_info = " + club_info);
		
		String club_master_id = auth.getName(); 
	    System.out.println("club_master_id = " + club_master_id);
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("club_title", club_title);
	    map.put("club_info", club_info);
	    map.put("club_master_id", club_master_id);
	    
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

	@RequestMapping("/club/board")
	public String clubBoard(HttpServletRequest request, Model m, Authentication auth, SearchItem sc,
			@RequestParam("club_id") String str) {
		
		Integer club_id = Integer.parseInt(str);
		String user_id = auth.getName(); 
		
		try {
			List<ClubDto> clubSelect = clubService.clubSelect(club_id);
			m.addAttribute("clubSelect", clubSelect);
			System.out.println("clubSelect = " + clubSelect);
			
			List<ClubDto> myClubList = clubService.getMyClub(user_id);
		    m.addAttribute("myClubList", myClubList);
		    
		    int totalCnt = clubService.clubSelect(club_id).get(0).getCount();
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
		String user_id = auth.getName(); 
		m.addAttribute("user_id", user_id);
		
		try {
			List<ClubDto> postSelect = clubService.postSelect(club_article_id);
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
			List<ClubDto> postSelect = clubService.postSelect(club_article_id);
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
		
		// html태그 제거 => 모든 태그가 제거되서 줄바꿈도 적용안되므로 다시 수정해야됌
		club_article_content = club_article_content.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		
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
		//club_article_content = club_article_content.replaceAll("\r\n", "<br>");
		club_article_content = club_article_content.replaceAll("<(/)?([a-zA-Z]*)(\\\\s[a-zA-Z]*=[^>]*)?(\\\\s)*(/)?>", "");
		System.out.println("club_article_content2 = " + club_article_content);
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
	
}
