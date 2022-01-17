package dev.mvc.recommend_product;

import java.util.HashMap;
import java.util.List;

import dev.mvc.products.ProductsVO;

public interface Recommend_productDAOInter {
	/**
	   * 추천 상품 등록
	   * @param recommend_productVO
	   * @return 성공여부
	   */
	public int recommend_create(Recommend_productVO recommend_productVO);
	/**
	   * 추천 테이블에 이미추천카테고리가 있는지 조회
	   * @param 회원번호, 서브카테고리 번호
	   * @return 성공여부
	   */
	public int count(int memberno);
	/**
	   * 추천 상품이 이미 있을 시 수정 조치
	   * @param recommend_productVO
	   * @return 성공여부
	   */
	public int recommend_update(Recommend_productVO recommend_productVO);
	
	/**
	   * 회원의 추천 상품 조회
	   * @param 회원번호
	   * @return 추천 서브 카테고리
	   */
	public int recommend_read(int memberno);
}
