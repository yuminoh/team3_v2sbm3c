package dev.mvc.order_pay;

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
public class Order_payVO {
    //결재 번호
    private int payno;
    //회원 번호
    private int memberno;
    //결재 타입
    private int paytype;
    //합계
    private int total;
    //결재일
    private String rdate;
    //점포
    private String store;
    //우편번호
    private String zipcode;
    //주소1
    private String address1;
    //주소2
    private String address2;
    //전화번호
    private String tel;
    //코드번호
    private int codeno;
    //카트 번호
    private int cartno;
}
