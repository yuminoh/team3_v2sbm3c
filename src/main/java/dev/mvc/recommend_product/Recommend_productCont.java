package dev.mvc.recommend_product;

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
import dev.mvc.products.ProductsProcInter;
import dev.mvc.products.ProductsVO;

@Controller
public class Recommend_productCont {
    @Autowired
    @Qualifier("dev.mvc.recommend_product.Recommend_productProc")
    private Recommend_productProcInter recommend_productProc;
      
    public Recommend_productCont() {
        System.out.println("-> Recommend_productCont created.");
    }
    
    @RequestMapping(value = "/member/recommend", method = RequestMethod.GET)
    public ModelAndView product_recommend() {
    	ModelAndView mav =new ModelAndView();
    	return mav;
    }
    
}
