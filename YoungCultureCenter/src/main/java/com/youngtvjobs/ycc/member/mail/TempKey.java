package com.youngtvjobs.ycc.member.mail;

import java.util.Random;

//인증번호 발송시 사용할 클래스
//이 클래스를 호출할 때는 몇자리 수로 할것인지 정해서 파라미터로 보내면 됨
public class TempKey {

	private boolean lowerCheck;
	private int size;
	
	public TempKey() {
		// TODO Auto-generated constructor stub
	}
	
	public String getKey(int size, boolean lowerCheck) {
		this.size = size;
		this.lowerCheck = lowerCheck;
		return init();
	}

	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;
		do{
			num = ran.nextInt(75) + 48;
			if((num>=48 && num <= 57) || (num>=65 && num <= 90) || (num>=97 && num <= 122)) {
				sb.append((char)num);
			} else {
				continue;
			}
		} while (sb.length() < size);
		if(lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}
}
