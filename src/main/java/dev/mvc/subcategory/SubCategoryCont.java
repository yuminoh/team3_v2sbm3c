package dev.mvc.subcategory;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

	@RequestMapping(value = "/subcategory/create", method = RequestMethod.POST)
	public ModelAndView subcategory_create(String url,
																	SubCategoryVO subcategoryVO) {
		ModelAndView mav = new ModelAndView();
		int cnt = this.SubCategoryProc.sub_category_create(subcategoryVO);
		 if(url.equals("http://localhost:9091/subcategory/list_bycategory }")) { //특정카테고리의 서브카테고리에서 작업시 이동할 페이지 설정
			  mav.setViewName("redirect:/subcategory/list_bycategory?categoryno="+subcategoryVO.getCategoryno());
		  }else {
			  mav.setViewName("redirect:/subcategory/list"); //서브카테고리 전체목록에서 작업시 이동하는 페이지 주소
		  }		 	
		return mav; // forward
	}

	@RequestMapping(value = "/subcategory/list_bycategory", method = RequestMethod.GET) // 카테고리당 서브카테고리 조회
	public ModelAndView sub_category_list_bycategory(HttpServletRequest request,
																				@RequestParam(value = "categoryno") int categoryno,
																				@RequestParam(value = "word", defaultValue = "") String word,
																				@RequestParam(value = "now_page", defaultValue = "1") int now_page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryno", categoryno);
		CategoryVO categoryVO = this.CategoryProc.category_read(categoryno);
		map.put("word", word); // 검색어를 haspmap으로 저장
		map.put("now_page", now_page);
		List<SubCategoryVO> list = this.SubCategoryProc.sub_category_list_bycategory(map);
		int search_count = this.SubCategoryProc.search_count_bycategory(map);
		String paging = this.SubCategoryProc.pagingBox(search_count, now_page, word); // 페이지 버튼 코드
		mav.addObject("categoryno", categoryVO.getCategoryno());
		mav.addObject("categoryname", categoryVO.getCategoryname());
		mav.addObject("paging", paging);
		mav.addObject("list", list);
		mav.addObject("url", request.getRequestURL());
		mav.setViewName("/subcategory/subcategory_list_bycategory");
		return mav; // forward
	}

	@RequestMapping(value = "/subcategory/list", method = RequestMethod.GET) // 서브카테고리 전체 조회
	public ModelAndView sub_category_list(@RequestParam(value = "word", defaultValue = "") String word,
			@RequestParam(value = "now_page", defaultValue = "1") int now_page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("word", word); // 검색어를 haspmap으로 저장
		map.put("now_page", now_page);
		List<SubCategoryVO> list = this.SubCategoryProc.sub_category_list(map);
		int search_count = this.SubCategoryProc.search_count(map);
		String paging = this.SubCategoryProc.pagingBox(search_count, now_page, word); // 페이지 버튼 코드
		mav.addObject("paging", paging);
		mav.addObject("list", list);
		mav.setViewName("/subcategory/subcategory_total_list");
		/*
		 * 회원 정보를 통한 권한 확인 코드 if(session.getAttribute("securityrank").equals("관리자")) {
		 * mav.setViewName("/foodstyle/foodstyle_create"); //
		 * webapp/WEB-INF/views/create.jsp }else { mav.addObject("code","nomanager");
		 * mav.setViewName("/foodstyle/foodstyle_msg"); }
		 */
		return mav; // forward
	}

	@RequestMapping(value = "/subcategory/category_read_ajax", method = RequestMethod.GET)
	@ResponseBody // 카테고리를 select문으로 선택하기 위해 데이터를 가져오는 ajax요청 코드
	public String category_read() {
		List<CategoryVO> categorylist = this.CategoryProc.category_list_data();
		JSONObject categoryjson = new JSONObject();
		categoryjson.put("categorydata", categorylist);
		return categoryjson.toString();
	}

	@RequestMapping(value = "/subcategory/read_ajax", method = RequestMethod.GET)
	@ResponseBody // ajax로 서브카테고리 수정하기 위함
	public String read_ajax(int sub_categoryno) {
		SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(sub_categoryno);
		List<CategoryVO> categorylist = this.CategoryProc.category_list_data();
		JSONObject categoryjson = new JSONObject();
		categoryjson.put("categoryno", subcategoryVO.getCategoryno());
		categoryjson.put("sub_categoryno", subcategoryVO.getSub_categoryno());
		categoryjson.put("sub_categoryname", subcategoryVO.getSub_categoryname());
		categoryjson.put("categorydata", categorylist);
		return categoryjson.toString();
	}

	@RequestMapping(value = "/subcategory/delete_read_ajax", method = RequestMethod.GET)
	@ResponseBody // ajax로 서브카테고리 수정하기 위함
	public String delete_read_ajax(int sub_categoryno) {
		SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(sub_categoryno);
		JSONObject categoryjson = new JSONObject();
		categoryjson.put("categoryno", subcategoryVO.getCategoryno());
		categoryjson.put("sub_categoryno", subcategoryVO.getSub_categoryno());
		categoryjson.put("sub_categoryname", subcategoryVO.getSub_categoryname());
		return categoryjson.toString();
	}

	@RequestMapping(value = "/subcategory/update", method = RequestMethod.POST)
	public ModelAndView subcategory_update(String url, SubCategoryVO subcategoryVO) {
		ModelAndView mav = new ModelAndView();
		int cnt = this.SubCategoryProc.sub_category_update(subcategoryVO);			
		  if(url.equals("http://localhost:9091/subcategory/list_bycategory }")) { //특정카테고리의 서브카테고리에서 작업시 이동할 페이지 설정
			  mav.setViewName("redirect:/subcategory/list_bycategory?categoryno="+subcategoryVO.getCategoryno());
		  }else {
			  mav.setViewName("redirect:/subcategory/list");		//서브카테고리 전체목록에서 작업시 이동하는 페이지 주소
		  }		 		
		return mav; // forward
	}

	@RequestMapping(value = "/subcategory/delete", method = RequestMethod.POST)
	public ModelAndView subcategory_delete(String url,int sub_categoryno,int categoryno) {
		ModelAndView mav = new ModelAndView();
		int cnt = this.SubCategoryProc.sub_category_delete(sub_categoryno);
		if(url.equals("http://localhost:9091/subcategory/list_bycategory }")) {  //특정카테고리의 서브카테고리에서 작업시 이동할 페이지 설정
			  mav.setViewName("redirect:/subcategory/list_bycategory?categoryno="+categoryno);
		  }else {
			  mav.setViewName("redirect:/subcategory/list");		//서브카테고리 전체목록에서 작업시 이동하는 페이지 주소
		  }		
		return mav; // forward
	}
}
