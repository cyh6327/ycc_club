/*	작성자 : alwaysFinn(김지호)
	최초 작성일 : '22. 12. 02
	마지막 업데이트 : '23.01.05
	업데이트 내용 : code clean up
 	기능 : 회원가입 시 보여지는 약관을 관리자가 수정 및 업데이트 할 수 있는 기능으로 DB와 연결됨
*/

package com.youngtvjobs.ycc.admin;

public interface AdminService {
	
	AdminDto select() throws Exception;	//현재 DB에 있는 약관 select 
	int joinTermsUpdate(AdminDto adminDto) throws Exception; //DB에 수정된 약관 update

}
