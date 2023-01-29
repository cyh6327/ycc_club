package com.youngtvjobs.ycc.common;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class YccMethod
{

	
	
	/**세션의 권한 체크
	 * 
	 * @param grade
	 * 		세션과 비교하고 싶은 권한을 직접 주입합니다.
	 * @param request
	 * 		세션 속에 있는 grade 를 받아올겁니다.
	 * @return
	 * 		세션이 없거나 등급이 다르면 FALSE 반환합니다.
	 */
	public static boolean permissionCheck(String grade, HttpServletRequest request) throws Exception
	{
		HttpSession session = request.getSession(false);
		//주의 : eqauls 사용 시 null값을 비교하는 값이 있으면 Nullpoint Exception 뜨고 500 ERROR로 뱉음.
		return session.getAttribute("grade") == null ? false : session.getAttribute("grade").equals(grade);
	}
	
	// Date--> String 형변환
	public static String date_toString(Date date) {
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		String str_to_date = sdFormat.format(date);
		return str_to_date;	
	}
	
	// String --> Date 형변환
	public static Date str_toDate(String strDate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date type_date = sdf.parse(strDate);

		return type_date;
	}
}
