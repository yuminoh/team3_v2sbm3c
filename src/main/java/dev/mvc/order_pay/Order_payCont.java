package dev.mvc.order_pay;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Order_payCont {
    @Autowired
    @Qualifier("dev.mvc.order_pay.Order_payProc")
    private Order_payProcInter order_payProc;
    
    public Order_payCont() {
        System.out.println("-> Order_payCont created.");
    }
    
    @RequestMapping(value="/order_pay/create.do", method=RequestMethod.POST )
    @ResponseBody
    public String create(HttpSession session,
                              int cartno) {
        Order_payVO order_payVO = new Order_payVO();
        order_payVO.setCartno(cartno);
        
        int memberno = (Integer)session.getAttribute("memberno");
        order_payVO.setMemberno(memberno);
        
        
        JSONObject json = new JSONObject();
        return json.toString();
    }

}
