package kr.spring.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
//데이터 받는 롬복
@Data

//모든 생성자 받는것
@AllArgsConstructor

//매개변수가 없는 생성자 (기본생성자)
@NoArgsConstructor

//
@ToString
public class Member {
	
	//회원의 정보를 하나로 묶기위한 VO memberVO

	//DB의 컬럼명과 VO의 필드명이 동일해야 mybatis로 가져올 수 있음
	private int memIdx;
	private String memID;
	private String memPassword;
	private String memName;
	private int memAge;
	private String memGender;
	private String memEmail;
	private String memProfile;	
	
	//권한이 여럿일 수 있음으로 리스트를 사용함(어레이사용가능)
	private List<Auth> authList;
}
