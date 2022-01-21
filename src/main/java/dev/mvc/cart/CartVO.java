package dev.mvc.cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
    cartno                             NUMBER(10)       NOT NULL        PRIMARY KEY,
    productno                           NUMBER(10)       NULL ,
    cnt                                 NUMBER(10)       NOT NULL,
    cnttot                              NUMBER(10)       NOT NULL,
    memberno                            NUMBER(10)       NULL 
*/
@Getter @Setter @ToString 
public class CartVO {
    //주문 번호
    private int cartno;
    //상품 번호
    private int productno;
    //수량
    private int cnt;
    //회원 번호
    private int memberno;
    //상품 가격
    private int product_price;
    //상품 이름
    private String productname;
    //상품 이미지 이름
    private String pdimagefile1;
}
