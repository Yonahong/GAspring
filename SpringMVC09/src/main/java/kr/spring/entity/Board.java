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

public class Board {

	private int idx;
	private String memID;
	private String title;
	private String content;
	private String writer;
	private Date indate;
	private int count;
	
	private int boardGroup;
	private int boardSequence;
	private int boardLevel;
	private int boardAvailable;
	
}
