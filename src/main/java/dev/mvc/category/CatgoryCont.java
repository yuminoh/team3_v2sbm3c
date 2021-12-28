package dev.mvc.category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CatgoryCont {
    @Autowired
    @Qualifier("dev.mvc.category.CatgoryProc")
    private CatgoryProcInter CatgoryProc;

    public CatgoryCont() {
        System.out.println("-> CatgoryCont created.");
    }
}
