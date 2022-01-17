package dev.mvc.products;

import java.util.HashMap;
import java.util.List;


public interface ProductsDAOInter {
	/**
	   * 서브카테고리당 상품 조회
	   * @param 서브카테고리 번호, 검색어, 현재페이지
	   * @return 상품 목록
	   */
	public List<ProductsVO> products_list(HashMap<String, Object> map);
	
	public int search_count(HashMap<String, Object> hashMap);
	
	public String pagingBox(int search_count, int now_page, String word);
	/**
	   * 상품 등록
	   * @param 상품 정보
	   * @return 등록 성공여부
	   */
	public int create(ProductsVO productsVO);
	/**
	   * 상품 정보 조회
	   * @param 상품번호
	   * @return 상품 정보
	   */
	public ProductsVO product_read(int productno);
	
	/**
	   * 상품 정보 수정
	   * @param 상품정보
	   * @return 수정 성공여부
	   */
	public int product_update(ProductsVO productsVO);
	
	/**
	   * 상품 이미지 수정
	   * @param 이미지 명
	   * @return 수정 성공여부
	   */
	public int product_update_file(HashMap map);
	
	/**
	   * 상품 정보 삭제
	   * @param 상품번호
	   * @return 삭제 성공여부
	   */
	public int product_delete(int productno);
	
	/**
	   * 메인화면에 회원의 추천 상품 출력
	   * @param 회원의 추천 서브카테고리
	   * @return 해당 카테고리의 최신상품 3가지
	   */
	public List<ProductsVO> recommend_products(int sub_categoryno);
}
