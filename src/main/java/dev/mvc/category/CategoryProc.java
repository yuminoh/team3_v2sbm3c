package dev.mvc.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.category.CategoryProc")
public class CategoryProc implements CategoryProcInter {
    @Autowired 
    private CategoryDAOInter CategoryDAO;
    /**
	   * 생성
	   * @param 카테고리 정보
	   * @return 성공여부
	   */
	public int category_create(CategoryVO categoryVO) {
		int cnt = this.CategoryDAO.category_create(categoryVO);
		return cnt;
	};
    /**
	   * 조회
	   * @param 
	   * @return 카테고리 목록
	   */
	public List<CategoryVO> category_list(){
		List<CategoryVO> list = this.CategoryDAO.category_list();
		return list;
	};
	/**
	   * 조회
	   * @param 카테고리 번호
	   * @return 카테고리 목록
	   */
	public CategoryVO category_read(int categoryno) {
		CategoryVO categoryVO = this.CategoryDAO.category_read(categoryno); //ajax요청시 카테고리 정보를 전달
		return categoryVO;
	};
	
	/**
	   * 수정
	   * @param CategoryVO
	   * @return 성공여부
	   */
	public int category_update(CategoryVO categoryVO) {
		int cnt = this.CategoryDAO.category_update(categoryVO);
		return cnt;
	};
	
	/**
	   * 삭제
	   * @param 카테고리 번호
	   * @return 삭제 성공여부
	   */
	public int category_delete(int categoryno) {
		int cnt = this.CategoryDAO.category_delete(categoryno);
		return cnt;
	};
}
