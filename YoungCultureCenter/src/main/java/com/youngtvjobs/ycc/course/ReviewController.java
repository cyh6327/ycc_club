package com.youngtvjobs.ycc.course;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ReviewController {
	
	ReviewService reviewService;
	CourseService courseService;
	
	public ReviewController(ReviewService reviewService, CourseService courseService) {
		// super();
		this.reviewService = reviewService;
		this.courseService = courseService;
	}

	// 수강후기 수정
	@PatchMapping("/course/reviews/{review_id}")
	public ResponseEntity<String> modify(@PathVariable Integer review_id, String user_id , HttpServletRequest request
											, @RequestBody ReviewDto reviewDto, Authentication auth) {
		reviewDto.setUser_id(user_id); // 작성자 id
		reviewDto.setReview_id(review_id); // 작성된 reivew_id
		
		try {
			// '작성자'와 동일한 계정이거나 '관리자'일 경우 수정 가능
			if(auth.getName().equals(user_id) || request.isUserInRole("ROLE_ADMIN")) {
				if(reviewService.modify(reviewDto) != 1) throw new Exception("Update failed.");
			}		
			return new ResponseEntity<String>("MOD_OK", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("MOD_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 수강후기 삭제
	@DeleteMapping("/course/reviews/{review_id}")
	public ResponseEntity<String> remove(@PathVariable Integer review_id, Integer course_id, String user_id, HttpServletRequest request
														, ReviewDto reviewDto, Authentication auth) {
		reviewDto.setUser_id(user_id); // 작성자 id
		
		try {
			int rowCnt = reviewService.reviewDelete(review_id, course_id);
			System.out.println(rowCnt);
			
			// '작성자'와 동일한 계정이거나 '관리자'일 경우 삭제 가능 + review_cnt 감소
			if(auth.getName().equals(user_id) || request.isUserInRole("ROLE_ADMIN")) {
				if(rowCnt != 1) throw new Exception("Delete Failed");
			}
			
			return new ResponseEntity<String>("DEL_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("DEL_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 수강후기 작성
	@PostMapping("/course/reviews")
	public ResponseEntity<String> write(@RequestBody ReviewDto reviewDto, Integer course_id
											, Authentication auth, RedirectAttributes rattr){
		String user_id = auth.getName();
		Date nowdate = new Date();
		
		reviewDto.setUser_id(user_id);
		reviewDto.setCourse_id(course_id);
		
		System.out.println("reviewDto" + reviewDto);
		
		try {
			CourseDto courseDto = courseService.readCourseDetail(course_id);
			// 수강신청(attend) 테이블에 있을 경우에만 작성 가능하게 구현
			if(courseService.attendDuplicateCheck(course_id, user_id) == 1) {
				// 수강마감일부터 후기 작성 가능 (일일강좌는 수강후기 다음날 작성 가능)
				if(courseDto.getCourse_end_date().before(nowdate) == true) {
					if(reviewService.reviewWrite(reviewDto) != 1) {
						throw new Exception("write failed");
					}
				} else {
					System.out.println("수강마감일이 아닙니다. 수강마감일부터 작성하실 수 있습니다.");
					rattr.addFlashAttribute("msg", "NOT_PASS_DEADLINE");
					return new ResponseEntity<String>("NOT_PASS_DEADLINE", HttpStatus.OK);
				}
			} else {
				System.out.println("수강생이 아닙니다.");
				rattr.addFlashAttribute("msg", "NOT_STUDENT");
				return new ResponseEntity<String>("NOT_STUDENT", HttpStatus.OK);
			}
			return new ResponseEntity<String>("WRT_OK", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	// 수강후기 select
	@GetMapping("/course/reviews")
	@ResponseBody
	public ResponseEntity<List<ReviewDto>> list(Integer course_id){
		List<ReviewDto> list = null;
		
		try {
			// list라는 빈 리스트에 불러온 reviewList를 담아서 출력 
			list = reviewService.selectReviewList(course_id); 
			System.out.println("list = " + list); 
			return new ResponseEntity<List<ReviewDto>>(list, HttpStatus.OK); 
			
		} catch (Exception e) {
			e.printStackTrace(); 
			return new ResponseEntity<List<ReviewDto>>(HttpStatus.BAD_REQUEST); 
		}
	}
}
