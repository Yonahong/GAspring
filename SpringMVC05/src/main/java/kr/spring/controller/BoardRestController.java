package kr.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

// 앞으로 게시글 관련 요청할떄는
// /board/하고싶은 기능요청 url
// 시작점에 모두 /board/를 넣어놓을것임
// ex) 게시글보기 : /board/boardList.do
// ex2) 게시글삭제 : /board/boardDelete.do

@RequestMapping("/board")
@RestController
public class BoardRestController {
	//RestController
	//비동기 방식의 일만 처리하는 컨트롤러
	//레스트 전송방식을 처리할 수 있다.
	//요청url+전송방식(상태)을 묶어서 처리 가능
	//사용 이유 - url의 통일성 및 단순화
	
	@Autowired
	private BoardMapper mapper;
	
	//비동기방식임을 선언하는 responsebody가 꼭 있어야함
	//하지만 rest컨트롤러에서는 비동기방식이 기본이기에 필요없음
	
	//아래처럼 리퀘스트매핑을 겟매핑으로 하면 요청방식을 확인해서
	//get방식으로 요청을 해야지만 게시글을 볼 수 있게 제한한다.
	@GetMapping("/all")
	public  List<Board> boardList() {
		System.out.println("게시글 전체보기 수행");
		//게시글 정보 받아오기
		//게시글이니까 확장성을 고려해서 리스트로 만든다
		
		//모델에 담아서 jsp를 주는것이 아니라 list라는 데이터 자체를 돌려줌
		
		List<Board> list = mapper.getLists();
		return list;
	}
	
	@PostMapping("/new")
	//아래로 저자,제목,내용 3가지의 내용을 가져올것인데 이를 Board board로 입력받음
	//보드/보드인설트.두 가 너무 기니까 /new라는 키워드로 매핑값을 요즘은 많이 줌
	//게시글 입력은 get방식으로 하면 주소가 너무 길어지기 때문에 post방식으로 받아준다
	//방법은 동일하게 getmapping처럼 postmapping을 사용
	public  void boardInsert(Board board) {
		System.out.println("게시글작성수행");
		mapper.boardInsert(board);
		
	}
	
	@GetMapping("/{idx}")
	//하나의 게시글을 가져올것이라 리턴타입은 보드
	public Board boardContent(@PathVariable("idx") int idx) {
		//하나의 게시글 불러오는 매퍼
		System.out.println("게시글 상세보기");
		Board vo = mapper.boardContent(idx);
		return vo;
	}
	
	@DeleteMapping("/{idx}")
	public  void boardDelete(@PathVariable("idx") int idx) {
		//내부 삭제기능을 통해서만 삭제가 가능하고 단순 주소창에 입력하는걸로는 삭제가 안됨
		System.out.println("게시글 삭제 기능 수행");
		mapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	//풋방식의 비동기방식 요청일때만 리퀘스트바디를 넣어줌
	public  void boardUpdate(@RequestBody Board vo) {
		System.out.println("게시글 업데이트 수행");
		mapper.boardUpdate(vo);
	}
	
	@PutMapping("/count/{idx}")
	public void boardCount(@PathVariable("idx") int idx) {
		System.out.println("조회수 증가");
		mapper.boardCount(idx);
	}
	
}

	

