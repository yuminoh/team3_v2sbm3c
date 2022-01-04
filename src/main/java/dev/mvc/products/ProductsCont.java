package dev.mvc.products;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.category.CategoryProcInter;
import dev.mvc.category.CategoryVO;
import dev.mvc.subcategory.SubCategoryProcInter;
import dev.mvc.subcategory.SubCategoryVO;
import dev.mvc.uploadtool.Tool;
import dev.mvc.uploadtool.Upload;

@Controller
public class ProductsCont {
    @Autowired
    @Qualifier("dev.mvc.products.ProductsProc")
    private ProductsProcInter  ProductsProc;

    @Autowired
	@Qualifier("dev.mvc.category.CategoryProc")
	private CategoryProcInter CategoryProc;
    
    @Autowired
	@Qualifier("dev.mvc.subcategory.SubCategoryProc")
	private SubCategoryProcInter SubCategoryProc;
    
    public ProductsCont() {
        System.out.println("-> ProductsCont created.");
    }
    
    private String uploadDir = Products.getUploadDir();
    
    @RequestMapping(value = "/products/list", method = RequestMethod.GET)
    public ModelAndView products_bysubcategory(int sub_categoryno,
    																			@RequestParam(value = "word", defaultValue = "") String word,
    																			@RequestParam(value = "now_page", defaultValue = "1") int now_page){
    	ModelAndView mav = new ModelAndView();
    	HashMap<String, Object> map = new HashMap<String, Object>();
    	map.put("sub_categoryno", sub_categoryno);
    	SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(sub_categoryno); // 목록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	CategoryVO categoryVO =this.CategoryProc.category_read(subcategoryVO.getCategoryno());  //목록화면에 나오는 카테고리 명을 출력하기 위함
    	map.put("word", word); // 검색어를 haspmap으로 저장
    	map.put("now_page", now_page);
    	List<ProductsVO> list = this.ProductsProc.products_list(map);
    	int search_count = this.ProductsProc.search_count(map);  
    	String paging = this.ProductsProc.pagingBox(search_count, now_page, word); // 페이지 버튼 코드
    	mav.addObject("categoryname",categoryVO.getCategoryname());
    	mav.addObject("sub_categoryno", subcategoryVO.getSub_categoryno());
    	mav.addObject("sub_categoryname", subcategoryVO.getSub_categoryname());
    	mav.addObject("paging", paging);
    	mav.addObject("list", list);    	
    	mav.setViewName("/products/products_list");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/create", method = RequestMethod.GET)
    public ModelAndView products_create(int sub_categoryno){
    	ModelAndView mav = new ModelAndView();
    	SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(sub_categoryno); // 등록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	mav.addObject("sub_categoryname",subcategoryVO.getSub_categoryname());
    	mav.addObject("categoryno",subcategoryVO.getCategoryno());
    	mav.addObject("sub_categoryno",sub_categoryno);
    	mav.setViewName("/products/products_create");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/create", method = RequestMethod.POST)
    public ModelAndView products_created(HttpServletRequest request, ProductsVO productsVO){
    	ModelAndView mav = new ModelAndView();
    	String result = productsVO.getProductname();
        String pdimagefile1 = "";
        String pdimagefile2 = "";
        String pdimagefile3 = "";
        String pdimagefile1saved ="";
        String thumb="";
     // cnt = 0; // error test
        String user_dir = System.getProperty("user.dir"); // 시스템 제공
        String uploadDir = this.uploadDir;
       
        System.out.println("->updir"+uploadDir);
        MultipartFile mf = productsVO.getFile1M1();
        pdimagefile1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        System.out.println("pdimagefile1->"+pdimagefile1);
        long size1 = mf.getSize();  // 파일 크기
        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        	pdimagefile1saved = Upload.saveFileSpring(mf, uploadDir); 
        	 if (Tool.isImage(pdimagefile1saved)) { // 이미지인지 검사
                 // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
                 
             }
          }
        productsVO.setPdimagefile1(pdimagefile1saved);   
        int cnt = this.ProductsProc.create(productsVO); 
        System.out.println(productsVO);
        if (cnt == 1) { 
            System.out.println("등록 성공");
            mav.addObject("result",result); // 메시지 화면에 출력될 상품이름
            mav.addObject("code", "create");		
            mav.addObject("sub_categoryno",productsVO.getSub_categoryno());  //등록 후 리스트 목록으로 돌아가기 위한 서브 카테고리 번호
            mav.setViewName("/products/msg");
            // mav.setViewName("redirect:/categrp/list.do");
        } else {
            mav.addObject("cnt", cnt);
            mav.addObject("result",result);
            mav.setViewName("/products/msg"); // /WEB-INF/views/
        }
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/read", method = RequestMethod.GET)
    public ModelAndView products_read(int productno){
    	ModelAndView mav = new ModelAndView();
    	ProductsVO productsVO = this.ProductsProc.product_read(productno); // 등록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	CategoryVO categoryVO =  this.CategoryProc.category_read(productsVO.getCategoryno());
    	SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(productsVO.getSub_categoryno());
    	mav.addObject("sub_categoryname",subcategoryVO.getSub_categoryname());
    	mav.addObject("categoryname",categoryVO.getCategoryname());
    	mav.addObject("productsVO",productsVO);
    	mav.setViewName("/products/read");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/read_ajax", method = RequestMethod.GET)
    @ResponseBody
    public String products_read_ajax(int productno){
    	JSONObject productdata = new JSONObject();
    	ProductsVO productsVO = this.ProductsProc.product_read(productno); 
    	productdata.put("productno", productsVO.getProductno());
    	productdata.put("sub_categoryno", productsVO.getSub_categoryno());
    	productdata.put("productname", productsVO.getProductname());
    	return productdata.toString(); // forward
    };
    
    @RequestMapping(value = "/products/update", method = RequestMethod.GET)
    public ModelAndView products_update(int productno){
    	ModelAndView mav = new ModelAndView();
    	ProductsVO productVO = this.ProductsProc.product_read(productno); // 등록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(productVO.getSub_categoryno());
    	mav.addObject("sub_categoryname",subcategoryVO.getSub_categoryname());
    	mav.addObject("productVO", productVO);
    	mav.setViewName("/products/products_update");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/update", method = RequestMethod.POST)
    public ModelAndView products_update_post(ProductsVO productsVO){
    	ModelAndView mav = new ModelAndView();
    	System.out.println(productsVO);
    	int cnt = this.ProductsProc.product_update(productsVO);
    	if (cnt==1){
    		mav.addObject("code","update_success");
    	}else {
    		mav.addObject("code","update_failed");
    	}    	
    	mav.addObject("sub_categoryno",productsVO.getSub_categoryno()); //목록으로 돌아가기 위해 전달
    	mav.setViewName("/products/msg");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/update_file", method = RequestMethod.GET)
    public ModelAndView products_update_file(int productno){
    	ModelAndView mav = new ModelAndView();
    	ProductsVO productVO = this.ProductsProc.product_read(productno); // 등록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	SubCategoryVO subcategoryVO = this.SubCategoryProc.sub_category_read(productVO.getSub_categoryno());
    	mav.addObject("sub_categoryname",subcategoryVO.getSub_categoryname());
    	mav.addObject("productVO", productVO);
    	mav.setViewName("/products/update_file");
    	return mav; // forward
    };
    
    @RequestMapping(value = "/products/update_file", method = RequestMethod.POST)
    public ModelAndView products_update_file_post(ProductsVO productsVO){
    	ModelAndView mav = new ModelAndView();
    	String pdimagefile1 = "";
    	String pdimagefile1saved = "";
	    HashMap<String, Object> map = new HashMap<String, Object>();
	    
	    map.put("productno", productsVO.getProductno());
	    MultipartFile mf = productsVO.getFile1M1();
	    
        pdimagefile1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
        System.out.println("pdimagefile1->"+pdimagefile1);
        long size1 = mf.getSize();  // 파일 크기
        if (size1 > 0) { // 파일 크기 체크
            // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        	pdimagefile1saved = Upload.saveFileSpring(mf, uploadDir); 
        	 if (Tool.isImage(pdimagefile1saved)) { // 이미지인지 검사
                 // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
             }
          }
        productsVO.setPdimagefile1(pdimagefile1saved);   
        map.put("pdimagefile1", productsVO.getPdimagefile1());
    	int cnt = this.ProductsProc.product_update_file(map); 	
    	if(cnt == 1) {
    		mav.addObject("code","file_update_success");
    	}else {
    		mav.addObject("code","file_update_failed");
    	}
    	mav.addObject("sub_categoryno",productsVO.getSub_categoryno());
    	mav.setViewName("/products/msg");
    	return mav; // forward
    };
       
    @RequestMapping(value = "/products/delete", method = RequestMethod.POST)
    public ModelAndView products_delete(ProductsVO productsVO){
    	ModelAndView mav = new ModelAndView();
    	int cnt = this.ProductsProc.product_delete(productsVO.getProductno()); // 등록화면에 나오는 상품의 서브 카테고리가 무엇인지 표기하기 위함
    	if(cnt == 1) {
    		mav.addObject("code","delete_success");
    	}else {
    		mav.addObject("code","delete_failed");
    		}
    	mav.addObject("sub_categoryno",productsVO.getSub_categoryno());
    	mav.setViewName("/products/msg");
    	return mav; // forward
    };
    
}
