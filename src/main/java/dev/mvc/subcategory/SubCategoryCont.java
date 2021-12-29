package dev.mvc.subcategory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SubCategoryCont {
    @Autowired
    @Qualifier("dev.mvc.subcategory.SubCategoryProc")
    private SubCategoryProcInter SubCategoryProc;

    public SubCategoryCont() {
        System.out.println("-> SubCategoryCont created.");
    }
}