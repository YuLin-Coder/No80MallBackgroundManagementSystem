package com.yxb.cms.controller.user;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.User;
import com.yxb.cms.service.UserService;
import com.yxb.cms.util.DateTimeUtil;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user_login")
public class UserLoginController
{

    @Autowired
    private UserService userService;

    @RequestMapping("/loginUI.do")
    public String loginUI()
    {
        return "user/login";
    }

    @RequestMapping("/registerUI.do")
    public String registerUI()
    {
        return "user/register";
    }

    @ResponseBody
    @RequestMapping("/register.do")
    public BussinessMsg register(User user, HttpSession session)
    {
        try
        {
            user.setUserStatus(0L);
            user.setType_id("2");
            user.setRelationId(DateTimeUtil.getUserCode());
            user.setUserLoginName(user.getUserName());
            return userService.saveOrUpdateUser(user, "user");
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

    @ResponseBody
    @RequestMapping("/user/login.do")
    public BussinessMsg login(User user, HttpSession session)
    {
        try
        {
            User loginUser = userService.loginNameAndStatus(user.getUserName());
            if(loginUser != null && user.getUserPassword().equals(loginUser.getUserPassword()))
            {
                if(!"2".equals(loginUser.getType_id())){
                    return BussinessMsgUtil.returnCodeMessage(BussinessCode.USER_NOT_STATUS_ERROR);
                }
                session.setAttribute("loginUser",loginUser);
                return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
            }
            else
            {
                return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_LOGIN_FAIL);
            }
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_LOGIN_ERROR);
        }

    }

}
