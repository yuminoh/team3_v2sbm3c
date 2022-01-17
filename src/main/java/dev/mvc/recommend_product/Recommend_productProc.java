package dev.mvc.recommend_product;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.products.ProductsVO;


@Component("dev.mvc.recommend_product.Recommend_productProc")
public class Recommend_productProc implements Recommend_productProcInter {
    @Autowired
    private Recommend_productDAOInter recommend_productDAO;
    
    /**
	   * 추천 상품 등록
	   * @param recommend_productVO
	   * @return 성공여부
	   */
	public int recommend_create(Recommend_productVO recommend_productVO) {
		int cnt = this.recommend_productDAO.recommend_create(recommend_productVO);
		return cnt;
	}
    /**
	   * 추천 테이블에 이미추천카테고리가 있는지 조회
	   * @param 회원번호, 서브카테고리 번호
	   * @return 성공여부
	   */
	public int count(int memberno) {
		int count = this.recommend_productDAO.count(memberno);
		return count;
	}
	/**
	   * 추천 상품이 이미 있을 시 수정 조치
	   * @param recommend_productVO
	   * @return 성공여부
	   */
	public int recommend_update(Recommend_productVO recommend_productVO) {
		int cnt = this.recommend_productDAO.recommend_update(recommend_productVO);
		return cnt;
	}
	
	/**
	   * 회원의 추천 상품 조회
	   * @param 회원번호
	   * @return 추천 서브 카테고리
	   */
	public int recommend_read(int memberno) {
		int sub_categoryno = this.recommend_productDAO.recommend_read(memberno);
		return sub_categoryno;
	}
}
