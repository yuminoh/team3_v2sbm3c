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
}