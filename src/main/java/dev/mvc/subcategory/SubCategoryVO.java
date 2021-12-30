package dev.mvc.subcategory;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
    sub_categoryno NUMBER(15) NOT NULL PRIMARY KEY, --서브 카테고리 번호
	sub_categoryname VARCHAR(40) NOT NULL, -- 서브 카테고리 이름
	categoryno INT NOT NULL,  --(FK) 카테고리 이름
   	FOREIGN KEY (categoryno) REFERENCES pd_category (categoryno)
*/
@Getter @Setter @ToString 
public class SubCategoryVO {
	//카테고리번호
	private int categoryno;
    //서브카테고리번호
    private int sub_categoryno;
    //서브카테고리 이름
    private String sub_categoryname;  
}
