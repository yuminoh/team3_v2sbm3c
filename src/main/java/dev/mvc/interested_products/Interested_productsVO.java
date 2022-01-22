package dev.mvc.interested_products;

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
public class Interested_productsVO {
    //회원 번호
	private int memberno;
	//회원이 흥미를 갖고있는 품목번호
	private int sub_categoryno;
}
