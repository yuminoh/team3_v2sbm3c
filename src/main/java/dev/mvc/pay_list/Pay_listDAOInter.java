package dev.mvc.pay_list;

import java.util.List;

public interface Pay_listDAOInter {
    //등록
    public int pay_list_create(Pay_listVO pay_listVO);
    /**
	   * 구매기록중 가장 많이 주문한 3개의 서브카테고리 정보 수집
	   * @param 회원 번호
	   * @return 서브카테고리 3종류
	   */
    public List<Pay_listVO> intereste_product_list(int memberno);
}
