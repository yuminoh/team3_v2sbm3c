package dev.mvc.subcategory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.subcategory.SubCategoryProc")
public class SubCategoryProc implements SubCategoryProcInter {
    @Autowired 
    private SubCategoryDAOInter SubCategoryDAO;
}
