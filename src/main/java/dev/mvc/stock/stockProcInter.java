package dev.mvc.stock;

import java.util.List;

public interface stockProcInter {
    /**
       * 생성
       * @param 재고 정보
       * @return 성공여부
       */
    public int stock_create(stockVO stockVO);
        
    /**
       * 조회
       * @param 
       * @return 재고 목록
       */
    public List<stockVO> stock_list();
    
    /**
       * 조회
       * @param 재고 번호
       * @return 재고 목록
       */
    public stockVO stock_read(int stocknum);
    
    /**
       * 수정
       * @param stockVO
       * @return 성공여부
       */
    public int stock_update(stockVO stockVO);
    
    /**
       * 삭제
       * @param 재고 번호
       * @return 삭제 성공여부
       */
    public int stock_delete(int stocknum);
}
