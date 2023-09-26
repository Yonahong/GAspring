package kr.spring.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data //겟셋
@AllArgsConstructor //모든생성
@NoArgsConstructor //
@ToString //출력

public class Auth {
	//권한정보를 저장하는 클래스
	private int no; // 일련번호
	private String memID; //회원아이디
	private String auth; //회원권한 (role_user, role_manager, role_admin)
}
