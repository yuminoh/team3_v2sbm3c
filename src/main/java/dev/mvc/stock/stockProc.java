package dev.mvc.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.stock.StockProc")
public class StockProc implements StockProcInter {
    @Autowired 
    private StockDAOInter StockDAO;
    /**
	   * 생성
       * @param 재고 정보
       * @return 성공여부
	   */
    public int stock_create(StockVO stockVO) {
		int cnt = this.StockDAO.stock_create(stockVO);
		return cnt;
	};
    /**
	   * 조회
	   * @param 
	   * @return 재고 목록
	   */
	public List<StockVO> stock_list(){
		List<StockVO> list = this.StockDAO.stock_list();
		return list;
	};
	/**
	   * 조회
       * @param 재고 번호
       * @return 재고 목록
	   */
	public StockVO stock_read(int stocknum) {
	    StockVO stockVO = this.StockDAO.stock_read(stocknum); 
		return stockVO;
	};
	
	/**
	   * 수정
       * @param stockVO
       * @return 성공여부
	   */
	public int stock_update(StockVO stockVO) {
		int cnt = this.StockDAO.stock_update(stockVO);
		return cnt;
	};
	
	/**
	   * 삭제
	    * @param 재고 번호
        * @return 삭제 성공여부
	   */
	public int stock_delete(int stocknum) {
		int cnt = this.StockDAO.stock_delete(stocknum);
		return cnt;	
    };
}
