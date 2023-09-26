package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;

@Mapper // mybatis가 interface를 찾기 위해 달아주는 주소
//인터페이스는 자바인데 자바를 수정하면 컴파일을 다시 해서 서버에 다시 올려 로딩을 해야함
//xml파일은 메모장에서도 수정이 가능함 별도 컴파일이 필요 없고 파일에 대한 수정만 해주면 됨으로
//이 페이지는 자바임으로 여기서 처리하지 않고 xml파일로 다시 보내서 진행함.
public interface BoardMapper {

	//방식1. 어노테이션 과 sql문을 표기해서 진행
	//방식2. 보드매퍼에 sql문을 쓰지 않고 xml파일로 따로 sql문을 보관한다.
	
	public List<Board> getLists(); //게시글 전체 보기 기능을 수행

	//이전엔 들어갈 값을 모르는 값을 ?로 표현했는데 이제는 #{TITLE}과 같은 형태로 불러오면
	//보드에 있는 title 등을 알아서 가져옴
	//아래 board board는 매개변수임.
	public void boardInsert(Board board);

	
	//아래 값으로 가져옴
	public Board boardContent(int idx);
	
	public void boardDelete(int idx);
	
	public Board boardUpdate(int idx);

	//별다른 값은 안돌려줌으로 void지만 값은 돌려줘야함으로
	public void boardUpdate(Board vo);

	public void boardCount(int idx);
}
