package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService service;
	//BoardService는 인터페이스이다.
	//BoardServiceImpl를 BoardService로 업캐스팅해서 들어간다.
	//BoardServiceImpl로 autowired를 해도 사용이 가능하지만
	//MemberServiceImpl등의 다른 서비스가 생길 경우
	//부모타입인 BoardService로 받아야 확장성이 좋아지기때문에.
	
	@PostMapping("register")
	public String register(Board vo, RedirectAttributes rttr) {
//		System.out.println(vo.toString());
		service.register(vo);
//		System.out.println(vo.toString());
		rttr.addFlashAttribute("result", vo.getIdx());
		return "redirect:/board/List";
	}
	
	@GetMapping("register")
	public String register() {
		return "board/register";
	}
	
	@GetMapping("/List")
	public String boardList(Model model) {
		List<Board> list = service.getList();
		model.addAttribute("List",list);
		return "board/List";
	}
	
	@GetMapping("/get")
	public String get(@RequestParam("idx") int idx, Model model) {
		Board vo = service.get(idx);
		model.addAttribute("vo", vo);
		return "board/get";
	}
}
