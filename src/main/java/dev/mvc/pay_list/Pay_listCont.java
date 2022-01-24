package dev.mvc.pay_list;

import java.util.HashMap;
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

import dev.mvc.cart.CartVO;
import dev.mvc.interested_products.Interested_productsProcInter;
import dev.mvc.products.ProductsProcInter;
import dev.mvc.products.ProductsVO;
import dev.mvc.recommend_product.Recommend_productProcInter;
import dev.mvc.subcategory.SubCategoryProcInter;
import dev.mvc.subcategory.SubCategoryVO;
import dev.mvc.recommend_product.Recommend_productVO;
import dev.mvc.stock.StockProcInter;
import dev.mvc.stock.StockVO;
import dev.mvc.stock.StockProcInter;
import dev.mvc.stock.StockVO;
import dev.mvc.interested_products.Interested_productsVO;

@Controller
public class Pay_listCont {
	@Autowired
	@Qualifier("dev.mvc.pay_list.Pay_listProc")
	private Pay_listProcInter Pay_listProc;

	@Autowired
	@Qualifier("dev.mvc.products.ProductsProc")
	private ProductsProcInter productsProc;

	@Autowired
	@Qualifier("dev.mvc.subcategory.SubCategoryProc")
	private SubCategoryProcInter SubCategoryProc;

	@Autowired
	@Qualifier("dev.mvc.recommend_product.Recommend_productProc")
	private Recommend_productProcInter Recommend_productProc;

	@Autowired
	@Qualifier("dev.mvc.interested_products.Interested_productsProc")
	private Interested_productsProcInter interested_productsProc;

	@Autowired
	@Qualifier("dev.mvc.stock.StockProc")
	private StockProcInter stockProc;

	public Pay_listCont() {
		System.out.println("-> Pay_listCont created.");
	}

	@RequestMapping(value = "/pay/create", method = RequestMethod.POST)
	@ResponseBody // 상품에서 바로구매를 누르는경우 실행하여 목록에 기록
	public String pay_create(HttpSession session, int productno, int ordercnt) {
		int memberno = (Integer) session.getAttribute("memberno");
		ProductsVO productdata = this.productsProc.product_read(productno); // 상품 데이터
		StockVO stockVO = this.stockProc.product_stock_read(productno); // 상품의 재고 데이터
		stockVO.setStockno(stockVO.getStockno() - ordercnt); // 구매한 수 만큼 재고에서 차감
		Pay_listVO pay_listVO = new Pay_listVO();
		pay_listVO.setMemberno(memberno);
		pay_listVO.setProductno(productno);
		pay_listVO.setCategoryno(productdata.getCategoryno());
		pay_listVO.setSub_categoryno(productdata.getSub_categoryno());
		pay_listVO.setCnt(ordercnt);
		int stockcnt = this.stockProc.stock_update(stockVO); // 재고 수 반영하여 수정
		int cnt = this.Pay_listProc.pay_create(pay_listVO);
		JSONObject json = new JSONObject();
		json.put("cnt", cnt);
		return json.toString();
	}

	/*
	 * @RequestMapping(value = "/pay_list/create.do", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public String create(HttpSession session, List<CartVO> list,
	 * int total) { int memberno = (Integer) session.getAttribute("memberno");
	 * System.out.println(memberno); System.out.println(list);
	 * 
	 * for (Pay_listVO pay_listVO: listVO) { pay_listVO.setMemberno(memberno); int
	 * cnt = this.Pay_listProc.pay_list_create(pay_listVO); }
	 * 
	 * JSONObject json = new JSONObject(); return json.toString(); }
	 */

	@RequestMapping(value = "/pay_list/interested_products", method = RequestMethod.GET)
	@ResponseBody
	public String interested_products_list(int memberno) {
		List<Pay_listVO> interested_products = this.Pay_listProc.intereste_product_list(memberno); //회원의 구매 기록 데이터
		JSONObject json = new JSONObject();
		if (interested_products.size() == 3) { // 구매기록에서 구매한 서브카테고리 종류가 3가지 이상일 경우
			int[] interested_sub_categorys = new int[3]; // 회원의 관심 서브카테고리를 저장하는 배열
			int i = 0;
			int cnt = this.interested_productsProc.interested_products_delete(memberno); // 새로 등록하기전 이미 있는 회원의 관심상품 제거
			Interested_productsVO interested_productsVO = new Interested_productsVO();
			interested_productsVO.setMemberno(memberno);
			for (Pay_listVO pay_listVO : interested_products) {
				interested_sub_categorys[i] = pay_listVO.getSub_categoryno(); // 회원의 관심상품 3가지 배열 저장
				interested_productsVO.setSub_categoryno(interested_sub_categorys[i]);// 관심상품 테이블에 등록
				cnt = this.interested_productsProc.interested_products_create(interested_productsVO); //관심 상품 테이블에 회원의 관심상품 3가지를 다시 저장
				i += 1;
			}
			HashMap<String, Object> map = new HashMap<String, Object>();

			map.put("memberno", memberno);
			map.put("sub_no1", interested_sub_categorys[0]);//회원의 첫번째 관심상품
			map.put("sub_no2", interested_sub_categorys[1]);//회원의 두번째 관심상품
			map.put("sub_no3", interested_sub_categorys[2]);//회원의 세번째 관심상품
			List<Pay_listVO> interested_pay_list = this.Pay_listProc.pay_list_interested(map); //회원의 관심상품 3가지에 관한 구매기록 5건 출력
			int[] pay_list = new int[5];
			i = 0;
			if (interested_pay_list.size() == 5) {
				for (Pay_listVO pay_listVO : interested_pay_list) {
					pay_list[i] = pay_listVO.getSub_categoryno();
					i += 1;
				} // 5건의 기록에서 서브 카테고리만 뽑아 배열로 저장
				json.put("code", "value_Suffice");
				json.put("interested_product", interested_sub_categorys);
				json.put("product_record", pay_list);
			} else {
				json.put("code", "value_lack");
			}
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} else {
			json.put("code", "value_lack");
		}
		// 구매내역에서 가장 많이 구매했던 기록 3가지를 추출
		return json.toString();
	}

	@RequestMapping(value = "/pay_list", method = RequestMethod.GET)
	public ModelAndView pay_list(HttpSession session,
			@RequestParam(value = "now_page", defaultValue = "1") int now_page) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> map = new HashMap<String, Object>();
		int memberno = 0; // default 회원 번호를 0으로 지정
		try {
			memberno = (int) session.getAttribute("memberno");
		} catch (Exception e) {
		}
		if (memberno == 0) { //로그인되지 않은 상태
			mav.setViewName("/member/login_need");
		} else {
			map.put("memberno", memberno);
			map.put("now_page", now_page);
			int search_count = this.Pay_listProc.pay_list_count(memberno); // 페이징 하기 위해 데이터가 몇건인지 조회
			String paging = this.Pay_listProc.pagingBox(search_count, now_page); // 페이지 버튼 코드

			List<Pay_listVO> list = this.Pay_listProc.pay_list(map);

			mav.addObject("paging", paging);
			mav.addObject("pay_list", list);
			mav.setViewName("/pay_list/pay_list");
		}
		return mav;
	}

	@RequestMapping(value = "/pay_list/recommend", method = RequestMethod.GET)
	@ResponseBody // 최종적으로 나온 추천 서브카테고리 번호를 저장하고 출력하기 위한 코드
	public String recommend(HttpSession session, int sub_categoryno) {
		SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(sub_categoryno); //특정 서브 카테고리의 정보를 저장
		JSONObject json = new JSONObject();
		int memberno = (int) session.getAttribute("memberno");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberno", memberno);
		map.put("suggetion_subcategoryno", sub_categoryno);
		int count = this.Recommend_productProc.count(memberno);//추천 테이블에 회원의 추천 상품이 있는지 검사
		Recommend_productVO recommend_productVO = new Recommend_productVO();
		recommend_productVO.setMemberno(memberno);
		recommend_productVO.setSuggestion_subcategoryno(sub_categoryno);
		if (count == 0) { // 추천테이블에 해당 회원의 내역이 없다면 추천 카테고리 저장
			int cnt = this.Recommend_productProc.recommend_create(recommend_productVO);
		} else {// 추천테이블에 해당 회원의 내역이 있다면 추천 카테고리 수정
			int cnt = this.Recommend_productProc.recommend_update(recommend_productVO);
		}
		json.put("sub_categoryno", subcategoryVO.getSub_categoryno());
		json.put("sub_categoryname", subcategoryVO.getSub_categoryname());
		return json.toString();
	}
}
