package dev.mvc.interested_products;

import java.util.List;

import dev.mvc.subcategory.SubCategoryVO;

public interface Interested_productsProcInter {
	 /**
	   * 회원이 관심을 가지는 품목 3개 등록
	   * @param 
	   * @return 
	   */
   public int interested_products_create(Interested_productsVO interested_productsVO);
   
   /**
	   * 회원의 관심상품 삭제
	   * @param 회원번호
	   * @return 
	   */
   public int interested_products_delete(int memberno);
   
   /**
	   * 회원의 관심상품 카운트
	   * @param 회원번호
	   * @return 
	   */
   public int interested_products_count(int memberno);
   
   /**
	   * 회원의 관심상품 읽기
	   * @param 회원번호
	   * @return 
	   */
   public List<SubCategoryVO> interested_products_read_memberno(int memberno);
}
