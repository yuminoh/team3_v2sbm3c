package dev.mvc.post;

import java.util.List;

public interface PostProcInter {
	/**
	   * 생성
	   * @param 현재페이지
	   * @return 게시판 목록
	   */
	public int post_create(PostVO postVO);
	/**
	   *조회
	   * @param 
	   * @return 게시판
	   */
    public List<PostVO> post_list();
    
    /**
       * 조회
       * @param 
       * @return 게시판 목록
       */    
	public PostVO post_read(int postno);
	
	/**
	   * 수정
	   * @param PostVO
	   * @return 성공여부
	   */
	public int post_update(PostVO postVO);
	
	/**
	   * 삭제
	   * @param 게시판 번호
	   * @return 수정 성공여부
	   */
	public int post_delete(int postno);
}
