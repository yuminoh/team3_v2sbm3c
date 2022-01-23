package dev.mvc.stock;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.products.ProductsProcInter;
import dev.mvc.products.ProductsVO;

@Controller
public class StockCont {
    @Autowired
    @Qualifier("dev.mvc.stock.StockProc")
    private StockProcInter StockProc;

    @Autowired
    @Qualifier("dev.mvc.products.ProductsProc")
    private ProductsProcInter  ProductsProc; // 확인
    
    public StockCont() {
        System.out.println("-> StockCont created.");
    }

    @RequestMapping(value = "/stock/create", method = RequestMethod.POST)
    public ModelAndView stock_create(StockVO stockVO) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.StockProc.stock_create(stockVO);
        mav.setViewName("redirect:/stock/list");
        return mav; // forward
    }

    // 재고 정보
    @RequestMapping(value = "/stock/read_ajax", method = RequestMethod.GET)
    @ResponseBody
    public String stock_read(int stocknum) {
        StockVO stockVO = this.StockProc.stock_read(stocknum);
        JSONObject stockjson = new JSONObject();
        stockjson.put("stocknum", stockVO.getStocknum());
        stockjson.put("stockno", stockVO.getStockno());
        stockjson.put("productno", stockVO.getProductno());
        stockjson.put("productclass", stockVO.getProductclass());
        stockjson.put("productwa", stockVO.getProductwa());
        stockjson.put("productst", stockVO.getProductst());
        return stockjson.toString();
    }

    // 재고 수정
    @RequestMapping(value = "/stock/update", method = RequestMethod.POST)
    public ModelAndView stock_update(StockVO stockVO) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.StockProc.stock_update(stockVO);
        mav.setViewName("redirect:/stock/list");
        return mav; // forward
    }

    // 재고 삭제
    @RequestMapping(value = "/stock/delete", method = RequestMethod.POST)
    public ModelAndView stock_delete(int stocknum) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.StockProc.stock_delete(stocknum);
        mav.setViewName("redirect:/stock/list");
        return mav; // forward
    }

    // 재고 목록
    @RequestMapping(value = "/stock/list.do", method = RequestMethod.GET)
    public ModelAndView stock_list() {
        ModelAndView mav = new ModelAndView();
        List<StockVO> list = this.StockProc.stock_list();
        mav.addObject("list", list);
        mav.setViewName("/stock/stock_list");
        return mav; // forward
    }

}
