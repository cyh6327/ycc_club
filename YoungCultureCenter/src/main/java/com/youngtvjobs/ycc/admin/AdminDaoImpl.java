/*	작성자 : alwaysFinn(김지호)
	최초 작성일 : '22. 12. 02
	마지막 업데이트 : '23.01.05
	업데이트 내용 : code clean up
 	기능 : 회원가입 시 보여지는 약관을 관리자가 수정 및 업데이트 할 수 있는 기능으로 DB와 연결됨
*/

package com.youngtvjobs.ycc.admin;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace = "com.youngtvjobs.ycc.admin.adminMapper.";
	

	@Override	// DB에서 약관 select
	public AdminDto select() throws Exception {
		return session.selectOne(namespace + "selectAll");
	}


	@Override	// DB로 약관 update
	public int update(AdminDto adminDto) throws Exception {
		return session.update(namespace + "modifyterms", adminDto);
	}

}
