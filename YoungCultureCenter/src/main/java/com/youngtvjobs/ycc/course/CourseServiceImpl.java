package com.youngtvjobs.ycc.course;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CourseServiceImpl implements CourseService {
	
	@Autowired
	CourseDao courseDao;
	
	@Override
	public int getsearchResultCnt(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.searchResultCnt(sc);
	}

	@Override
	public List<CourseDto> getsearchResultPage(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.searchSelectPage(sc);
	}

	@Override
	public List<CourseDto> getPage(Map map) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.selectPage(map);
	}

	@Override
	public CourseDto readCourseDetail(Integer course_id) throws Exception {
		CourseDto courseDto = courseDao.courseDetail(course_id);
		return courseDto;
	}

	@Override
	public double avgReviewRating(Integer course_id) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.avgReviewRating(course_id);
	}

	@Override
	public int attendDuplicateCheck(Integer course_id, String user_id) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.attendDuplicateCheck(course_id, user_id);
	}
	
	// 수강신청 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int attendInsert(AttendDto attendDto) throws Exception {
		// 수강신청시 신청인원 +1
		courseDao.updateApplicantCnt(attendDto.getCourse_id(), 1);
		return courseDao.attendInsert(attendDto);
	}

	@Override
	public int readAttendTable(Integer course_id, String user_id) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.selectAttendTable(course_id, user_id);
	}
	
	/* 강좌 등록 */
	@Override
	public void courseWrite(CourseDto courseDto) throws Exception {
		
		courseDao.insert(courseDto);
		
		// 강좌 등록을 할 때 강좌 이미지를 첨부하지 않은 경우
		// 이미지의 존재 여부를 체크하여 Service 단계의 courseWrite() 메서드 조기 종료
		if(courseDto.getImageList() == null || courseDto.getImageList().size() <= 0) return;
		
		// CourseDto의 course_id값을 CourseDto의 imageList 요소에 있는 CourseImageDto의 course_id에 값을 대입
		courseDto.getImageList().forEach(attach -> {
			attach.setCourse_id(courseDto.getCourse_id());
			try {
				// 이미지 등록에 필요로 한 course_id 값을 세팅 해주었기 때문에, Dao단계의 courseImageInsert() 메서드를 호출하고 매개변수로 CourseDto의 imageList 요소를 매개변수로 부여
				courseDao.courseImageInsert(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	
	}
	
	/* 강좌 삭제 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int courseRemove(Integer course_id) throws Exception {
		courseDao.courseImageDelete(course_id);
		return courseDao.delete(course_id);
	}

	/* 강좌 수정 */
	@Override
	public int coursemodify(CourseDto courseDto) throws Exception {
		int result = courseDao.update(courseDto);
		
		if(result == 1 && courseDto.getImageList() != null && courseDto.getImageList().size() > 0) {
			courseDao.courseImageDelete(courseDto.getCourse_id());
			
			// CourseDto의 course_id값을 CourseDto의 imageList 요소에 있는 CourseImageDto의 course_id에 값을 대입
			courseDto.getImageList().forEach(attach -> {
				attach.setCourse_id(courseDto.getCourse_id());
				try {
					// 이미지 등록에 필요로 한 course_id 값을 세팅 해주었기 때문에, Dao단계의 courseImageInsert() 메서드를 호출하고 매개변수로 CourseDto의 imageList 요소를 매개변수로 부여
					courseDao.courseImageInsert(attach);
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
		}
		
		return result;
	}

	@Override
	public List<CourseDto> getcroomId() throws Exception {
		// TODO Auto-generated method stub
		return courseDao.selectCroomId();
	}

	@Override
	public List<CourseDto> getCourseType() throws Exception {
		// TODO Auto-generated method stub
		return courseDao.selectCourseType();
	}

	@Override
	public List<CourseImageDto> getCourseImageList(int course_id) throws Exception {
		// TODO Auto-generated method stub
		return courseDao.getCourseImageList(course_id);
	}

	@Override
	public int courseimageDelete(Integer course_id) throws Exception {
		return courseDao.courseImageDelete(course_id);
	}

}
