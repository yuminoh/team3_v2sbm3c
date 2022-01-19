package dev.mvc.stock;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.stock.stockProc")
public class stockProc implements stockProcInter {
    @Autowired 
    private stockDAOInter stockDAO;
    /**
	   * 생성
       * @param 재고 정보
       * @return 성공여부
	   */
    public int stock_create(stockVO stockVO) {
		int cnt = this.stockDAO.stock_create(stockVO);
		return cnt;
	};
    /**
	   * 조회
	   * @param 
	   * @return 재고 목록
	   */
	public List<stockVO> stock_list(){
		List<stockVO> list = this.stockDAO.stock_list();
		return list;
	};
	/**
	   * 조회
       * @param 재고 번호
       * @return 재고 목록
	   */
	public stockVO stock_read(int stocknum) {
	    stockVO stockVO = this.stockDAO.stock_read(stocknum); 
		return stockVO;
	};
	
	/**
	   * 수정
       * @param stockVO
       * @return 성공여부
	   */
	public int stock_update(stockVO stockVO) {
		int cnt = this.stockDAO.stock_update(stockVO);
		return cnt;
	};
	
	/**
	   * 삭제
	    * @param 재고 번호
        * @return 삭제 성공여부
	   */
	public int stock_delete(int stocknum) {
		int cnt = this.stockDAO.stock_delete(stocknum);
		return cnt;	
    };
}
