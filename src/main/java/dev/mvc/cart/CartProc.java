package dev.mvc.cart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cart.CartProc")
public class CartProc implements CartProcInter {
    @Autowired 
    private CartDAOInter cartDAO;
    
    @Override
    public int create(CartVO cartVO) {
        int cnt = cartDAO.cart_create(cartVO);
        
        return cnt;
    }
    
    @Override
    public List<CartVO> list_by_memberno(int memberno) {
      List<CartVO> list = this.cartDAO.list_by_memberno(memberno);
      return list;
    }
    
    @Override
    public int delete(int productno) {
      int cnt = this.cartDAO.delete(productno);
      return cnt;
    }
    
    @Override
    public int cart_update(CartVO cartVO) {
      int cnt = this.cartDAO.cart_update(cartVO);
      return cnt;
    }

}
