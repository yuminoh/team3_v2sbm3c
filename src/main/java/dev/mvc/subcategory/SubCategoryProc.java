package dev.mvc.subcategory;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.subcategory.SubCategoryProc")
public class SubCategoryProc implements SubCategoryProcInter {
    @Autowired 
    private SubCategoryDAOInter SubCategoryDAO;
    /**
	   * 생성
	   * @param CategoryVO 
	   * @return 성공여부
	   */
	public int sub_category_create(SubCategoryVO subcategoryVO) {
		int cnt = this.SubCategoryDAO.sub_category_create(subcategoryVO);
		return cnt;
	};
	
	/**
	   * 조회
	   * @param 카테고리 번호
	   * @return 카테고리 목록
	   */
	public SubCategoryVO sub_category_read(int subcategoryno) {
		SubCategoryVO subcategoryVO = this.SubCategoryDAO.sub_category_read(subcategoryno);
		return subcategoryVO;
	};
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int sub_category_update(SubCategoryVO subcategoryVO) {
		int cnt = this.SubCategoryDAO.sub_category_update(subcategoryVO);
		return cnt;
	};
	
	/**
	   * 카테고리당 서브카테고리 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_list_bycategory(HashMap<String, Object> map){
		int begin_of_page = ((Integer) map.get("now_page") - 1) * SubCategory.RECORD_PER_PAGE;
	    int start_num = begin_of_page + 1;	  
	    int end_num = begin_of_page + SubCategory.RECORD_PER_PAGE;
	    
	    map.put("start_num", start_num);
	    map.put("end_num", end_num);
	    List<SubCategoryVO> list = this.SubCategoryDAO.sub_category_list_bycategory(map);
	    return list;
	};
	
	/**
	   * 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_list(HashMap<String, Object> map){
		
	    int begin_of_page = ((Integer) map.get("now_page") - 1) * SubCategory.RECORD_PER_PAGE;
	    int start_num = begin_of_page + 1;	  
	    int end_num = begin_of_page + SubCategory.RECORD_PER_PAGE;
	    
	    map.put("start_num", start_num);
	    map.put("end_num", end_num);
	    List<SubCategoryVO> list = this.SubCategoryDAO.sub_category_list(map);
		
		return list;
	};
	
	/**
	   * 서브카테고리 전체 조회하여 전달
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_data(){
		List<SubCategoryVO> list =this.SubCategoryDAO.sub_category_data();
		return list;
	};
	
	/**
	   * 삭제
	   * @param 카테고리 번호
	   * @return 삭제 성공여부
	   */
	public int sub_category_delete(int subcategoryno) {
		int cnt = this.SubCategoryDAO.sub_category_delete(subcategoryno);
		return cnt;
	};
	
	/**
	   * 검색어를 포함한 데이터 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count(HashMap<String, Object> map) {
		int cnt = this.SubCategoryDAO.search_count(map);
		return cnt;
	};
	
	@Override
	  public String pagingBox(int search_count, int now_page, String word) {
	      int total_page = (int) (Math.ceil((double) search_count / SubCategory.RECORD_PER_PAGE)); // 전체 페이지 수
	      int total_grp = (int) (Math.ceil((double) total_page / SubCategory.PAGE_PER_BLOCK)); // 전체 그룹 수
	      int now_grp = (int) (Math.ceil((double) now_page / SubCategory.PAGE_PER_BLOCK)); // 현재 그룹 번호

	      // 1 group: 1, 2, 3 ... 9, 10
	      // 2 group: 11, 12 ... 19, 20
	      // 3 group: 21, 22 ... 29, 30
	      int start_page = ((now_grp - 1) * SubCategory.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작 페이지
	      int end_page = (now_grp * SubCategory.PAGE_PER_BLOCK); // 특정 그룹의 마지막 페이지

	      StringBuffer str = new StringBuffer();

	      str.append("<style type='text/css'>");
	      str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}");
	      str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}");
	      str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}");
	      str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}");
	      str.append("  .span_box_1{");
	      str.append("    text-align: center;");
	      str.append("    font-size: 1em;");
	      str.append("    border: 1px;");
	      str.append("    border-style: solid;");
	      str.append("    border-color: #cccccc;");
	      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
	      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
	      str.append("  }");
	      str.append("  .span_box_2{");
	      str.append("    text-align: center;");
	      str.append("    background-color: #668db4;");
	      str.append("    color: #FFFFFF;");
	      str.append("    font-size: 1em;");
	      str.append("    border: 1px;");
	      str.append("    border-style: solid;");
	      str.append("    border-color: #cccccc;");
	      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/");
	      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/");
	      str.append("  }");
	      str.append("</style>");
	      str.append("<DIV id='paging'>");
//	    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

	      // 이전 10개 페이지로 이동
	      // now_grp: 1 (1 ~ 10 page)
	      // now_grp: 2 (11 ~ 20 page)
	      // now_grp: 3 (21 ~ 30 page)
	      // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
	      // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
	      int _now_page = (now_grp - 1) * SubCategory.PAGE_PER_BLOCK;
	      if (now_grp >= 2) { // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성
	          str.append("<span class='span_box_1'><A href='" + SubCategory.LIST_FILE + "?&word=" + word + "&now_page="
	                  + _now_page +  "'>이전</A></span>");
	      }

	      // 중앙의 페이지 목록
	      for (int i = start_page; i <= end_page; i++) {
	          if (i > total_page) { // 마지막 페이지를 넘어갔다면 페이 출력 종료
	              break;
	          }

	          if (now_page == i) { // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
	              str.append("<span class='span_box_2'>" + i + "</span>"); // 현재 페이지, 강조
	          } else {
	              // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
	              str.append("<span class='span_box_1'><A href='" + SubCategory.LIST_FILE + "?word=" + word + "&now_page="
	                      + i +   "'>" + i + "</A></span>");
	          }
	      }

	      // 10개 다음 페이지로 이동
	      // nowGrp: 1 (1 ~ 10 page), nowGrp: 2 (11 ~ 20 page), nowGrp: 3 (21 ~ 30 page)
	      // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
	      // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
	      // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
	      _now_page = (now_grp * SubCategory.PAGE_PER_BLOCK) + 1; // 최대 페이지수 + 1
	      if (now_grp < total_grp) {
	          str.append("<span class='span_box_1'><A href='" + SubCategory.LIST_FILE + "?&word=" + word + "&now_page="
	                  + _now_page +  "'>다음</A></span>");
	      }
	      str.append("</DIV>");

	      return str.toString();
	  }
	
	/**
	   * 카테고리당 서브 카테고리 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count_bycategory(HashMap<String, Object> map) {
		int cnt = this.SubCategoryDAO.search_count_bycategory(map);
		return cnt;
	};
}
