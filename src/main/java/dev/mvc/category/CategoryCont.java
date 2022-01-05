package dev.mvc.category;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
public class CategoryCont {
    @Autowired
    @Qualifier("dev.mvc.category.CategoryProc")
    private CategoryProcInter CategoryProc;

    public CategoryCont() {
        System.out.println("-> CategoryCont created.");
    }
    
    //카테고리 생성
    @RequestMapping(value="/category/create", method=RequestMethod.POST)
	  public ModelAndView category_create(HttpServletRequest request,CategoryVO categoryVO) {
		  ModelAndView mav = new ModelAndView();
		  int cnt = this.CategoryProc.category_create(categoryVO);
		  mav.setViewName("redirect:/category/list");		
		  return mav; // forward
	  }
    
    //카테고리 정보 출력  
    @RequestMapping(value="/category/read_ajax", method=RequestMethod.GET )
    @ResponseBody
	  public String category_read(HttpServletRequest request,int categoryno) {
    		CategoryVO categoryVO = this.CategoryProc.category_read(categoryno);
    		JSONObject categoryjson = new JSONObject();
    		categoryjson.put("categoryno", categoryVO.getCategoryno());
    		categoryjson.put("categoryname", categoryVO.getCategoryname());			
    		return categoryjson.toString();
	  }
    
  //카테고리 수정
    @RequestMapping(value="/category/update", method=RequestMethod.POST)
	  public ModelAndView category_update(HttpServletRequest request,CategoryVO categoryVO) {
		  ModelAndView mav = new ModelAndView();
		  int cnt = this.CategoryProc.category_update(categoryVO);
		  StringBuffer return_url = request.getRequestURL();
		  mav.addObject("return_url",return_url);
		  mav.setViewName("redirect:/category/list");		
		  return mav; // forward
	  }
    
    //카테고리 삭제
    @RequestMapping(value="/category/delete", method=RequestMethod.POST)
	  public ModelAndView category_delete(HttpServletRequest request,int categoryno) {
		  ModelAndView mav = new ModelAndView();
		  StringBuffer return_url = request.getRequestURL();
		  mav.addObject("return_url",return_url);
		  int cnt = this.CategoryProc.category_delete(categoryno);
		  mav.setViewName("redirect:/category/list");		
		  return mav; // forward
	  }
    
    //카테고리 목록
    @RequestMapping(value="/category/list", method=RequestMethod.GET )
	  public ModelAndView category_list(HttpServletRequest request,
			  												@RequestParam(value="word", defaultValue="") String word,
															@RequestParam(value="now_page",defaultValue="1")int now_page) {
		  ModelAndView mav = new ModelAndView();
		  HashMap<String, Object> map =new HashMap<String, Object>();
		  map.put("word",word);
		  map.put("now_page", now_page);
		  List<CategoryVO> list = this.CategoryProc.category_list(map);
		  StringBuffer return_url = request.getRequestURL();
		  int search_count = this.CategoryProc.search_count(map);
		  String paging = this.CategoryProc.pagingBox(search_count, now_page, word); //페이지 버튼 코드
		  mav.addObject("return_url",return_url);
		  mav.addObject("paging",paging);
		  mav.addObject("list", list);
		  mav.setViewName("/category/category_list");
			/* 회원 정보를 통한 권한 확인 코드
			 * if(session.getAttribute("securityrank").equals("관리자")) {
			 * mav.setViewName("/foodstyle/foodstyle_create"); //
			 * webapp/WEB-INF/views/create.jsp }else { mav.addObject("code","nomanager");
			 * mav.setViewName("/foodstyle/foodstyle_msg"); }
			 */
		    return mav; // forward
	  }
    
    
}
