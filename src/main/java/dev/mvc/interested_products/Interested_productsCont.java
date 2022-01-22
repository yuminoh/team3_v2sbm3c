package dev.mvc.interested_products;

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

@Controller
public class Interested_productsCont {
    @Autowired
    @Qualifier("dev.mvc.interested_products.Interested_productsProc")
    private Interested_productsProcInter interested_productsProc;

    public Interested_productsCont() {
        System.out.println("-> interested_productsCont created.");
    }  
}
