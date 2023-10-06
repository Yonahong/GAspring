package kr.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.spring.entity.Board;
import kr.spring.entity.Member;
import kr.spring.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<Board> getList() {
		// 게시글 전체모록 가져오기 기능
		List<Board> list = mapper.getList();
		
		return list;
	}

	@Override
	public Member login(Member vo) {
		
		Member mvo = mapper.login(vo);
		return mvo;
	}

	@Override
	public void register(Board vo) {
		mapper.insertSelectKey(vo);
	}

	@Override
	public Board get(int idx) {
		// 서비스이고 db 관련된 업무는 mapper로 진행을 함
		// mapper는 서버단쪽 이름으로 많이 사용함
		// mapper에는 register를 주로, 읽어오는것을 read로 많이 사용함
		Board vo = mapper.read(idx);
		return vo;
	}

	@Override
	public void modify(Board vo) {
		mapper.update(vo);
		
	}

	@Override
	public void remove(int idx) {
		mapper.delete(idx);
	}

	@Override
	public void reply(Board vo) {
		//답글 만들기
		//vo : 부모글 번호, 로그인id, 제목, 답글, 작성자명
		//부모글 정보 호출
		Board parent = mapper.read(vo.getIdx());
		
		//부모글의 boardGroup의 값을 답글 vo에 저장
		vo.setBoardGroup(parent.getBoardGroup());
		
		//시퀀스와 레벨은 부모글에 + 1 
		vo.setBoardSequence(parent.getBoardSequence()+1);
		vo.setBoardLevel(parent.getBoardLevel()+1);
	
		//현재 넣으려는 답글을 제외한 기존 같은 그룹의 댓글은 시퀀스를 1 올려준다.
		mapper.replySeqUpdate(parent);
		
		//답글 저장
		mapper.replyInsert(vo);
		
		
	}

	
	

}
