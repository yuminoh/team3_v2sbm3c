package dev.mvc.notice;

import java.util.HashMap;
import java.util.List;


public interface NoticeDAOInter {
  /**
   * 등록
   * @param noticeVO
   * @return
   */
  public int create(NoticeVO noticeVO);
  
  /**
   * 등록 순서별 목록
   * @return
   */
  public List<NoticeVO> list_noticeno_asc();
  
  /**
   * 조회
   * @param contentsno
   * @return
   */
  public NoticeVO read(int contentsno);
}