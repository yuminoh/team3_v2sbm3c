
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

@Controller
public class CartCont {
    @Autowired
    @Qualifier("dev.mvc.cart.CartProc")
    private CartProcInter cartProc;

    public CartCont() {
        System.out.println("-> CartCont created.");
    }
    /*
    // http://localhost:9091/cart/create.do
    //등록
    @RequestMapping(value = "/cart/create.do", method = RequestMethod.POST)
    public ModelAndView create(CartVO cartVO) { 
        ModelAndView mav = new ModelAndView();

        int cnt = this.cartProc.create(cartVO); // 등록 처리
        
        mav.addObject("cnt", cnt);
       
        if (cnt == 1) {
            mav.setViewName("redirect:/cart/list.do");
        } else {
            mav.addObject("code", "create_fail"); // request에 저장, request.setAttribute("code", "create_fail")
            mav.setViewName("/categrp/msg"); // /WEB-INF/views/categrp/msg.jsp
        }

        return mav; // forward
    }
    
    // http://localhost:9091/cart/create.do
    //Ajax 등록 처리
    @RequestMapping(value="/cart/create.do", method=RequestMethod.POST )
    @ResponseBody
    public String create(HttpSession session,
                              int productno) {
      CartVO cartVO = new CartVO();
      cartVO.setProductno(productno);
      
      int memberno = (Integer)session.getAttribute("memberno"); // FK
      cartVO.setMemberno(memberno);
      
      cartVO.setCnt(1); // 최초 구매 수량 1개로 지정
      
      int cnt = this.cartProc.create(cartVO); // 등록 처리
      
      JSONObject json = new JSONObject();
      json.put("cnt", cnt);
     
      return json.toString();
    }
    //회원별 목록
     //http://localhost:9091/cart/list_by_memberno.do
    @RequestMapping(value="/cart/list_by_memberno.do", method=RequestMethod.GET )
    public ModelAndView list_by_memberno(HttpSession session,
        @RequestParam(value="cartno", defaultValue="0") int cartno ) {
      ModelAndView mav = new ModelAndView();
      
      if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
        int memberno = (int)session.getAttribute("memberno");
        
        int cnttot=1;
        int cnt=1;
        // 출력 순서별 출력
        List<CartVO> list = this.cartProc.list_by_memberno(memberno);
        
        for (CartVO cartVO : list) {
          cnttot = cartVO.getCnt();
          cartVO.setCnttot(cnttot);
          
          
        }
        
        mav.addObject("list", list); // request.setAttribute("list", list);
        mav.addObject("cartno", cartno); // 쇼핑계속하기에서 사용
        
        mav.addObject("cnt", cnt);
        mav.addObject("cnttot", cnttot);
        
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
      
      this.cartProc.delete(cartno);      
      mav.setViewName("redirect:/cart/list_by_memberno.do");
      
      return mav;
    }
    
    //수량변경
    @RequestMapping(value="/cart/cart_update.do", method=RequestMethod.POST )
    public ModelAndView update_cnt(HttpSession session,
        @RequestParam(value="cartno", defaultValue="0") int cartno,
        int cnt) {
      ModelAndView mav = new ModelAndView();
      
      CartVO cartVO = new CartVO();
      cartVO.setCartno(cartno);
      cartVO.setCnt(cnt);
      
      this.cartProc.cart_update(cartVO);      
      mav.setViewName("redirect:/cart/list_by_memberno.do");
      
      return mav;
    }  
 */   
}