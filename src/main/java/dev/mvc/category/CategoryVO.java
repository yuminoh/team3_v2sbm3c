package dev.mvc.category;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
    categoryno INT NOT NULL PRIMARY KEY,  --카테고리 번호
	categoryname VARCHAR(20) NOT NULL  --카테고리 이름
*/
@Getter @Setter @ToString 
public class CategoryVO {
    //카테고리번호
    private int categoryno;
    //카테고리 이름
    private String categoryname;  
}
