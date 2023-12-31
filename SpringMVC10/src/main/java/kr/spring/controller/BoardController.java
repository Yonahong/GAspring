package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/list")
	public String list(Model model) {
		//게시글 전체 조회
		List<Board> list = boardService.getList(); // 게시글을 리스트형태로 묶어서 가져온다

		model.addAttribute("list",list);
		return "list";
		}
		
	@PostMapping("/register")
	public String register(Board vo) {
		boardService.register(vo);
		return"redirect:/list";
	}
	
	@GetMapping("/get")
	public @ResponseBody Board get(@RequestParam("idx") Long idx) {
		Board vo = boardService.get(idx);
		return vo;
		
	}
	
		
	}
	

