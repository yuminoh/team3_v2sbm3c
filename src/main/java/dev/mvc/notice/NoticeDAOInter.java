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
   * 모든 목록
   * @return
   */
  public List<NoticeVO> list_all();
  
  
  /**
   * 조회
   * @param contentsno
   * @return
   */
  public NoticeVO read(int contentsno);
  
  /**
   * 상품 정보 수정 처리
   * 
   * @param noticeVO
   * @return
   */
  public int product_update(NoticeVO noticeVO);
  
  /**
   * 텍스트 정보 수정
   * @param noticeVO
   * @return
   */
  public int update_text(NoticeVO noticeVO);
  
  /**
   * 패스워드 체크
   * @param map
   * @return
   */
  public int passwd_check(HashMap<String, Object> map);
  
  /**
  * 삭제
  * @param noticeno
  * @return
  */
 public int delete(int noticeno);
 
 /**
  * 추천수 증가
  * @param noticeno
  * @return
  */
 public int update_recom(int noticeno);
}