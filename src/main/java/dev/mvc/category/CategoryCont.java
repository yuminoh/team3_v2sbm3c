package dev.mvc.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CategoryCont {
    @Autowired
    @Qualifier("dev.mvc.category.CategoryProc")
    private CategoryProcInter CategoryProc;

    public CategoryCont() {
        System.out.println("-> CategoryCont created.");
    }
}
