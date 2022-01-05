package dev.mvc.products;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
    cartno                             NUMBER(10)       NOT NULL        PRIMARY KEY,
    productno                           NUMBER(10)       NULL ,
    rdate                               DATE         NOT NULL,
    cnt                                 NUMBER(10)       NOT NULL,
    cnttot                              NUMBER(10)       NOT NULL,
    memberno                            NUMBER(10)       NULL 
*/
@Getter @Setter @ToString 
public class ProductsVO {
    private int productno;
    private String productname;
    private int categoryno;
    private int sub_categoryno;
    private int product_price;
    private String product_Explanation;
    private Date pddate;
    private String pdimagefile1;
    private String pdimagefile1saved;
    private String pdimagefile2;
    private String pdimagefile3;
    private MultipartFile file1M1;
    private MultipartFile file1M2;
    private MultipartFile file1M3;
}
