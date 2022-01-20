package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;


@Controller
public class NoticeCont {
  
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProcInter noticeProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public NoticeCont() {
    System.out.println("-> NoticeCont created.");
  }
  
  /**
   * 등록폼
   * 사전 준비된 레코드: 관리자 1번, genreno 1번, noticegrpno 1번을 사용하는 경우 테스트 URL
   * http://localhost:9091/notice/create.do?genreno=1
   * 
   * @return
   */
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/create"); // /webapp/WEB-INF/views/notice/create.jsp

    if (this.memberProc.isAdmin(session)) { // 관리자인지 확인
        List<MemberVO> list = memberProc.list();
        mav.addObject("list", list);

        mav.setViewName("/notice/create"); // /webapp/WEB-INF/views/member/list.jsp
       
      } else if(this.memberProc.isMember(session)) { // 일반회원 일때
        mav.addObject("url", "/member/admin_need");
        
        mav.setViewName("redirect:/member/msg.do");     
      } else { // 비회원 일때
        mav.addObject("url", "/member/login_need"); // login_need.jsp, redirect parameter 적용
        
        mav.setViewName("redirect:/member/msg.do");      
      }
      
      
      return mav;
    }  
  
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.POST)
  public ModelAndView create(NoticeVO noticeVO) { // noticeVO 자동 생성, Form -> VO
      // NoticeVO noticeVO <FORM> 태그의 값으로 자동 생성됨.
      // request.setAttribute("noticeVO", noticeVO); 자동 실행

      ModelAndView mav = new ModelAndView();

      int cnt = this.noticeProc.create(noticeVO); // 등록 처리
      // cnt = 0; // error test
      
      mav.addObject("cnt", cnt);
     
      if (cnt == 1) {
          // System.out.println("등록 성공");
          
          // mav.addObject("code", "create_success"); // request에 저장, request.setAttribute("code", "create_success")
          // mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
          
          // response.sendRedirect("/notice/list.do");
          mav.setViewName("redirect:/notice/list.do");
      } else {
          mav.addObject("code", "create_fail"); // request에 저장, request.setAttribute("code", "create_fail")
          mav.setViewName("/notice/msg"); // /WEB-INF/views/notice/msg.jsp
      }

      return mav; // forward
  }
  
  // http://localhost:9091/notice/list.do
  @RequestMapping(value="/notice/list.do", method=RequestMethod.GET )
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    List<NoticeVO> list = this.noticeProc.list_noticeno_asc();
    
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    if (this.memberProc.isAdmin(session)) { // 관리자인지 확인, 관리자 이면 admin_list 

        mav.setViewName("/notice/admin_list"); // /webapp/WEB-INF/views/notice/list.jsp
       
      } else { // 관리자가 아니라면 일반 목록
        
        mav.setViewName("/notice/list");      
      }
      
      return mav;
    }  
  
}
