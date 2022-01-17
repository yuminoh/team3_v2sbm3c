package dev.mvc.team3_v2sbm3c;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.CategoryVO;
import dev.mvc.products.ProductsProcInter;
import dev.mvc.products.ProductsVO;
import dev.mvc.recommend_product.Recommend_productProcInter;
import dev.mvc.subcategory.SubCategoryProcInter;
import dev.mvc.subcategory.SubCategoryVO;

@Controller
public class HomeCont {
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  @Autowired
	@Qualifier("dev.mvc.category.CategoryProc")
	private CategoryProcInter CategoryProc;
  
  @Autowired
	@Qualifier("dev.mvc.products.ProductsProc")
	private ProductsProcInter ProductsProc;
  
  @Autowired
	@Qualifier("dev.mvc.subcategory.SubCategoryProc")
	private SubCategoryProcInter subcategoryProc;
  
  @Autowired
 	@Qualifier("dev.mvc.recommend_product.Recommend_productProc")
 	private Recommend_productProcInter recommend_productProc;

  // http://localhost:9091, http://localhost:9091/index.do
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno = 0;
    try {
    	memberno = (int)session.getAttribute("memberno");
    	}
    catch(Exception e) {}    
    int count = this.recommend_productProc.count(memberno);
    mav.addObject("count",count);
    List<ProductsVO> list ;
    if(count>0) {
    	int sub_categoryno = this.recommend_productProc.recommend_read(memberno);
    	list = this.ProductsProc.recommend_products(sub_categoryno);
    	mav.addObject("list",list);
    }else {   	
    }
	  /*List<CategoryVO> category_list = this.CategoryProc.category_list_data();
	  List<SubCategoryVO> sub_category_list=this.subcategoryProc.sub_category_data();
	  mav.addObject("category_list",category_list);
	  mav.addObject("sub_category_list",sub_category_list);*/
	  //화면에 전체카테고리와 서브카테고리를 출력해야할 때 사용할 코드
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp    
    return mav;
  }
}