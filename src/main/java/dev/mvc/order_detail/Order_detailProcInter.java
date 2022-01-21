package dev.mvc.order_detail;

import java.util.HashMap;
import java.util.List;

public interface Order_detailProcInter{
  /**
   * 등록
   * @param order_itemVO
   * @return
   */
  public int create(Order_detailVO order_itemVO);
  
  /**
   * 회원별 주문 결재 목록
   * @param order_payno
   * @return
   */
  public List<Order_detailVO> list_by_memberno(HashMap<String, Object> map);
  
}

