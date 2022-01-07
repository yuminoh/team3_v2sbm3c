
package dev.mvc.cart;

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

import dev.mvc.products.ProductsVO;

@Controller
public class CartCont {
    @Autowired
    @Qualifier("dev.mvc.cart.CartProc")
    private CartProcInter cartProc;

    public CartCont() {
        System.out.println("-> CartCont created.");
    }
  
    // http://localhost:9091/cart/create.do
    //Ajax 등록 처리
    @RequestMapping(value="/cart/create.do", method=RequestMethod.POST )
    @ResponseBody
    public String cart_create(HttpSession session,
                              int productno,int ordercnt) {
      CartVO cartVO = new CartVO();
      cartVO.setProductno(productno);
      int memberno = (Integer)session.getAttribute("memberno"); // FK
      cartVO.setMemberno(memberno);  
      cartVO.setCnt(ordercnt);
      int cnt = this.cartProc.cart_create(cartVO); // 등록 처리
      JSONObject json = new JSONObject();
      json.put("cnt", cnt);
      
      return json.toString();
    }
    //회원별 목록
     //http://localhost:9091/cart/list_by_memberno.do
    @RequestMapping(value="/cart/list_by_memberno", method=RequestMethod.GET )
    public ModelAndView list_by_memberno(HttpSession session,
        @RequestParam(value="cartno", defaultValue="0") int cartno ) {
      ModelAndView mav = new ModelAndView();
      ProductsVO productsVO = new ProductsVO();
      int cnt = 0;
      int total = 0;
      
      if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
        int memberno = (int)session.getAttribute("memberno");
        
        // 출력 순서별 출력
        List<CartVO> list = this.cartProc.list_by_memberno(memberno);
        for (CartVO cartVO : list) {
          cnt = cartVO.getCnt();
          total += cartVO.getProduct_price() * cnt;
        }
        
        mav.addObject("list", list); // request.setAttribute("list", list);
        mav.addObject("cartno", cartno); // 쇼핑계속하기에서 사용
        
        mav.addObject("cnt", cnt);
        mav.addObject("total", total);
        
        mav.setViewName("/cart/list_by_memberno"); // /WEB-INF/views/categrp/list_by_memberno.jsp
        
      } else { // 회원으로 로그인하지 않았다면
        mav.addObject("return_url", "/cart/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
        
        mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
      }
      return mav;
    }
 
   //상품 삭제   
    @RequestMapping(value="/cart/delete.do", method=RequestMethod.POST )
    public ModelAndView delete(HttpSession session,
        @RequestParam(value="cartno", defaultValue="0") int cartno ) {
      ModelAndView mav = new ModelAndView();
      
      this.cartProc.cart_delete(cartno);      
      mav.setViewName("redirect:/cart/list_by_memberno");
      
      return mav;
    }
    
    //수량변경
    @RequestMapping(value="/cart/cart_update.do", method=RequestMethod.POST )
    public ModelAndView cart_update(HttpSession session,
        @RequestParam(value="cartno", defaultValue="0") int cartno,
        int cnt) {
      ModelAndView mav = new ModelAndView();
      
      CartVO cartVO = new CartVO();
      cartVO.setCartno(cartno);
      cartVO.setCnt(cnt);
      
      this.cartProc.cart_update(cartVO);      
      mav.setViewName("redirect:/cart/list_by_memberno");
      
      return mav;
    }  
 
}