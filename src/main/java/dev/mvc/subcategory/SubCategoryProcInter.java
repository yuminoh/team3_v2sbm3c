package dev.mvc.subcategory;

import java.util.HashMap;
import java.util.List;

public interface SubCategoryProcInter {
	/**
	   * 생성
	   * @param CategoryVO 
	   * @return 성공여부
	   */
	public int sub_category_create(SubCategoryVO subcategoryVO);
	
	/**
	   * 조회
	   * @param 카테고리 번호
	   * @return 카테고리 목록
	   */
	public SubCategoryVO sub_category_read(int categoryno);
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int sub_category_update(SubCategoryVO subcategoryVO);
	
	/**
	   * 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_list(HashMap<String, Object> map);
	
	/**
	   * 삭제
	   * @param 카테고리 번호
	   * @return 삭제 성공여부
	   */
	public int sub_category_delete(int subcategoryno);
	
	/**
	   * 검색어를 포함한 데이터 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count(HashMap<String, Object> map);
}
