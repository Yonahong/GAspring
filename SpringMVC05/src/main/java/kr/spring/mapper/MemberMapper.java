package kr.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.entity.Board;
import kr.spring.entity.Member;

@Mapper // mybatis가 interface를 찾기 위해 달아주는 주소
//인터페이스는 자바인데 자바를 수정하면 컴파일을 다시 해서 서버에 다시 올려 로딩을 해야함
//xml파일은 메모장에서도 수정이 가능함 별도 컴파일이 필요 없고 파일에 대한 수정만 해주면 됨으로
//이 페이지는 자바임으로 여기서 처리하지 않고 xml파일로 다시 보내서 진행함.
public interface MemberMapper {

	public Member registerCheck(String memID);

	public int join(Member m);
	
	public Member login(Member m);

	public int update(Member m);

	public void profileUpdate(Member mvo);

	public Member getMember(String memID);


	

}
