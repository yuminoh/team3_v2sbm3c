package dev.mvc.team3_v2sbm3c;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.CategoryVO;
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
	@Qualifier("dev.mvc.subcategory.SubCategoryProc")
	private SubCategoryProcInter subcategoryProc;

  // http://localhost:9091, http://localhost:9091/index.do
  @RequestMapping(value = {"/", "/index.do"}, method = RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
	  /*List<CategoryVO> category_list = this.CategoryProc.category_list_data();
	  List<SubCategoryVO> sub_category_list=this.subcategoryProc.sub_category_data();
	  mav.addObject("category_list",category_list);
	  mav.addObject("sub_category_list",sub_category_list);*/
	  //화면에 전체카테고리와 서브카테고리를 출력해야할 때 사용할 코드
    mav.setViewName("/index");  // /WEB-INF/views/index.jsp    
    return mav;
  }
}