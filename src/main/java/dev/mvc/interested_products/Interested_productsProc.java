package dev.mvc.interested_products;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.subcategory.SubCategoryVO;

@Component("dev.mvc.interested_products.Interested_productsProc")
public class Interested_productsProc implements Interested_productsProcInter {
    @Autowired 
    private Interested_productsDAOInter Interested_productsDAO;
    
    /**
	   * 회원이 관심을 가지는 품목 3개 등록
	   * @param 
	   * @return 
	   */
    public int interested_products_create(Interested_productsVO interested_productsVO) {
    	int cnt = this.Interested_productsDAO.interested_products_create(interested_productsVO);
    	return cnt;
    }
 
    /**
	   * 회원의 관심상품 삭제
	   * @param 회원번호
	   * @return 
	   */
    public int interested_products_delete(int memberno) {
    	int cnt = this.Interested_productsDAO.interested_products_delete(memberno);
    	return cnt;
    }
    
    /**
	   * 회원의 관심상품 카운트
	   * @param 회원번호
	   * @return 
	   */
    public int interested_products_count(int memberno) {
	 	int count =this.Interested_productsDAO.interested_products_count(memberno);
	 	return count;
    }
    /**
	   * 회원의 관심상품 읽기
	   * @param 회원번호
	   * @return 
	   */
    public List<SubCategoryVO>  interested_products_read_memberno(int memberno) {
    	List<SubCategoryVO>  list =this.Interested_productsDAO.interested_products_read_memberno(memberno);
	 	return list;
    }
}
