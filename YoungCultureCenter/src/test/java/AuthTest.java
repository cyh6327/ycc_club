import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.ParseException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml" })
public class AuthTest {

	@Setter(onMethod_ = @Autowired)
	private DataSource ds;

	@Test
	public void testInsertAuth() throws ParseException {

		String sql = "insert into user_auth(user_id, auth) values (?,?)";

		for (int i = 0; i <= 20; i++) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);

				if (i < 10) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(2, "ROLE_MEMBER");

				} else if (i < 15) {
					pstmt.setString(1, "Inst" + i);
					pstmt.setString(2, "ROLE_INST");

				} else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(2, "ROLE_ADMIN");

				}

				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
					}
				}
			}

		}
	}

}
