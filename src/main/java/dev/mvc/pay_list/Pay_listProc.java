package dev.mvc.pay_list;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.pay_list.Pay_listProc")
public class Pay_listProc implements Pay_listProcInter {
    @Autowired
    private Pay_listDAOInter pay_listDAO;
    
    @Override 
    public int pay_list_create(Pay_listVO pay_listVO) {
        int cnt = this.pay_listDAO.pay_list_create(pay_listVO);
        return cnt;
    }
    
    /**
	   * 구매기록중 가장 많이 주문한 3개의 서브카테고리 정보 수집
	   * @param 회원 번호
	   * @return 서브카테고리 3종류
	   */
    @Override 
    public List<Pay_listVO> intereste_product_list(int memberno){
    	List<Pay_listVO> interested_products =this.pay_listDAO.intereste_product_list(memberno);
    	return interested_products;
    };
}
