package dev.mvc.stock;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
  stocknum INTEGER PRIMARY KEY NOT NULL, -- 재고 번호
  stockno NUMBER(10)   NOT NULL, -- 재고 수량
  productclass VARCHAR(10)   NOT NULL, -- 상품종류 
  productwa NUMBER(10)   NULL, -- 폐기예정 상품 수량
  productst NUMBER(10)   NOT NULL, -- 입고예정 상품 수량
  productno INTEGER NOT NULL, -- 상품 번호(FK)
*/
@Getter @Setter @ToString 
public class StockVO {
    //재고 번호
    private int stocknum;
    //재고 수량
    private int stockno;
    //상품종류
    private String productclass;
    //폐기예정 상품 수량
    private int productwa;
    //입고예정 상품 수량
    private int productst;
    //상품 번호
    private int productno;  
}
