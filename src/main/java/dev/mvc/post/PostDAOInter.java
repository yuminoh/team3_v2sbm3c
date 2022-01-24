package dev.mvc.post;

import java.util.HashMap;
import java.util.List;


public interface PostDAOInter {
    /**
     * 생성
     * @param postVO 
     * @return 성공여부
     */
  
  public int post_create(PostVO postVO);
  
  /**
     * 조회
     * @param 
     * @return 재고 목록
     */
  public List<PostVO> post_list();
  
  /**
     * 조회
     * @param 재고 번호
     * @return 재고 목록
     */
  public PostVO post_read(int postno);
  
  /**
     * 수정
     * @param postVO
     * @return 성공여부
     */
  public int post_update(PostVO postVO);
  
  /**
     * 삭제
     * @param 재고 번호
     * @return 삭제 성공여부
     */
  public int post_delete(int postno);
}
