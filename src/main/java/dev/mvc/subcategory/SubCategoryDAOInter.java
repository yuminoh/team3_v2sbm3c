package dev.mvc.subcategory;

import java.util.HashMap;
import java.util.List;

import dev.mvc.category.CategoryVO;

public interface SubCategoryDAOInter {
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
	public SubCategoryVO sub_category_read(int subcategoryno);
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int sub_category_update(SubCategoryVO subcategoryVO);
	
	/**
	   * 카테고리당 서브카테고리 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_list_bycategory(HashMap<String, Object> map);
	
	/**
	   * 서브카테고리 전체 조회
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
	   * 전체 서브 카테고리 중 검색어를 포함한 데이터 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count(HashMap<String, Object> map);
	
	/**
	   * 카테고리당 서브 카테고리 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count_bycategory(HashMap<String, Object> map);
	
	public String pagingBox(int search_count, int now_page, String word);
}
