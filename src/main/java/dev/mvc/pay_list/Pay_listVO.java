package dev.mvc.pay_list;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
payno                    
memberno               
paytype                  
total                          
rdate                  
store                          
zipcode                            
address1                           
tel                               
codeno                            
cartno                              
address2                           
*/

@Getter @Setter @ToString
public class Pay_listVO {
    //결재 번호
    private int payno;
    //회원 번호
    private int memberno;  
    //주문수량
    private int cnt;
    //결재일
    private Date rdate;
    //상품명
    private String productname;
    //상품번호
    private int Productno ;
    //상품가격
    private int product_price;
    //카테고리 번호
    private int categoryno;
    //서브카테고리 번호
    private int sub_categoryno;
    //관심순위
    private int rank;
}
