package dev.mvc.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OrderCont {
    @Autowired
    @Qualifier("dev.mvc.order.OrderProc")
    private OrderProcInter OrderProc;

    public OrderCont() {
        System.out.println("-> OrderCont created.");
    }
}
