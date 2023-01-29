package com.youngtvjobs.ycc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController
{
	//권한에 맞지 않는 접근
	@RequestMapping("/error/403")
	public String error403()
	{
		return "error/403";
	}
}
