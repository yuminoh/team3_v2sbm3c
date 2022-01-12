package dev.mvc.pay_list;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cart.CartVO;

@Controller
public class Pay_listCont {
    @Autowired
    @Qualifier("dev.mvc.pay_list.Pay_listProc")
    private Pay_listProcInter Pay_listProc;
    
    public Pay_listCont() {
        System.out.println("-> Pay_listCont created.");
    }
    
    @RequestMapping(value="/pay_list/create.do", method=RequestMethod.POST )
    @ResponseBody
    public String create(HttpSession session, List<CartVO> list, int total) {
    	int memberno = (Integer) session.getAttribute("memberno");
    	System.out.println(memberno);
    	System.out.println(list);
    	/*for (Pay_listVO pay_listVO: listVO) {
    		pay_listVO.setMemberno(memberno);
    		int cnt = this.Pay_listProc.pay_list_create(pay_listVO);
    	}*/
        JSONObject json = new JSONObject();
        return json.toString();
    }
    
    @RequestMapping(value="/pay_list/intereste_products", method=RequestMethod.GET )
    @ResponseBody
    public String interested_products_list(HttpSession session, int memberno) {
    	List<Pay_listVO> intereste_products=this.Pay_listProc.intereste_product_list(memberno);   
    	JSONObject json = new JSONObject();
    	for(Pay_listVO pay_listVO:  intereste_products) {
    		System.out.println(pay_listVO);
    	}
        return json.toString();
    }
    
    @RequestMapping(value="/pay_list", method=RequestMethod.GET )
    public ModelAndView pay_list(HttpSession session,
    											@RequestParam(value="now_page",defaultValue="1")int now_page
    										) {
    	ModelAndView mav = new ModelAndView();
    	HashMap<String, Object> map=new HashMap<String, Object>();
        int memberno = 0;
    	try {memberno = (int) session.getAttribute("memberno");}
    	catch(Exception e) {}
    	if(memberno == 0) 
    		{mav.setViewName("/pay_list/msg");
    	}
    	else {   		
    		map.put("memberno", memberno);
    		map.put("now_page", now_page);
        	int search_count = this.Pay_listProc.pay_list_count(memberno);
        	String paging = this.Pay_listProc.pagingBox(search_count, now_page); //페이지 버튼 코드
        	
        	List<Pay_listVO> list=this.Pay_listProc.pay_list(map);
        	mav.addObject("paging",paging);
        	mav.addObject("pay_list",list);    	
        	mav.setViewName("/pay_list/pay_list");
    	}   	
        return mav;
    }
}
