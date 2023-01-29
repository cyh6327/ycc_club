

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import org.junit.Test;

import static org.junit.Assert.assertTrue;

//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.ResultSet;
//import java.sql.SQLException;

public class DBConnectionTestT1
{	
	//데이터베이스 커넥션 테스트
	@Test
	public void springJdbcConnectionTest1() throws SQLException
	{
		ApplicationContext ac = new GenericXmlApplicationContext(
				"file:src/main/webapp/WEB-INF/spring/**/root-context.xml");

		DataSource ds = ac.getBean(DataSource.class);
		// 1) 데이터베이스의 연결을 얻음.
		Connection conn = ds.getConnection();

		// 괄호안의 조건식이 true면 테스트 성공, 아니면 실패
		assertTrue(conn != null);
	}
}
