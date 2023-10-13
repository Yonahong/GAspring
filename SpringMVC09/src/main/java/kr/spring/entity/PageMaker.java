package kr.spring.entity;

import lombok.Data;

@Data
public class PageMaker { // 실제 페이징 해주는 페이징클레스

	//페이징의 설정을 해준 criteria를 갖고있어야 페이징처리를 할 수 있음
	//현재 몇페이지인지, 정보와 게시글을 몇개 볼것인지 현재 페이지에서 몇번 글부터 시작하는지 정보를 가진 객체가 있어야
	//페이징 처리가 가능하다.
	private Criteria cri; 
	
	
	private int totalCount;// 총 게시글의 수 : 총게시글의 수를 알아야 몇페이지가 나오는지 알 수 있음
	
	private int startPage; // 시작페이지 번호
	
	private int endPage; // 끝페이지 번호
	
	private boolean prev; // 이전버튼
	
	private boolean next; // 다음버튼
	
	private int displayPageNum = 5; // 하단의 몇개의 페이지를 보여주는지.
	
	//총게시글의 수를 구하는 메소드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePagein();
	}
	
	public void makePagein() {
		//1. 화면에 보여질 마지막 페이지의 번호
		//  현재 하단에 보여줄 페이지의 개수는 1~10의 10개
		//  현재 7페이지를 본다면 끝페이지는 10, 13페이지를 본다면 끝페이지는 20
		//  현재 페이지가 7일경우 7/10.0 -> 소수 발생 시 반올림 -> 1 * 10 -> 10
		//	현재 페이지가 13일경우 13/10.0 -> 소수 발생 시 반올림 -> 2 * 10 -> 20
		//  ceil은 올림처리를 해준다.
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum); 
		
		//2. 화면에 보여질 시작페이지의 번호
		//  현재 7페이지 -> 10(마지막) - 10(보여줄 페이지 개수) + 1
		startPage = endPage - displayPageNum + 1;
		
		if(startPage <=0) {
			startPage = 1; // 만일 startPage가 0보다 작거나 같다면 1부터 시작
		}
		
		//3. 최종 페이지가 맞는지 유효성 검사
		//실제 글이101개면 10개 페이지 + 1페이지만 더 만들어줘야함
		//마지막페이지 계산.
		//소수점 발생여부를 확인하여 소수점이 있을 경우 
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
				
		//4. 화면에 보여질 마지막 페이지 유효성 체크
		//현재 15페이지를 보고있다면 20페이지까지 보여줘야하는데
		//페이지에 따라 엔드페이지를 조절
		if (tempEndPage < endPage) {
			endPage = tempEndPage; // 마지막 페이지가 실제 페이지수보다 높으면 치환
		}
		
		//5. 이전, 다음 페이지 버튼 존재여부
		//true면 false를 false일 경우 true를 반환
		prev = (startPage == 1) ? false : true ;
 		next = (endPage < tempEndPage) ? true : false;
		
	}
	
}
