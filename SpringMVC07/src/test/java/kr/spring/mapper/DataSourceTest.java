package kr.spring.mapper;

import java.sql.Connection;
import java.util.List;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fasterxml.jackson.databind.Module.SetupContext;

import kr.spring.entity.Board;
import lombok.extern.log4j.Log4j;


@Log4j// 테스트의 실행결과를 콘솔창에 나오게 하기 위함.
@RunWith(SpringJUnit4ClassRunner.class) // 실행하기 위해 스프링 컨테이너에 올리는 코드
@ContextConfiguration({"File:src/main/webapp/WEB-INF/spring/root-context.xml"
               ,"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"}) // root-context.xml의 경로를 잡아주는 과정
@WebAppConfiguration // Servlet 컨테이너를 사용하기 위한 어노테이션
public class DataSourceTest {

   //root-context.xml에 이상이 없는지 test하는 클래스
   
   //커넥션 테스트
   @Autowired
   private DataSource dataSource;
   
   @Autowired
   private BoardMapper mapper;

   @Autowired
   private kr.spring.service.BoardServiceImpl Service;
   
   @Autowired
   private WebApplicationContext ctx; // Spring Container (스프링 모든 객체가 들어있는 공간) 객체
   
   private MockMvc mockMvc; // 가상의 MVC 환경을 만들어주는 객체,뷰,핸들러,맵핑등을 실행해줌
   
   @Before
   public void setup() {
      this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
      
   }

   @Test
   public void testInsert() {
	   Board vo = new Board();
	   vo.setMemID("abc");
	   vo.setTitle("에비에비");
	   vo.setContent("hihi");
	   vo.setWriter("ab");
	   mapper.insertSelectKey(vo);
   }
   
//   @Test
//   public void testController() throws Exception{
//      
//      log.info(
//               mockMvc.perform(MockMvcRequestBuilders.get("/board/List"))//perform->요청
//               .andReturn() // return값을 받아오겠다.
//               .getModelAndView() // controller의 model값과 view경로를 호출
//            );
//      
//   }
   
//   @Test
//   public void testGetList() {
//      
//         List<Board> list = Service.getList();
//         for (Board vo : list) {
//            System.out.println(vo.toString());
//         }
//      
//   }
   
//   테스트는 1개씩만 가능함으로 이전 테스트는 주석처리
//   @Test
//   public void testGetList() {
//      List<Board> list = mapper.getList();
//      for (Board vo : list) {
//         System.out.println(vo.toString());
//      }
//   }
   
//   @Test
//   public void testConnection() {
//      try( Connection conn = dataSource.getConnection() ){
//         log.info(conn);
//      }catch(Exception e) {
//         e.printStackTrace();
//      }
//   }
   
}