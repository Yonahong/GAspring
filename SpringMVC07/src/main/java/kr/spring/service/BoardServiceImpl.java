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



	
	

}
