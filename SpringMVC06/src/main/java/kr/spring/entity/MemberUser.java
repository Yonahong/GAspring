package kr.spring.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
public class MemberUser extends User{

	//Spring security에 Member 객체를 담을 수 있게 해주는 클래스
	//시큐리티 자체 로그인 후 로그인에 성공한 아이디를 가져오는데,
	//
	
	private Member member;
	
	//컬렉션은 배열형태의 권한을 가져오기 위해서 필요함.
	public MemberUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		//부모에 있는 생성자 (super), memberuser 객체 생성 시 아이디, 비밀번호, 권한을 입력받는다.
		//회원가입에는 이름, 나이, 성별, 이메일 등이 필요함으로
		//실제로 이 생성자를 사용하지는 않을것임.
		//하지만 추상메소드라서 반드시 구현해야함으로 구현한것임.
		
		super(username, password, authorities);
	}
	
	//실제로 사용할 생성자를 아래에 생성
	public MemberUser(Member mvo) {
		//user클래스의 생성자를 사용해서 구현한다.
		//위와 동일하게 아이디, 비밀번호, 권한을 넣어주는데, 이런 구조를 갖춰야
		//사용이 가능하기 떄문임.
		//user클래스의 생성자가 사용하는 권한 정보는
		//collection<simplegrantedauthority>로 변경해서 넣어줘야함.
		//.stream으로 바이트로 변경해주고,
		//.map이라는 메서드로 auth를 new simplegrantedauthority 로 변경해줌
		//컬렉션 형태의 변형을 해주는 작업이고 이는 람다식으로 알고있으면 됨
		//List<Auth> -> Collection 안에 들어갈 수 있게 변경하고
		//최종 콜렉션으로 저장
		
		super(mvo.getMemID(),mvo.getMemPassword(), mvo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		this.member = mvo; //나머지 주석처리를 위해 사용함.
	}
	
	
}
