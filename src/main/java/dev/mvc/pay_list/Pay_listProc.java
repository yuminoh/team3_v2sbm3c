package dev.mvc.pay_list;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.products.ProductsVO;


@Component("dev.mvc.pay_list.Pay_listProc")
public class Pay_listProc implements Pay_listProcInter {
    @Autowired
    private Pay_listDAOInter pay_listDAO;
    
  //바로구매시 등록
    @Override 
    public int pay_create(Pay_listVO pay_listVO) {
    	int cnt = this.pay_listDAO.pay_create(pay_listVO);
    	return cnt;
    }
    
    @Override 
    public int pay_list_create(Pay_listVO pay_listVO) {
        int cnt = this.pay_listDAO.pay_list_create(pay_listVO);
        return cnt;
    }
    
    /**
	   * 구매기록중 가장 많이 주문한 3개의 서브카테고리 정보 수집
	   * @param 회원 번호
	   * @return 서브카테고리 3종류
	   */
    @Override 
    public List<Pay_listVO> intereste_product_list(int memberno){
    	List<Pay_listVO> interested_products =this.pay_listDAO.intereste_product_list(memberno);
    	return interested_products;
    }
    /**
	   * 구매기록 조회
	   * @param 회원 번호
	   * @return 구매기록
	   */
    public List<Pay_listVO> pay_list(HashMap<String, Object> map){
    	int begin_of_page = ((Integer) map.get("now_page") - 1) * Pay_list.RECORD_PER_PAGE;
	    int start_num = begin_of_page + 1;	  
	    System.out.println("start_num->"+start_num);
	    int end_num = begin_of_page + Pay_list.RECORD_PER_PAGE;
	    
	    map.put("start_num", start_num);
	    map.put("end_num", end_num);
	    System.out.println("map->"+map);
    	List<Pay_listVO> pay_list = this.pay_listDAO.pay_list(map);
    	return pay_list;
    } 
    
    @Override
	  public String pagingBox(int search_count, int now_page) {
	      int total_page = (int) (Math.ceil((double) search_count / Pay_list.RECORD_PER_PAGE)); // 전체 페이지 수
	      int total_grp = (int) (Math.ceil((double) total_page / Pay_list.PAGE_PER_BLOCK)); // 전체 그룹 수
	      int now_grp = (int) (Math.ceil((double) now_page / Pay_list.PAGE_PER_BLOCK)); // 현재 그룹 번호

	      // 1 group: 1, 2, 3 ... 9, 10
	      // 2 group: 11, 12 ... 19, 20
	      // 3 group: 21, 22 ... 29, 30
	      int start_page = ((now_grp - 1) * Pay_list.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작 페이지
	      int end_page = (now_grp * Pay_list.PAGE_PER_BLOCK); // 특정 그룹의 마지막 페이지

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
	      int _now_page = (now_grp - 1) * Pay_list.PAGE_PER_BLOCK;
	      if (now_grp >= 2) { // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성
	          str.append("<span class='span_box_1'><A href='" + Pay_list.LIST_FILE + "?" + "&now_page="
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
	              str.append("<span class='span_box_1'><A href='" + Pay_list.LIST_FILE + "?"  + "&now_page="
	                      + i +   "'>" + i + "</A></span>");
	          }
	      }

	      // 10개 다음 페이지로 이동
	      // nowGrp: 1 (1 ~ 10 page), nowGrp: 2 (11 ~ 20 page), nowGrp: 3 (21 ~ 30 page)
	      // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
	      // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
	      // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
	      _now_page = (now_grp * Pay_list.PAGE_PER_BLOCK) + 1; // 최대 페이지수 + 1
	      if (now_grp < total_grp) {
	          str.append("<span class='span_box_1'><A href='" + Pay_list.LIST_FILE + "?"  + "&now_page="
	                  + _now_page +  "'>다음</A></span>");
	      }
	      str.append("</DIV>");

	      return str.toString();
	  }
    
    /**
     * 페이징을 위한 구매내역 수 조회
     * @param 회원 번호
     * @return 구매기록의 수
     */
     public int pay_list_count(int memberno) {
    	 int cnt =this.pay_listDAO.pay_list_count(memberno);
    	 return cnt;
     };
     
     /**
	   * 자주 주문한 3개의 서브카테고리에 대한 주문기록 5건
	   * @param 서브카테고리 1,2,3
	   * @return 구매기록
	   */
 public List<Pay_listVO> pay_list_interested(HashMap<String, Object> map){
	 List<Pay_listVO> interested_pay_list = this.pay_listDAO.pay_list_interested(map);
	 return interested_pay_list;
 };  
}
