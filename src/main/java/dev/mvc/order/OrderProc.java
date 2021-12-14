package dev.mvc.order;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.order.OrderProc")
public class OrderProc implements OrderProcInter {
    @Autowired 
    private OrderDAOInter OrderDAO;
}
