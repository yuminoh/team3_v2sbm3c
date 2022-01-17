package dev.mvc.recommend_product;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter @Setter @ToString
public class Recommend_productVO {
   //회원 번호
	private int memberno;
	//추천 서브카테고리 번호
	private int suggestion_subcategoryno;
}
