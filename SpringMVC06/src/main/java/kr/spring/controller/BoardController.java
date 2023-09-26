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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.entity.Board;
import kr.spring.mapper.BoardMapper;

@Controller // 현재 클래스를 핸들러 맵핑이 찾기 위해 컨트롤러로 등록하는 부분
public class BoardController {
	
	//보드컨트롤러와 마이바티스를 연결해주는것이 보드 매퍼
	@Autowired//
	private BoardMapper mapper;//mybatis에게 jdbc(sql)문을 실행하게 요청하는 객체
	

	@RequestMapping("/boardMain.do") //요청 URL로 들어왔을 떄 아래 기능을 수행하겠다
	
	public String home() {
		System.out.println("게시판 페이지로 이동");
		//리다이렉트를 통해서 보드리스트로 보내줄것임
		return "board/main";
	}
	

}
