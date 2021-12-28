package dev.mvc.category;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("dev.mvc.category.CatgoryProc")
public class CatgoryProc implements CatgoryProcInter {
    @Autowired 
    private CatgoryDAOInter CatgoryDAO;
}
