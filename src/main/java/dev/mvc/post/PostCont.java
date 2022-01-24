package dev.mvc.post;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import oracle.jdbc.OracleDatabaseException;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.uploadtool.Tool;
import dev.mvc.uploadtool.Upload;

@Controller
public class PostCont {
    @Autowired
    @Qualifier("dev.mvc.post.PostProc")
    private PostProcInter  postProc;

    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter  memberProc; // 확인
    
    public PostCont() {
        System.out.println("-> PostCont created.");
    }

    @RequestMapping(value = "/post/create", method = RequestMethod.POST)
    public ModelAndView post_create(PostVO postVO) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.postProc.post_create(postVO);
        mav.setViewName("redirect:/post/list");
        return mav; // forward
    }

    
    @RequestMapping(value = "/post/read_ajax", method = RequestMethod.GET)
    @ResponseBody
    public String post_read(int postno) {
        PostVO postVO = this.postProc.post_read(postno);
        JSONObject postjson = new JSONObject();
        postjson.put("postno", postVO.getPostno());
        postjson.put("memberno", postVO.getMemberno());
        postjson.put("title", postVO.getTitle());
        postjson.put("contents", postVO.getContents());
        postjson.put("pdate", postVO.getPdate());
        return postjson.toString();
    }

    // 재고 수정
    @RequestMapping(value = "/post/update", method = RequestMethod.POST)
    public ModelAndView post_update(PostVO postVO) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.postProc.post_update(postVO);
        mav.setViewName("redirect:/post/list");
        return mav; // forward
    }

    // 재고 삭제
    @RequestMapping(value = "/post/delete", method = RequestMethod.POST)
    public ModelAndView post_delete(int postno) {
        ModelAndView mav = new ModelAndView();
        int cnt = this.postProc.post_delete(postno);
        mav.setViewName("redirect:/post/list");
        return mav; // forward
    }

    // 재고 목록
    @RequestMapping(value = "/post/list.do", method = RequestMethod.GET)
    public ModelAndView post_list() {
        ModelAndView mav = new ModelAndView();
        List<PostVO> list = this.postProc.post_list();
        mav.addObject("list", list);
        mav.setViewName("/post/post_list");
        return mav; // forward
    }

}
