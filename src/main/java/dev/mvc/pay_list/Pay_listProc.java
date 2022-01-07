package dev.mvc.pay_list;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.pay_list.Pay_listProc")
public class Pay_listProc implements Pay_listProcInter {
    @Autowired
    private Pay_listDAOInter pay_listDAO;
    
    @Override 
    public int pay_list_create(Pay_listVO pay_listVO) {
        int cnt = this.pay_listDAO.pay_list_create(pay_listVO);
        return cnt;
    }
}
