package kr.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.codec.ByteArrayDecoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Controller // 현재 클래스를 핸들러 맵핑이 찾기 위해 컨트롤러로 등록하는 부분
public class BoardController {
	
	//보드컨트롤러와 마이바티스를 연결해주는것이 보드 매퍼
	@Autowired//
	private BoardMapper mapper;//mybatis에게 jdbc(sql)문을 실행하게 요청하는 객체
	

	@RequestMapping("/") //요청 URL로 들어왔을 떄 아래 기능을 수행하겠다
	
	public String home() {
		System.out.println("홈 기능 수행");
		//리다이렉트를 통해서 보드리스트로 보내줄것임
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardList.do") //요청 URL로 들어왔을 떄 아래 기능을 수행하겠다
	
	public String board(Model model) {
		System.out.println("게시판 목록보기 기능수행");
		
		//전체 게시글 조회 기능을 하는 mapper임
		//게시글은 몇개으 요소를 갖고있음으로 dto로 받아오지만
		//어레이리스트보다는 list로 하는편이 받아온 후의 범용성이 좋다
		//어레이리스트가 list의 자식이기때문
		//게시글 정보 가져오기
		//한개의 게시글은 번호, 제목, 내용, 작성자, 작성일, 조회수
		// 이제 DAO같은걸 통해서 JDBC를 통해서 DB에서 게시물을 가져올것임
		// JDBC 

		
		//전체 게시글 조회기능
		List<Board>list = mapper.getLists();
		
		//객체바인딩 - 동적 바인딩
		model.addAttribute("list",list);

		return "boardList"; // 포워드방식으로 이동
	}
	
	@RequestMapping("/boardForm.do")
	public String boardForm() {
		//boardForm으로 이동만 해주는 매서드
		System.out.println("글쓰기 페이지로 이동");
		
		return "boardForm";
	}
	
	@RequestMapping("/boardInsert.do")
	public String boardInsert(Board board) {
		System.out.println("게시글 등록 기능 구현");
		
		mapper.boardInsert(board);
		
		//이전엔 String title = request.getParameter("title"); 과 같은 형태로 불러왔지만
		//이젠 boardform에 있는 가져올 값이 board에 있는 값과 이름이 동일함으로
		//보드를 통해서 가져온다
		
		//가져올 네임의 값과 보드(bto)에 있는 필드명이 똑같아야하고,
		//디폴트 생성자 @noargsconstructor 기본생성자가 보드(dto)에 있어야한다.
		//위 메서드부분에 board board에서는 String title = request.getParameter("title");와
		//겟터 셋터 역할까지 해주는것임, 이는 스프링의 기능임
		
		//인코딩을 한번만 하면 스프링에서는 추가적으로 인코딩 할 필요 없음.
		// 가져온 값 확인하는 테스트 코드 System.out.println(board.toString());
		
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardContent.do/{idx}")
	//값을 받아오는데 boardVO에 있지 않은 값을 사용하는 경우도 있으니
	//그런 경우를 고려해서 아래의 매개변수에 @requestparam("받아올값이름")으로 받아오고
	// int idx 로 담아준다
	//idx는 하나의 고유한 값을 가짐
	public String boardContent(@PathVariable("idx") int idx, Model model) {
		
		Board vo =mapper.boardContent(idx);
		System.out.println("게시글 상세보기 기능수행");
		// vo 가져온 값 확인용 코드
		//System.out.println(vo.toString());
		
		//조회수 증가코드
		mapper.boardCount(idx);
		
		//임시적으로 모델에 값을 저장함
		model.addAttribute("vo", vo);
		
		return "boardContent";
		
	}
	
	@RequestMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {
		mapper.boardDelete(idx); 
		System.out.println("게시글 삭제 기능 수행");
		
		return "redirect:/boardList.do";

	}

	@RequestMapping("/boardUpdateForm.do/{idx}")
	
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		//이동 시 수정하고싶은 게시글의 idx를 갖고 이동할것임
		System.out.println("게시글 수정화면이동 기능수행");
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo",vo);
		return "boardUpdateForm";
	}
	
	@RequestMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) {
		mapper.boardUpdate(vo);
		return "redirect:/boardList.do";
	}
	
}
