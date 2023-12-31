package kr.spring.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.spring.entity.Auth;
import kr.spring.entity.Member;
import kr.spring.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	private MemberMapper Mapper;
	
	
	//메모리에 올려있는 bean을 가져와서 사용할 때 autowired
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		return "member/joinForm";
	}

	
	@RequestMapping("/registerCheck.do")
	//이 메소드는 비동기방식이고, 현 컨트롤러는 레스트 컨트롤러가 아닌 일반 컨트롤러임으로
	//리스폰스바디 responsebody를 써줘야 비동기방식으로 인식한다.
	//조인폼에서 레지스터체크라는 함수로 1 혹은 0인 값을 받아서 중복체크를 해줄것임으로
	//int값으로 수신한다.
	public @ResponseBody int registerCheck(@RequestParam("memID") String memID) {
		//db 연결을 위한 mapper가 필요하고
		//board xml또한 필요하다.
		//member mapper 따로 만듦
		
		//해당 유저의 정보를 모두 가져오고 그 안에 데이터가 없으면
		//다시말해 member m이 null일 경우 아이디가 없음으로 사용이 가능하고
		//member m 이의 값이 있을경우 아이디를 사용 불가능하다.
		Member m = Mapper.registerCheck(memID);
		
		if (m != null || memID.equals("")) {
			return 0;
		}else {
			return 1;
		}
	}
	@RequestMapping("/join.do")
		//
		public String join(Member m, RedirectAttributes rttr, HttpSession session) {
		System.out.println("회원가입 기능 요청");
		
		
		
		//회원가입 유효성 검사
		
		//회원가입을 할 수 없는 경우. 누락치가 있기 때문.
		
		//join.do 는 id만 입력할 때는 
			if(m.getMemID() == null || m.getMemID().equals("")
				|| m.getMemPassword() == null || m.getMemPassword().equals("")
				|| m.getMemName() == null || m.getMemName().equals("")
				|| m.getMemAge() == 0
				|| m.getMemEmail() == null || m.getMemEmail().equals("")
				|| m.getAuthList().size() == 0
				) {
			
				// 실패시 join.FOrm.do로 msgType과 msg 내용을 보내야함.
				//msgType : 실패메세지, msg : 모든 내용을 입력하시오.
				//RedirectAttributes - 리다이렉트 방식으로 이동할 때 보낼 데이터를 저장하는 객체
			
				rttr.addFlashAttribute("msgType", "실패메세지");
				rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
				
				return "redirect:/joinForm.do";
				
		
			}else {
				
				m.setMemProfile("");
				
				//비밀번호 암호화코드
				
				//pwencoder는 이미 만들어진것이고 위에 autowired로 땡겨와(주입)서 사용하는것임.
				//security config에 bean으로 만들어져있음.
				String encyPw = pwEncoder.encode(m.getMemPassword());
				m.setMemPassword(encyPw);
				//아래 cnt는 회원가입성공여부 판단이고 1이면 성공으로 볼것임.
				int cnt = Mapper.join(m);
				
				//권한 테이블에 회원의 권한을 저장
				//하나의 권한은 하나의 Auth VO로 묶을 수 있음
				//auth에는 아이디, 권한, 번호등의 정보가 있고
				//권한에 대한 내용들은 member m 에 있음.
				//가진 리스트의 갯수만큼 반복하며 리스트에서 하나씩 꺼낼것임
				List<Auth>list = m.getAuthList();
				for(Auth auth : list) {
					if(auth.getAuth() != null) {
						//권한값이 있을때만 권한테이블에 값을 넣음.
						//예를들어 admin 권한을 줄때 0과 1의 자리에 값을 비워둬야하기때문
						Auth saveVO = new Auth();
						saveVO.setMemID(m.getMemID());
						saveVO.setAuth(auth.getAuth());
						//권한 저장
						Mapper.authInsert(saveVO);
						
					}
				}
				
				System.out.println(encyPw);
				
				if(cnt == 1) {
					System.out.println("회원가입 성공");
					rttr.addFlashAttribute("msgType", "성공메세지");
					rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
					//회원가입 성공 시 로그인 처리까지 시키기
					
					//회원가입 성공 시 회원정보+권한정보 가져오기.
					Member mvo = Mapper.getMember(m.getMemID());
					
					
					
					session.setAttribute("mvo", mvo);
					
					//회원가입에 성공한 정보는 위의 m에 저장되어있음
					//세션을 통해서 처리할 것임.
					//스프링에서 리퀘스트객체가 없음으로 
					return "redirect:/";
				}else {
					System.out.println("회원가입 실패");
					rttr.addFlashAttribute("msgType", "실패메세지");
					rttr.addFlashAttribute("msg", "회원가입에 실패했습니다.");
					return "redirect:/joinForm.do";
				}
				
			}
		
		//여러가지 정보를 하나로 묶어서 조인폼에서 보여줌
		//그럼으로 맴버 vo로 묶어서 받아올 수 있음
		
		//프로파일 부분에 NULL을 넣지 않기 위해서 아래의 코드를 진행

	
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/loginForm.do")
	public String loginFormString() {
		return "member/loginForm";
	}
	
	@RequestMapping("/login.do")
	public String login(Member m, HttpSession session, RedirectAttributes rttr) {
		Member mvo = Mapper.login(m);
			if(mvo != null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {
				
					//비밀번호 일치여부 체크(sql 쿼리문으로는 암호화가 되어있기때문에 비교가 불가함)
					//암호화할때 사용했던 pwencoder를 사용해서 복호화
					//앞에는 입력한 값, 뒤에는 암호화된 값이 들어가서 동일한지를 판단함
				
					rttr.addFlashAttribute("msgType", "성공메세지");
					rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
					session.setAttribute("mvo",mvo);
					return "redirect:/";
				
				
			}else {
				rttr.addFlashAttribute("msgType", "실패메세지");
				rttr.addFlashAttribute("msg", "로그인에 실패했습니다.");
				return "redirect:/loginForm.do";
			}
	}
	
	@RequestMapping("/updateForm.do")
	public String updateForm() {
		return "member/updateForm";
	}
	
	@RequestMapping("/update.do")
	public String update(Member m, RedirectAttributes rttr, HttpSession session) {
		System.out.println(m.toString());
		System.out.println("회원수정 기능 요청");
		m.setMemProfile(m.getMemProfile());
		//mapper의 update메소드를 통해 해당 회원의 정보를 수정하시오
		
		// 입력 안한 데이터가 있을 시 updateFOrm.jsp로 돌려보내면서 updateForm.jsp에서
		// 모든 내용을 입력하세요 라는 모달창.
		if(m.getMemPassword() == null || m.getMemPassword().equals("")
				|| m.getMemName() == null || m.getMemName().equals("")
				|| m.getMemAge() == 0
				|| m.getMemEmail() == null || m.getMemEmail().equals("")
				|| m.getAuthList().size() == 0) 
			{
			// 실패시 updateFOrm.Form.do로 msgType과 msg 내용을 보내야함.
			//msgType : 실패메세지, msg : 모든 내용을 입력하시오.
			//RedirectAttributes - 리다이렉트 방식으로 이동할 때 보낼 데이터를 저장하는 객체
		
			rttr.addFlashAttribute("msgType", "실패메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요");
			
			return "redirect:/updateForm.do";
			
			}else {
				
				//Member mvo = (Member)session.getattribute("mvo")
				//m.setMemProfile(mvo.getMemProfile())
				
			//업데이트 시 입력된 암호에 대한 암호화가 필요함
			String EncyPw = pwEncoder.encode(m.getMemPassword());
			m.setMemPassword(EncyPw);
			
			//권한삭제
			Mapper.authDelete(m.getMemID());
			
			//삭제한 권한 다시 부여
			List<Auth>list = m.getAuthList();
			for(Auth auth : list) {
				if(auth.getAuth() != null) {
					//권한값이 있을때만 권한테이블에 값을 넣음.
					//예를들어 admin 권한을 줄때 0과 1의 자리에 값을 비워둬야하기때문
					Auth saveVO = new Auth();
					saveVO.setMemID(m.getMemID());
					saveVO.setAuth(auth.getAuth());
					//권한 저장
					Mapper.authInsert(saveVO);
					
				}
			}
				
			int cnt = Mapper.update(m);
			
			if(cnt == 1) {
				System.out.println("회원수정 성공");
				rttr.addFlashAttribute("msgType", "성공메세지");
				rttr.addFlashAttribute("msg", "회원수정에 성공했습니다.");
				
				//
				Member info = Mapper.getMember(m.getMemID());
				
				//회원가입 성공 시 로그인 처리까지 시키기
				session.setAttribute("mvo", info);
				//회원가입에 성공한 정보는 위의 m에 저장되어있음
				//세션을 통해서 처리할 것임.
				//스프링에서 리퀘스트객체가 없음으로 
				return "redirect:/";
			}else {
				System.out.println("회원수정 실패");
				rttr.addFlashAttribute("msgType", "실패메세지");
				rttr.addFlashAttribute("msg", "회원수정에 실패했습니다.");	
				return "redirect:/updateForm.do";
			}
			
		}

}

	@RequestMapping("/imageForm.do")
	public String imageForm() {
		// 별다른 기능 없이 이미지폼 페이지로 이동만 시켜줌.
		return"member/imageForm";
	}
	
	@RequestMapping("/imageUpdate.do")
	public String imageUpdate(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
		
		//파일 업로드를 할수 있게 해주는 객체 (cos.jar)
		//파일 업로드 할 수 있게 도와주는 멀티파트리퀘스트 객체 생성을 위해선
		//5개의 정보가 필요
		//요청데이터, 저장경로, 최대크기, 인코딩방식, 파일명 중복제거여부
		MultipartRequest multi = null;
		
		String savePath = request.getRealPath("resources/upload");
		
		//이미지 최대크기
		int fileMaxSize = 10 * 1024 * 1024 * 10;
		
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (IOException e) {
			e.printStackTrace();
		}
		//기존 유저의 이미지 삭제
		// - 로그인한 사람의 기존 프로필 값 가져와야함
		//세션 안의 값 가져올땐 겟어트리뷰트
		String memID = ((Member)session.getAttribute("mvo")).getMemID();
		
		//getMember 메소드는 memID와 일치하는 회원의 정보(Member)를 가져온다.
		String oldImg = Mapper.getMember(memID).getMemProfile();
		
		//기존의 프로필 사진 삭제
		//파일이 있는곳은 세이브페스안에 있음
		File oldFile = new File(savePath+"/"+oldImg);
			if(oldFile.exists()) {
				oldFile.delete();
			}
		
		//내가 업로드한 파일 가져오기
			
		File file = multi.getFile("memProfile");
		
		if(file != null) {
			//업로드가 되어있는 상태
			//System.out.println(file.getName());
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			ext = ext.toUpperCase();
			System.out.println(ext);
			
			if(!(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG"))) {
				if(file.exists()) {
					file.delete();
					rttr.addFlashAttribute("msgType", "실패메세지");
					rttr.addFlashAttribute("msg", "PNG, JPG, GIF 파일만 등록이 가능합니다.");	
					return "redirect:/imageForm.do";
				}
			}
			
		}
		
		
		
		

		

		
		//업로드한 파일의 이름만 가져오는 코드
		String newProfile = multi.getFilesystemName("memProfile");
		
		Member mvo = new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		
		Mapper.profileUpdate(mvo);
		
		//사진 업데이트 시 수정된 회원정보를 다시 가져와서 세션에 담는다
		Member m = Mapper.getMember(memID);
		session.setAttribute("mvo", m);
		
		rttr.addFlashAttribute("msgType", "성공메세지");
		rttr.addFlashAttribute("msg", "프로필 이미지 변경 성공");	
		return "redirect:/";
		
	}
	
	
	
	
	
	
}