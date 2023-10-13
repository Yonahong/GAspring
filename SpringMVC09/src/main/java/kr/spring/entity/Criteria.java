package kr.spring.entity;

import lombok.Data;

@Data
public class Criteria { // 척도라는 뜻
	
	//검색기능에 필요한 변수 (리스트에서 받아옴)
	private String type; // 이름,제목,내용중 어느 타입인지를 지정
	private String keyword; // 검색내용

	private int page; // 현재 페이지 번호 저장변수
	
	private int perPageNum; // 한페이지에 보여줄 게시글의 개수
	
	//Criteria 기본 셋팅 생성자를 통해서 하기
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5;
		
	}
	
	
	//현재 페이지 게시글의 시작번호를 구하는 메소드
	// 1page -> 0~9 2page -> 10~19 3page -> 20~29
	//예외 : mysql에서는 시작값을 0으로 인식
	
	//글이 몇번 글부터 시작되겠냐
	public int getPageStart() {
		return(page-1)*perPageNum;
	}
	
	
}
