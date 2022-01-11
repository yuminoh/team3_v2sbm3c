package dev.mvc.pay_list;

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
}
