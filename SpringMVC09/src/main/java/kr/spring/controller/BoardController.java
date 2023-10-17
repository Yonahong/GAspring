package kr.spring.controller;

import java.awt.print.Pageable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.entity.Board;
import kr.spring.entity.Criteria;
import kr.spring.entity.PageMaker;
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
	
	
	//get과 post 둘 다 사용할 수 있는 request mapping 사용
	@RequestMapping("/List")
	public String boardList(Model model, Criteria cri) {
		//(페이징)페이지 정보를 알고있는 criteria 객체를 service에게 전달
		List<Board> list = service.getList(cri);
		//페이징 처리에 필여한 pagemaker객체도 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri); //page페이커가 페이징 기법을 하기위한 cri객체 전달.
		pageMaker.setTotalCount(service.totalCount(cri)); // 페이징 기법을 하려면 전체 글의 개수 알려
		model.addAttribute("List",list);
		model.addAttribute("pageMaker", pageMaker);
		return "board/List";
	}
	
	@GetMapping("/get") // modelattribute 부분은 model.addattribute(cri)와 같은 역할
	public String get(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		Board vo = service.get(idx);
		model.addAttribute("vo", vo);
		return "board/get";
	}
	
	@PostMapping("/modify")
	public String modify(Board vo, Criteria cri, RedirectAttributes rttr) {
		service.modify(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/List";
	}
	
	@GetMapping("/modify")
	public String modify(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//modify로 요청이 들어오면 해당 글의 idx를 가지고 modify로 갈것이다.
		//get의 상세보기가 동일하게 idx를 기준으로 글을 가져오고있음으로 같은 방식을 활용한다.
		//1회만 저장해서 페이지 이동하는데 사용할것임으로 임시저장인 model을 활용
		Board vo = service.get(idx);
		model.addAttribute("vo",vo);
		return "board/modify";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("idx") int idx, Criteria cri, RedirectAttributes rttr) {
		service.remove(idx);
		//redirect는 모델방식으로 정보를 갖고 갈 수 없기때문에 모달에 사용했던 임시 저장객체인 redirectattributes를 사용
		//criteria를 rttr에 담아서 이동
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/List";
	}
	
	@GetMapping("/reply")
	public String reply(@RequestParam("idx") int idx, Model model, @ModelAttribute("cri") Criteria cri) {
		//get은 해당 인덱스를 가진 board vo를 줌.
		Board vo = service.get(idx);
		model.addAttribute("vo",vo);
		return "board/reply"; 
			
	}
	
	@PostMapping("/reply")
	public String reply(Board vo, Criteria cri, RedirectAttributes rttr) { // 부모글 번호, 작성id, 제목, 답글, 작성자 이름. (board vo)
		service.reply(vo);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/List";
	}
	
	
	
}
