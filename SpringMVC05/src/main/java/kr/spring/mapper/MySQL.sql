-- SQL 문장 작성


--DROP TABLE BOARD;

CREATE TABLE BOARD(
	IDX INT NOT NULL AUTO_INCREMENT,
	MEMID VARCHAR (20) NOT NULL,
	TITLE VARCHAR (100) NOT NULL,
	CONTENT VARCHAR (2000) NOT NULL,
	WRITER VARCHAR (30) NOT NULL,
	INDATE DATETIME DEFAULT NOW(),
	COUNT INT DEFAULT 0,
	PRIMARY KEY (IDX)
);

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('안뇽','내용이야','이름이고');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('하이','컨텐츠','엔네임');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('봉쥬','쎄콩텐테','놈');

INSERT INTO BOARD(TITLE, CONTENT, WRITER)
VALUES('구텐탁','콘탁스토','네임');

SELECT * FROM BOARD;

-- 회원테이블 --

DROP TABLE MEMBER;


CREATE TABLE MEMBER(
	MEMIDX INT NOT NULL,
	MEMID VARCHAR(20) NOT NULL,
	MEMPASSWORD VARCHAR(68) NOT NULL,
	MEMNAME VARCHAR(20) NOT NULL,
	MEMAGE INT,
	MEMGENDER VARCHAR(20),
	MEMEMAIL VARCHAR(50),
	MEMPROFILE VARCHAR(50),
	PRIMARY KEY(MEMID)
);

--SPRING SECURITY에서는 MEMBER테이블 안에 반드시 권한이 있어야 한다.
-- 사용여부에 관계없이 넣어준다.

DROP TABLE AUTH;

SELECT * FROM AUTH

CREATE TABLE AUTH(
	NO INT NOT NULL AUTO_INCREMENT,
	MEMID VARCHAR(50) NOT NULL,
	AUTH VARCHAR(50) NOT NULL,
	PRIMARY KEY(NO),
	--멤버테이블에 없는 아이디는 권한테이블에 들어갈 수 없음.
	CONSTRAINT FK_MEMBER_AUTH FOREIGN KEY(MEMID)
	REFERENCES MEMBER(MEMID)
)





INSERT INTO MEMBER(MEMID, MEMPASSWORD, MEMNAME, MEMAGE, MEMGENDER, MEMEMAIL, MEMPROFILE)
VALUES('admin','1234','관리자',33,'남자','admin@gmail.com','');

SELECT * FROM MEMBER;

DELETE FROM MEMBER;


