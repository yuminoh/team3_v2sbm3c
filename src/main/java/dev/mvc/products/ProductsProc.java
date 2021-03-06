package dev.mvc.products;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Component("dev.mvc.products.ProductsProc")
public class ProductsProc implements ProductsProcInter {
    @Autowired 
    private ProductsDAOInter productsDAO;
        
    /**
	   * 서브카테고리당 상품 조회
	   * @param 서브카테고리 번호, 검색어, 현재페이지
	   * @return 상품 목록
	   */
	public List<ProductsVO> products_list(HashMap<String, Object> map){
		int begin_of_page = ((Integer) map.get("now_page") - 1) * Products.RECORD_PER_PAGE;
	    int start_num = begin_of_page + 1;	  
	    int end_num = begin_of_page + Products.RECORD_PER_PAGE;
	    
	    map.put("start_num", start_num);
	    map.put("end_num", end_num);
		List<ProductsVO> list = this.productsDAO.products_list(map);
		return list;
	};
	
	public int search_count(HashMap<String, Object> hashMap) {
		  int cnt = this.productsDAO.search_count(hashMap);
		  return cnt;
	  };
	  
	  @Override
	  public String pagingBox(int search_count, int now_page, String word) {
	      int total_page = (int) (Math.ceil((double) search_count / Products.RECORD_PER_PAGE)); // 전체 페이지 수
	      int total_grp = (int) (Math.ceil((double) total_page / Products.PAGE_PER_BLOCK)); // 전체 그룹 수
	      int now_grp = (int) (Math.ceil((double) now_page / Products.PAGE_PER_BLOCK)); // 현재 그룹 번호

	      // 1 group: 1, 2, 3 ... 9, 10
	      // 2 group: 11, 12 ... 19, 20
	      // 3 group: 21, 22 ... 29, 30
	      int start_page = ((now_grp - 1) * Products.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작 페이지
	      int end_page = (now_grp * Products.PAGE_PER_BLOCK); // 특정 그룹의 마지막 페이지

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
	      int _now_page = (now_grp - 1) * Products.PAGE_PER_BLOCK;
	      if (now_grp >= 2) { // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성
	          str.append("<span class='span_box_1'><A href='" + Products.LIST_FILE + "?&word=" + word + "&now_page="
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
	              str.append("<span class='span_box_1'><A href='" + Products.LIST_FILE + "?word=" + word + "&now_page="
	                      + i +   "'>" + i + "</A></span>");
	          }
	      }

	      // 10개 다음 페이지로 이동
	      // nowGrp: 1 (1 ~ 10 page), nowGrp: 2 (11 ~ 20 page), nowGrp: 3 (21 ~ 30 page)
	      // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
	      // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
	      // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
	      _now_page = (now_grp * Products.PAGE_PER_BLOCK) + 1; // 최대 페이지수 + 1
	      if (now_grp < total_grp) {
	          str.append("<span class='span_box_1'><A href='" + Products.LIST_FILE + "?&word=" + word + "&now_page="
	                  + _now_page +  "'>다음</A></span>");
	      }
	      str.append("</DIV>");

	      return str.toString();
	  }
	  
	  public int create(ProductsVO productsVO) {
		  int cnt = this.productsDAO.create(productsVO);
		  return cnt;
	  }
	  /**
	   * 상품 정보 조회
	   * @param 상품번호
	   * @return 상품 정보
	   */
	public ProductsVO product_read(int productno) {
		ProductsVO productsVO =this.productsDAO.product_read(productno);
		return productsVO;
	};
	
	/**
	   * 상품 정보 수정
	   * @param 상품정보
	   * @return 수정 성공여부
	   */
	public int product_update(ProductsVO productsVO) {
		int cnt = this.productsDAO.product_update(productsVO);
		return cnt;
	};
	
	/**
	   * 상품 이미지 수정
	   * @param 이미지 명
	   * @return 수정 성공여부
	   */
	public int product_update_file(HashMap map) {
		int cnt = this.productsDAO.product_update_file(map);
		return cnt;
	};
	
	/**
	   * 상품 정보 삭제
	   * @param 상품번호
	   * @return 삭제 성공여부
	   */
	public int product_delete(int productno) {
		int cnt = this.productsDAO.product_delete(productno);
		return cnt;
	};
	
	/**
	   * 상품 목록 ajax 조회
	   * @param 
	   * @return 상품 정보
	   */
	public List<ProductsVO> list_read_ajax(){
		List<ProductsVO> products_list = this.productsDAO.list_read_ajax();
		return products_list;
	};
	
	/**
	   * 메인화면에 회원의 추천 상품 출력
	   * @param 회원의 추천 서브카테고리
	   * @return 해당 카테고리의 최신상품 3가지
	   */
	public List<ProductsVO> recommend_products(int sub_categoryno){
		List<ProductsVO> list = this.productsDAO.recommend_products(sub_categoryno);
		return list;
	}
}
