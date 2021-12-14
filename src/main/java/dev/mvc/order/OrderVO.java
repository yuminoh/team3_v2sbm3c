package dev.mvc.order;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
    orderno                             NUMBER(10)       NOT NULL        PRIMARY KEY,
    productno                           NUMBER(10)       NULL ,
    rdate                               DATE         NOT NULL,
    cnt                                 NUMBER(10)       NOT NULL,
    cnttot                              NUMBER(10)       NOT NULL,
    memberno                            NUMBER(10)       NULL 
*/
@Getter @Setter @ToString 
public class OrderVO {
    //주문 번호
    private int orderno;
    //상품 번호
    private int productno;
    //발주일
    private String rdate;
    //수량
    private int cnt;
    //합계
    private int cnttot;
    //회원 번호
    private int memberno;
}
