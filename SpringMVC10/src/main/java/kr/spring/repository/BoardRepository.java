package kr.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.entity.Board;

@Repository // 메모리로 올리기 위한 어노테이션(jpa는 인터페이스만 찾기때문에 생략 가능)
public interface BoardRepository extends JpaRepository<Board, Long>{
										// <> -> 테이블명, PK데이터 타입

	
	
}
