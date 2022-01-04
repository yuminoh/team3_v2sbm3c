package dev.mvc.products;

import java.util.HashMap;
import java.util.List;

public interface ProductsProcInter {
	/**
	   * 서브카테고리당 상품 조회
	   * @param 서브카테고리 번호, 검색어, 현재페이지
	   * @return 상품 목록
	   */
	public List<ProductsVO> products_list(HashMap<String, Object> map);
	
	public int search_count(HashMap<String, Object> hashMap);
	
	public String pagingBox(int search_count, int now_page, String word);
	
	public int create(ProductsVO productsVO);
}
