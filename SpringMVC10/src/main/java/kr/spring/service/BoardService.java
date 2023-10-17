package kr.spring.service;


import java.util.List;

import kr.spring.entity.Board;

public interface BoardService { // 보드컨트롤러에서 이 보드서비스가 일을 다 하는데 이 보드서비스는 추상메소드이다.
								// 추상메소드는 비어있고 기능등이 없는 메소드인데 일을 할 수 있는 이유는
								// 실질적으로 모든것을 정의해놓은 보드서비스임플인데 임플을 보드컨트롤러에서 오토와이어드로 당겨오고
								

	public List<Board> getList(); // 게시글 전체조회
	
	public void register(Board vo); // 게시글 등록

	public Board get(Long idx);
	
	
	
}
