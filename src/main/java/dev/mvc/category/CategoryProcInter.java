package dev.mvc.category;

import java.util.List;

public interface CategoryProcInter {
	/**
	   * 생성
	   * @param 카테고리 정보
	   * @return 성공여부
	   */
	public int category_create(CategoryVO categoryVO);
	
	
	
	/**
	   * 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<CategoryVO> category_list();
	
	/**
	   * 조회
	   * @param 카테고리 번호
	   * @return 카테고리 목록
	   */
	public CategoryVO category_read(int categoryno);
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int category_update(CategoryVO categoryVO);
	
	/**
	   * 삭제
	   * @param 카테고리 번호
	   * @return 삭제 성공여부
	   */
	public int category_delete(int categoryno);
}
