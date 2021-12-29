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
	public SubCategoryVO sub_category_read(int categoryno) {
		SubCategoryVO subcategoryVO = this.SubCategoryDAO.sub_category_read(categoryno);
		return subcategoryVO;
	};
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int sub_category_update(SubCategoryVO subcategoryVO);
	
	/**
	   * 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<SubCategoryVO> sub_category_list(HashMap<String, Object> map);
	
	/**
	   * 삭제
	   * @param 카테고리 번호
	   * @return 삭제 성공여부
	   */
	public int sub_category_delete(int subcategoryno);
	
	/**
	   * 검색어를 포함한 데이터 수 조회
	   * @param 검색어 
	   * @return 특정 문자열을 가지고 있는 데이터의 수
	   */
	public int search_count(HashMap<String, Object> map);
}
