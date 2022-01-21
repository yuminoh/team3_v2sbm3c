package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
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
import dev.mvc.uploadtool.Tool;
import dev.mvc.uploadtool.Upload;

@Controller
public class NoticeCont {
  
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProcInter noticeProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  /** 업로드 파일 절대 경로 */
  private String uploadDir = Notice.getUploadDir();
  
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
  
  /**
   * 등록 처리 http://localhost:9091/notice/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();

      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = ""; // 원본 파일명 image
      String file1saved = ""; // 저장된 파일명, image
      String thumb1 = ""; // preview image
      String uploadDir = this.uploadDir; // 파일 업로드 경로
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF'
      // value='' placeholder="파일 선택">
      MultipartFile mf = noticeVO.getFile1MF();

      file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
      // System.out.println("-> file1: " + file1);

      long size1 = mf.getSize(); // 파일 크기

      if (size1 > 0) { // 파일 크기 체크
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
          file1saved = Upload.saveFileSpring(mf, uploadDir);

          if (Tool.isImage(file1saved)) { // 이미지인지 검사
              // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
              thumb1 = Tool.preview(uploadDir, file1saved, 200, 150);
          }

      }

      noticeVO.setFile1(file1);
      noticeVO.setFile1saved(file1saved);
      noticeVO.setThumb1(thumb1);
      noticeVO.setSize1(size1);
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------

      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.noticeProc.create(noticeVO);

      // ------------------------------------------------------------------------------
      // 연속 입력을위한 PK의 return
      // ------------------------------------------------------------------------------
      System.out.println("-> noticeno: " + noticeVO.getNoticeno());
      mav.addObject("noticeno", noticeVO.getNoticeno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------

      if (cnt == 1) {
          mav.addObject("code", "create_success");
          // cateProc.increaseCnt(noticeVO.getCateno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

      // System.out.println("--> cateno: " + noticeVO.getCateno());
      // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장

      // mav.addObject("url", "/notice/msg"); // msg.jsp, redirect parameter 적용

      // 추가적인 상품 정보 입력 유도
      mav.addObject("url", "/notice/msg"); // msg.jsp, redirect parameter 적용

      mav.setViewName("redirect:/notice/msg.do");

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
  
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/notice/read.do", method=RequestMethod.GET )
  public ModelAndView read_ajax(HttpServletRequest request, int noticeno) {
    // public ModelAndView read(int noticeno, int now_page) {
    // System.out.println("-> now_page: " + now_page);
    
    ModelAndView mav = new ModelAndView();

    NoticeVO noticeVO = this.noticeProc.read(noticeno);
    mav.addObject("noticeVO", noticeVO); // request.setAttribute("noticeVO", noticeVO);
    
    // 단순 read
    // mav.setViewName("/notice/read"); // /WEB-INF/views/notice/read.jsp
    
    // 쇼핑 기능 추가
    // mav.setViewName("/notice/read_cookie"); // /WEB-INF/views/notice/read_cookie.jsp
    
    // 댓글 기능 추가 
    mav.setViewName("/notice/read_cookie_reply"); // /WEB-INF/views/notice/read_cookie_reply.jsp

    // 댓글 + 더보기 버튼 기능 추가 
    mav.setViewName("/notice/read_cookie_reply_add"); // /WEB-INF/views/notice/read_cookie_reply_add.jsp

    
    // -------------------------------------------------------------------------------
    // 쇼핑 카트 장바구니에 상품 등록전 로그인 폼 출력 관련 쿠기  
    // -------------------------------------------------------------------------------
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    String ck_id = ""; // id 저장
    String ck_id_save = ""; // id 저장 여부를 체크
    String ck_passwd = ""; // passwd 저장
    String ck_passwd_save = ""; // passwd 저장 여부를 체크

    if (cookies != null) {  // Cookie 변수가 있다면
      for (int i=0; i < cookies.length; i++){
        cookie = cookies[i]; // 쿠키 객체 추출
        
        if (cookie.getName().equals("ck_id")){
          ck_id = cookie.getValue();                                 // Cookie에 저장된 id
        }else if(cookie.getName().equals("ck_id_save")){
          ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
        }else if (cookie.getName().equals("ck_passwd")){
          ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
        }else if(cookie.getName().equals("ck_passwd_save")){
          ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
        }
      }
    }
    
    System.out.println("-> ck_id: " + ck_id);
    
    mav.addObject("ck_id", ck_id); 
    mav.addObject("ck_id_save", ck_id_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);
    // -------------------------------------------------------------------------------
    
    return mav;
  }
}
