package com.youngtvjobs.ycc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.youngtvjobs.ycc.board.BoardDto;
import com.youngtvjobs.ycc.board.BoardService;
import com.youngtvjobs.ycc.board.SearchItem;

@Controller
//홈페이지 메인 컨트롤러
public class IndexController{
	
	@Autowired
	BoardService boardService;
	//홈페이지 접근
	@GetMapping("/")
	public String index(Model model, SearchItem sc) throws Exception {	
		
		List<BoardDto> nList = boardService.nSearchSelectPage(sc);
		model.addAttribute("nList", nList);
		
		List<BoardDto> eList = boardService.eSearchSelectPage(sc);
		model.addAttribute("eList", eList);
		return "index";
	}
	//찾아오는 길
	@GetMapping("/map")
	public String map()
	{
		return "map_page/map";
	}

}
