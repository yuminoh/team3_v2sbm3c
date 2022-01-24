package dev.mvc.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Component("dev.mvc.post.PostProc")
public class PostProc implements PostProcInter {
    @Autowired 
    private PostDAOInter postDAO;
    /**
     * 생성
     * @param 
     * @return 성공여부
     */
  public int post_create(PostVO postVO) {
      int cnt = this.postDAO.post_create(postVO);
      return cnt;
  };
  /**
     * 조회
     * @param 
     * @return 목록
     */
  public List<PostVO> post_list(){
      List<PostVO> list = this.postDAO.post_list();
      return list;
  };
  /**
     * 조회
     * @param 
     * @return  목록
     */
  public PostVO post_read(int postno) {
      PostVO postVO = this.postDAO.post_read(postno); 
      return postVO;
  };
  
  /**
     * 수정
     * @param postVO
     * @return 성공여부
     */
  public int post_update(PostVO postVO) {
      int cnt = this.postDAO.post_update(postVO);
      return cnt;
  };
  
  /**
     * 삭제
      * @param
      * @return 삭제 성공여부
     */
  public int post_delete(int postno) {
      int cnt = this.postDAO.post_delete(postno);
      return cnt; 
  };
}
