/*	작성자 : alwaysFinn(김지호)
	최초 작성일 : '22. 12. 02
	마지막 업데이트 : '23.01.05
	업데이트 내용 : code clean up
 	내용 : DB와 연결 
*/

package com.youngtvjobs.ycc.admin;

import java.util.Objects;

public class AdminDto {
	
	private String join_terms; //이용 약관
	private String join_privacy_terms; //개인정보 약관
	
	public AdminDto() {	// 기본 생성자
		// TODO Auto-generated constructor stub
	}
	
	
	public AdminDto(String join_terms, String join_privacy_terms) {
		super();
		this.join_terms = join_terms;
		this.join_privacy_terms = join_privacy_terms;
	}

	public String getJoin_terms() {
		return join_terms;
	}
	public void setJoin_terms(String join_terms) {
		this.join_terms = join_terms;
	}	
	public String getJoin_privacy_terms() {
		return join_privacy_terms;
	}
	public void setJoin_privacy_terms(String join_privacy_terms) {
		this.join_privacy_terms = join_privacy_terms;
	}


	@Override
	public int hashCode() {
		return Objects.hash(join_privacy_terms, join_terms);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AdminDto other = (AdminDto) obj;
		return Objects.equals(join_privacy_terms, other.join_privacy_terms)
				&& Objects.equals(join_terms, other.join_terms);
	}


	@Override
	public String toString() {
		return "AdminDto [join_terms=" + join_terms + ", join_privacy_terms="
				+ join_privacy_terms + "]";
	}

}
