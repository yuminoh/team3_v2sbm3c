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
}