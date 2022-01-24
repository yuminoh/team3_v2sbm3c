package dev.mvc.stock;

import java.util.List;


public interface StockDAOInter {
	/**
	   * 생성
	   * @param stockVO 
	   * @return 성공여부
	   */
    
    public int stock_create(StockVO stockVO);
    
    /**
       * 조회
       * @param 
       * @return 재고 목록
       */
    public List<StockVO> stock_list();
    
    /**
       * 조회
       * @param 재고 번호
       * @return 재고 목록
       */
    public StockVO stock_read(int stocknum);
    
    /**
       * 수정
       * @param stockVO
       * @return 성공여부
       */
    public int stock_update(StockVO stockVO);
    
    /**
       * 삭제
       * @param 재고 번호
       * @return 삭제 성공여부
       */
    public int stock_delete(int stocknum);
    
    /**
	   * 상품 재고 조회
	   * @param 상품 번호
	   * @return 재고 기록
	   */
	public StockVO product_stock_read(int productno);
	/**
	   * 상품 재고 조회
	   * @param 상품 번호
	   * @return 재고 기록 존재 여부
	   */
	public int product_stock_count(int productno);
}
