package kr.spring.service;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.entity.Board;
import kr.spring.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardRepository boardRepository;

	@Override
	public List<Board> getList() {
		List<Board> list = boardRepository.findAll();
		return list;
	}

	@Override
	public void register(Board vo) {

		//아래 코드가 알아서 idx, indate 등을 알아서 맞춰서 넣어준다.
		boardRepository.save(vo);
		
	}

	@Override
	public Board get(Long idx) {
		Optional<Board> vo = boardRepository.findById(idx);
		return vo.get();
		
	}

}
