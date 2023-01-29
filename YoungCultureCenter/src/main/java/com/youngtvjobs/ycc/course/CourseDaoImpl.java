package com.youngtvjobs.ycc.course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CourseDaoImpl implements CourseDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.course.courseMapper.";
	
	@Override
	public int searchResultCnt(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + "searchResultCnt", sc);
	}
	@Override
	public List<CourseDto> searchSelectPage(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "searchSelectPage", sc);
	}
	@Override
	public int deleteAll() throws Exception {
		// TODO Auto-generated method stub
		return session.delete(namespace + "deleteAll");
	}
	@Override
	public int insert(CourseDto courseDto) throws Exception {
		// TODO Auto-generated method stub
		return session.insert(namespace + "insert", courseDto);
	}
	@Override
	public List<CourseDto> selectPage(Map map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectPage", map);
	}
	@Override
	public CourseDto courseDetail(Integer course_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + "selectCourseDetail", course_id);
	}
	@Override
	public int updateReviewCnt(Integer course_id, int cnt) throws Exception {
		Map map = new HashMap();
		map.put("cnt", cnt);
		map.put("course_id", course_id);
		
		return session.update(namespace + "updateReviewCnt", map);
	}
	@Override
	public double avgReviewRating(Integer course_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + "avgReviewRating", course_id);
	}
	@Override
	public int attendDuplicateCheck(Integer course_id, String user_id) throws Exception {
		Map map = new HashMap();
		map.put("user_id", user_id);
		map.put("course_id", course_id);
	
		return session.selectOne(namespace + "attendDuplicateCheck", map);
	}
	@Override
	public int attendInsert(AttendDto attendDto) throws Exception {
		// TODO Auto-generated method stub
		return session.insert(namespace + "attendInsert", attendDto);
	}
	@Override
	public int updateApplicantCnt(Integer course_id, int cnt) throws Exception {
		Map map = new HashMap();
		map.put("cnt", cnt);
		map.put("course_id", course_id);
		
		return session.update(namespace + "updateApplicantCnt", map);
	}
	@Override
	public int selectAttendTable(Integer course_id, String user_id) throws Exception {
		Map map = new HashMap();
		map.put("user_id", user_id);
		map.put("course_id", course_id);
		
		return session.selectOne(namespace + "selectAttendTable", map);
	}
	@Override
	public int delete(Integer course_id) throws Exception {
		
		return session.delete(namespace + "delete", course_id);
	}
	@Override
	public int update(CourseDto courseDto) throws Exception {
		// TODO Auto-generated method stub
		return session.update(namespace + "update", courseDto);
	}
	@Override
	public List<CourseDto> selectCroomId() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectCroomId");
	}
	@Override
	public List<CourseDto> selectCourseType() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectCourseType");
	}
	@Override
	public int courseImageInsert(CourseImageDto courseImageDto) throws Exception {
		// TODO Auto-generated method stub
		return session.insert(namespace + "imageInsert", courseImageDto);
	}
	@Override
	public List<CourseImageDto> getCourseImageList(int course_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectCourseImage", course_id);
	}
	@Override
	public int courseImageDelete(int course_id) throws Exception {
		// TODO Auto-generated method stub
		return session.delete(namespace + "deleteImageAll", course_id);
	}
	
}





















