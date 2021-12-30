package dev.mvc.subcategory;

import java.util.HashMap;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryVO;
import dev.mvc.category.CategoryProcInter;

@Controller
public class SubCategoryCont {
    @Autowired
    @Qualifier("dev.mvc.subcategory.SubCategoryProc")
    private SubCategoryProcInter SubCategoryProc;

    @Autowired
    @Qualifier("dev.mvc.category.CategoryProc")
    private CategoryProcInter CategoryProc;
    
    public SubCategoryCont() {
        System.out.println("-> SubCategoryCont created.");
    }
    
    @RequestMapping(value="/subcategory/create", method=RequestMethod.POST)
	  public ModelAndView subcategory_create(SubCategoryVO subcategoryVO) {
		  ModelAndView mav = new ModelAndView();
		  int cnt = this.SubCategoryProc.sub_category_create(subcategoryVO);
		  mav.setViewName("redirect:/subcategory/list");		
		  return mav; // forward
	  }
    
    @RequestMapping(value="/subcategory/list_bycategory", method=RequestMethod.GET ) //카테고리당 서브카테고리 조회
	  public ModelAndView sub_category_list_bycategory(@RequestParam(value="categoryno") String categoryno,
			  												@RequestParam(value="word", defaultValue="") String word,
															@RequestParam(value="now_page",defaultValue="1")int now_page) {
		  ModelAndView mav = new ModelAndView();
		  HashMap<String, Object> map =new HashMap<String, Object>(); 
		  map.put("categoryno",categoryno); 
		  map.put("word",word);  //검색어를 haspmap으로 저장
		  map.put("now_page", now_page);
		  List<SubCategoryVO> list = this.SubCategoryProc.sub_category_list_bycategory(map); 
		  int search_count = this.SubCategoryProc.search_count_bycategory(map);
		  String paging = this.SubCategoryProc.pagingBox(search_count, now_page, word); //페이지 버튼 코드
		  mav.addObject("paging",paging);
		  mav.addObject("list", list);
		  mav.setViewName("/subcategory/subcategory_list_bycategory");		
		  return mav; // forward
	  }
    
    @RequestMapping(value="/subcategory/list", method=RequestMethod.GET ) //서브카테고리 전체 조회
	  public ModelAndView sub_category_list(@RequestParam(value="word", defaultValue="") String word,
															@RequestParam(value="now_page",defaultValue="1")int now_page) {
		  ModelAndView mav = new ModelAndView();
		  HashMap<String, Object> map =new HashMap<String, Object>(); 
		  map.put("word",word);  //검색어를 haspmap으로 저장
		  map.put("now_page", now_page);
		  List<SubCategoryVO> list = this.SubCategoryProc.sub_category_list(map); 
		  int search_count = this.SubCategoryProc.search_count(map);
		  String paging = this.SubCategoryProc.pagingBox(search_count, now_page, word); //페이지 버튼 코드
		  mav.addObject("paging",paging);
		  mav.addObject("list", list);
		  mav.setViewName("/subcategory/subcategory_total_list");
			/* 회원 정보를 통한 권한 확인 코드
			 * if(session.getAttribute("securityrank").equals("관리자")) {
			 * mav.setViewName("/foodstyle/foodstyle_create"); //
			 * webapp/WEB-INF/views/create.jsp }else { mav.addObject("code","nomanager");
			 * mav.setViewName("/foodstyle/foodstyle_msg"); }
			 */
		    return mav; // forward
	  }
    
    @RequestMapping(value="/subcategory/category_read_ajax", method=RequestMethod.GET )
    @ResponseBody //ajax로 서브카테고리 생성하기 위함
	  public String category_read() {
    		List<CategoryVO> categorylist = this.CategoryProc.category_list_data();
    		JSONObject categoryjson = new JSONObject();
    		categoryjson.put("categorydata", categorylist);	
    		return categoryjson.toString();
	  }
    
    @RequestMapping(value="/subcategory/read_ajax", method=RequestMethod.GET )
    @ResponseBody    //ajax로 서브카테고리 수정하기 위함
	  public String read_ajax(int sub_categoryno) {
    		SubCategoryVO subcategoryVO=this.SubCategoryProc.sub_category_read(sub_categoryno);
    		List<CategoryVO> categorylist = this.CategoryProc.category_list_data();
    		JSONObject categoryjson = new JSONObject();
    		categoryjson.put("categoryno", subcategoryVO.getCategoryno());	
    		categoryjson.put("sub_categoryno", subcategoryVO.getSub_categoryno());	
    		categoryjson.put("sub_categoryname", subcategoryVO.getSub_categoryname());	
    		categoryjson.put("categorydata", categorylist);	
    		return categoryjson.toString();
	  }
    
    @RequestMapping(value="/subcategory/delete_read_ajax", method=RequestMethod.GET )
    @ResponseBody    //ajax로 서브카테고리 수정하기 위함
	  public String delete_read_ajax(int sub_categoryno) {
    		SubCategoryVO subcategoryVO=this.SubCategoryProc.sub_category_read(sub_categoryno);
    		JSONObject categoryjson = new JSONObject();
    		categoryjson.put("categoryno", subcategoryVO.getCategoryno());	
    		categoryjson.put("sub_categoryno", subcategoryVO.getSub_categoryno());	
    		categoryjson.put("sub_categoryname", subcategoryVO.getSub_categoryname());		
    		return categoryjson.toString();
	  }
    
    @RequestMapping(value="/subcategory/update", method=RequestMethod.POST)
	  public ModelAndView subcategory_update(SubCategoryVO subcategoryVO) {
		  ModelAndView mav = new ModelAndView();
		  int cnt = this.SubCategoryProc.sub_category_update(subcategoryVO);
		  mav.setViewName("redirect:/subcategory/list");		
		  return mav; // forward
	  }
    
    @RequestMapping(value="/subcategory/delete", method=RequestMethod.POST)
	  public ModelAndView subcategory_delete(int sub_categoryno) {
		  ModelAndView mav = new ModelAndView();
		  int cnt = this.SubCategoryProc.sub_category_delete(sub_categoryno);
		  mav.setViewName("redirect:/subcategory/list");		
		  return mav; // forward
	  }
}
