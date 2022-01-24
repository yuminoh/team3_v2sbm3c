package dev.mvc.notice;

import java.io.File;
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
   * 새로고침 방지
   * 
   * @return
   */
  @RequestMapping(value = "/notice/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward

      return mav; // forward
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
        
        mav.setViewName("/notice/list");      

      
      return mav;
    }  
  
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/notice/read.do", method=RequestMethod.GET )
  public ModelAndView read_ajax(HttpServletRequest request, int noticeno) {
    
    ModelAndView mav = new ModelAndView();

    NoticeVO noticeVO = this.noticeProc.read(noticeno);
    mav.addObject("noticeVO", noticeVO); // request.setAttribute("noticeVO", noticeVO);
    
    // 단순 read
    mav.setViewName("/notice/read"); // /WEB-INF/views/notice/read.jsp
    

    return mav;
  }
  
  /**
   * 상품 정보 수정 폼 사전 준비된 레코드: 관리자 1번, cateno 1번, categrpno 1번을 사용하는 경우 테스트 URL
   * http://localhost:9091/notice/create.do?cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/notice/product_update.do", method = RequestMethod.GET)
  public ModelAndView product_update(int cateno, int noticeno) {
      ModelAndView mav = new ModelAndView();

      NoticeVO noticeVO = this.noticeProc.read(noticeno);

      mav.addObject("noticeVO", noticeVO);

      mav.setViewName("/notice/product_update"); // /views/notice/product_update.jsp
      // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
      // mav.addObject("content", content);

      return mav; // forward
  }

  /**
   * 상품 정보 수정 처리 http://localhost:9091/notice/product_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/notice/product_update.do", method = RequestMethod.POST)
  public ModelAndView product_update(NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();

      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.noticeProc.product_update(noticeVO);

      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

      // 연속 입력 지원용 변수, Call By Reference에 기반하여 noticeno를 전달 받음
      mav.addObject("noticeno", noticeVO.getNoticeno());

      mav.addObject("url", "/notice/msg"); // msg.jsp

      if (cnt == 1) {
          mav.addObject("code", "product_success");
      } else {
          mav.addObject("code", "product_fail");
      }

      mav.setViewName("redirect:/notice/msg.do");

      return mav; // forward
  }
  
  /**
   * 수정 폼
   * http://localhost:9091/notice/update_text.do?noticeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(int noticeno) {
    ModelAndView mav = new ModelAndView();
    
    NoticeVO noticeVO = this.noticeProc.read_update_text(noticeno);
    
    mav.addObject("noticeVO", noticeVO);
    
    mav.setViewName("/notice/update_text"); // /WEB-INF/views/notice/update_text.jsp
    // String content = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("content", content);

    return mav; // forward
  }

  /**
   * 수정 처리
   * http://localhost:9091/notice/update_text.do?noticeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(NoticeVO noticeVO)
                                                   {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("noticeno", noticeVO.getNoticeno());
    map.put("passwd", noticeVO.getPasswd());
    
    int cnt = 0;
    int passwd_cnt = this.noticeProc.passwd_check(map);
    if (passwd_cnt == 1) {
        cnt = this.noticeProc.update_text(noticeVO); // 수정 처리
        
        mav.addObject("noticeno", noticeVO.getNoticeno());
        mav.setViewName("redirect:/notice/read.do");             
    } else {
        mav.addObject("cnt", cnt);
        mav.addObject("code", "passwd_fail");
        mav.setViewName("redirect:/notice/msg.do");
    }

    return mav; // forward
  }
  
  /**
   * 삭제 폼
   * @param noticeno
   * @return
   */
  @RequestMapping(value="/notice/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int noticeno) { 
    ModelAndView mav = new  ModelAndView();
    
    // 삭제할 정보를 조회하여 확인
    NoticeVO noticeVO = this.noticeProc.read(noticeno);
   
    mav.addObject("noticeVO", noticeVO);
 
    mav.setViewName("/notice/delete");  // notice/delete.jsp
    
    return mav; 
  }
  
  /**
   * 삭제 처리 http://localhost:9091/notice/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();
    String uploadDir = this.uploadDir; // 파일 업로드 경로
    
    int noticeno = noticeVO.getNoticeno();
    
    HashMap<String, Object> passwd_map = new HashMap<String, Object>();
    passwd_map.put("noticeno", noticeVO.getNoticeno());
    passwd_map.put("passwd", noticeVO.getPasswd());
    
    int cnt = 0;
    int passwd_cnt = this.noticeProc.passwd_check(passwd_map);
    if (passwd_cnt == 1) { // 패스워드 일치 -> 등록된 파일 삭제 -> 신규 파일 등록
        // -------------------------------------------------------------------
        // 파일 삭제 코드 시작
        // -------------------------------------------------------------------
        // 삭제할 파일 정보를 읽어옴.
        NoticeVO vo = noticeProc.read(noticeno);
//        System.out.println("noticeno: " + vo.getNoticeno());
//        System.out.println("file1: " + vo.getFile1());
        
        String file1saved = vo.getFile1saved();
        String thumb1 = vo.getThumb1();
        long size1 = 0;
        boolean sw = false;
        
        sw = Tool.deleteFile(uploadDir, file1saved);  // Folder에서 1건의 파일 삭제
        sw = Tool.deleteFile(uploadDir, thumb1);     // Folder에서 1건의 파일 삭제
        // System.out.println("sw: " + sw);
        // -------------------------------------------------------------------
        // 파일 삭제 종료 시작
        // -------------------------------------------------------------------
        
        cnt = this.noticeProc.delete(noticeno); // DBMS 삭제
        
        // -------------------------------------------------------------------------------------

        




        mav.addObject("cnt", cnt);
        mav.addObject("code", "passwd_fail");
        mav.setViewName("redirect:/notice/msg.do");
    }
    
    return mav; // forward
  }   
}
