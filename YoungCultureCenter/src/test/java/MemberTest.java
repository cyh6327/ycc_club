import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.text.ParseException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})

@Log4j
public class MemberTest {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
	@Test
	public void testInsertMember() throws ParseException {
		
		//not null 컬럼만 insert 
		String sql =  "insert into tb_user(user_id, user_pw, user_name, user_gender, "
				+ "user_birth_date,user_email, user_phone_number,user_postcode, user_rNameAddr, user_regdate ,user_grade) "
				+ "values (?,?,?,?,?,?,?,?,?,?,?)";
		
	

        
		for(int i = 0; i<= 20; i++) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con =   ds.getConnection();
				pstmt = con.prepareStatement(sql);
			
				pstmt.setString(2, pwencoder.encode("pw" + i));
				
				//user_birth_date String -> Date로 형변환
				Date dateStr = Date.valueOf(1995 +"-"+ 02 +"-"+ 22);
//				System.out.println(dateStr);
//				System.out.println(dateStr.getClass().getName());
				
				
				if (i<10) {
					pstmt.setString(1, "user"+i);
					pstmt.setString(3, "회원"+i);
					pstmt.setString(4, "F");
					pstmt.setDate(5, dateStr);
					pstmt.setString(6, "user"+i+"@gmail.com");
					pstmt.setString(7, "01012345678");
					pstmt.setString(8, "06611");
					pstmt.setString(9, "서울특별시 서초구 서초대로77길 55");
					pstmt.setDate(10, new Date(System.currentTimeMillis()));
					pstmt.setString(11, "일반회원");
				} else if (i < 15){
					pstmt.setString(1, "Inst"+i);
					pstmt.setString(3, "강사"+i);
					pstmt.setString(4, "F");
					pstmt.setDate(5,  dateStr);
					pstmt.setString(6, "user"+i+"@gmail.com");
					pstmt.setString(7, "01012345678");
					pstmt.setString(8, "06611");
					pstmt.setString(9, "서울특별시 서초구 서초대로77길 55");
					pstmt.setDate(10, new Date(System.currentTimeMillis()));
					pstmt.setString(11, "강사");
				} else {
					pstmt.setString(1, "admin"+i);
					pstmt.setString(3, "관리자"+i);
					pstmt.setString(4, "F");
					pstmt.setDate(5, dateStr);
					pstmt.setString(6, "user"+i+"@gmail.com");
					pstmt.setString(7, "01012345678");
					pstmt.setString(8, "06611");
					pstmt.setString(9, "서울특별시 서초구 서초대로77길 55");
					pstmt.setDate(10, new Date(System.currentTimeMillis()));
					pstmt.setString(11, "관리자");
				}
				
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					}catch (Exception e) {}
				}if(con != null) {
					try {
						con.close();
					}catch (Exception e) {}
				}
			}
			
		}
	}
}
