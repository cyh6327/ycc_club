/*	작성자 : alwaysFinn(김지호)
	최초 작성일 : '22. 12. 02
	마지막 업데이트 : '23.01.05
	업데이트 내용 : code clean up
 	기능 : 회원가입 시 보여지는 약관을 관리자가 수정 및 업데이트 할 수 있는 기능으로 dao와 연결됨
*/

package com.youngtvjobs.ycc.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	AdminDao adminDao;

	@Override	//약관 현황 select
	public AdminDto select() throws Exception {
		return adminDao.select();
	}

	@Override	//약관 update
	public int joinTermsUpdate(AdminDto adminDto) throws Exception {
		return adminDao.update(adminDto);
	}
	
	
}
