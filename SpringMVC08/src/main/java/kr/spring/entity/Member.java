package kr.spring.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor // mybatis 필수 vo로 묶어줌
@AllArgsConstructor
@ToString

public class Member {

	private String memID;
	private String memPwd;
	private String memName;
	private String memPhone;
	private String memAddr;
	private String latitude;
	private String longitude;
}
