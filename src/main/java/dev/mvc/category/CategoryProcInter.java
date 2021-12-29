package dev.mvc.category;

import java.util.HashMap;
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
	public List<CategoryVO> category_list(HashMap<String, Object> map);
	
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
	/**
	   * 검색어를 포함한 데이터 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count(HashMap<String, Object> map);
	
	public String pagingBox(int search_count, int now_page, String word);
}
