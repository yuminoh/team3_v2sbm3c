package dev.mvc.cart;

import java.util.List;

public interface CartProcInter {
    
  //등록
    public int cart_create(CartVO cartVO);
    
    //memberno 회원 번호별 쇼핑카트 목록 출력
    public List<CartVO> list_by_memberno(int memberno);
    
    //상품 삭제
   public int delete(int productno);
   //수량수정
    public int cart_update(CartVO cartVO);
    
}