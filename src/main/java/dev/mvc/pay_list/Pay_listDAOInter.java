package dev.mvc.pay_list;

import java.util.HashMap;
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
    /**
	   * 구매기록 조회
	   * @param 회원 번호
	   * @return 구매기록
	   */
    public List<Pay_listVO> pay_list(HashMap<String, Object> map);     
    /**
	   * 페이징을 위한 구매내역 수 조회
	   * @param 회원 번호
	   * @return 구매기록의 수
	   */
    public int pay_list_count(int memberno);
}
