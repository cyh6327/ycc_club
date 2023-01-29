import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.youngtvjobs.ycc.member.MemberDto;
import com.youngtvjobs.ycc.member.MemberService;


import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	
	@Setter(onMethod_= @Autowired)
	private MemberService service;

	
	@Test
	public void testRead() throws Exception {
		MemberDto memberDto = service.read("admin15");
		
		log.info(memberDto);
		
		memberDto.getAuthList().forEach(authDto -> log.info(authDto));
		

	}
}
