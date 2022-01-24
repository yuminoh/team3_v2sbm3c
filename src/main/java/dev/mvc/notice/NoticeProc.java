package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.uploadtool.Tool;

@Component("dev.mvc.notice.NoticeProc")
  public class NoticeProc implements NoticeProcInter {
    @Autowired
    private NoticeDAOInter noticeDAO;

    @Override
    public int create(NoticeVO noticeVO) {
      int cnt=this.noticeDAO.create(noticeVO);
      return cnt;
    }
    
    @Override
    public List<NoticeVO> list_noticeno_asc() {
      List<NoticeVO> list = this.noticeDAO.list_noticeno_asc();
      for (NoticeVO noticeVO : list) { // 내용이 160자 이상이면 160자만 선택
          String content = noticeVO.getContent();
          if (content.length() > 160) {
              content = content.substring(0, 160) + "...";
              noticeVO.setContent(content);
          }
      }

      return list;
    }
    
    /**
     * 조회
     */
    @Override
    public NoticeVO read(int noticeno) {
        NoticeVO noticeVO = this.noticeDAO.read(noticeno);

        String title = noticeVO.getTitle();
        String content = noticeVO.getContent();

//        title = Tool.convertChar(title); // 특수 문자 처리
//        content = Tool.convertChar(content);

        noticeVO.setTitle(title);
        noticeVO.setContent(content);

        long size1 = noticeVO.getSize1();
        noticeVO.setSize1_label(Tool.unit(size1));

        return noticeVO;
    }
    
    
    @Override
    public int product_update(NoticeVO noticeVO) {
        int cnt = this.noticeDAO.product_update(noticeVO);
        return cnt;
    }
    
    @Override
    public int update_text(NoticeVO noticeVO) {
        int cnt = this.noticeDAO.update_text(noticeVO);
        return cnt;
    }
    
    @Override
    public NoticeVO read_update_text(int noticeno) {
        NoticeVO noticeVO = this.noticeDAO.read(noticeno);
        return noticeVO;
    }
    
    @Override
    public int passwd_check(HashMap<String, Object> map) {
        int cnt = this.noticeDAO.passwd_check(map);
        return cnt;
    }
    
    @Override
    public int delete(int noticeno) {
      int cnt = this.noticeDAO.delete(noticeno);
      return cnt;
    }
    
    @Override
    public int update_recom(int noticeno) {
      int cnt = this.noticeDAO.update_recom(noticeno);
      return cnt;
    }
}