package dev.mvc.order_detail;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.order_detail.Order_detailProc")
public class Order_detailProc implements Order_detailProcInter {	
	@Autowired
	private Order_detailDAOInter order_detailDAO;
  
  @Override
  public int create(Order_detailVO order_detailVO) {
    int cnt = this.order_detailDAO.create(order_detailVO);
    return cnt;
  }

  @Override
  public List<Order_detailVO> list_by_memberno(HashMap<String, Object> map) {
    List<Order_detailVO> list = null;
    list = this.order_detailDAO.list_by_memberno(map);
    return list;
  } 
  
}

