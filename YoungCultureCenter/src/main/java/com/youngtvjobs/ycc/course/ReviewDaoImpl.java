package com.youngtvjobs.ycc.course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.course.courseReviewMapper.";
	
	@Override
	public List<ReviewDto> selectAll(Integer course_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + "selectAll", course_id);
	}

	@Override
	public int insert(ReviewDto reviewDto) throws Exception {
		// TODO Auto-generated method stub
		return session.insert(namespace + "insert", reviewDto);
	}

	@Override
	public int delete(Integer review_id) throws Exception {
		
		return session.delete(namespace + "delete", review_id);
	}

	@Override
	public int update(ReviewDto reviewDto) throws Exception {
		// TODO Auto-generated method stub
		return session.update(namespace + "update", reviewDto);
	}

	@Override
	public int courseReviewCnt(CourseSearchItem sc) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + "courseReviewCnt", sc);
	}

}
