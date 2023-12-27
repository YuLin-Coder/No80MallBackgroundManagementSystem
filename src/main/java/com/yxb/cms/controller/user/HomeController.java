package com.yxb.cms.controller.user;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Comment;
import com.yxb.cms.domain.vo.CommonCode;
import com.yxb.cms.domain.vo.Hourse;
import com.yxb.cms.domain.vo.Order;
import com.yxb.cms.domain.vo.Store;
import com.yxb.cms.domain.vo.User;
import com.yxb.cms.service.CommentService;
import com.yxb.cms.service.CommonCodeService;
import com.yxb.cms.service.HourseService;
import com.yxb.cms.service.OrderService;
import com.yxb.cms.service.StoreService;
import com.yxb.cms.service.UserService;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user")
public class HomeController
{

    @Autowired
    private CommentService commentService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private HourseService hourseService;

    @Autowired
    private CommonCodeService commonCodeService;

    @Autowired
    private UserService userService;


    @Autowired
    private StoreService storeService;

    /**
     *跳转首页
     * @return
     */
    @RequestMapping("/index.do")
    public String index(Model model,HttpSession session)
    {
        Hourse hourse=new Hourse();
        hourse.setPage(1);
        hourse.setLimit(6);
        String serverList = hourseService.selectListBypage(hourse);
        JSONObject result = JSONObject.fromObject(serverList);
        model.addAttribute("result",result);
        return "user/home";
    }

    /**
     *跳转首页
     * @return
     */
    @RequestMapping("/more.do")
    public String more(Model model,HttpSession session,Hourse hourse)
    {
        hourse.setPage(1);
        hourse.setLimit(1000);
        String serverList = hourseService.selectListBypage(hourse);
        JSONObject result = JSONObject.fromObject(serverList);
        model.addAttribute("result",result);
        return "user/more";
    }

    //退出登录
    @RequestMapping("/logut.do")
    public String logut(HttpSession session)
    {
        session.invalidate();
        return "user/login";
    }

    @RequestMapping("/header.do")
    public String header(HttpSession session,Model model)
    {
        List<Hourse> hourseList = (List<Hourse>) session.getAttribute("hourseList");
        if(hourseList==null) hourseList=new ArrayList<>();
        List<Hourse> serverList = (List<Hourse>) session.getAttribute("serverList");
        if(serverList==null) serverList=new ArrayList<>();
        int count=hourseList.size()+serverList.size();
        session.setAttribute("count",count);

        Map<String,Object> queryMap=new HashMap<>();
        queryMap.put("code","type");
        List<CommonCode> codes = commonCodeService.findByMap(queryMap);
        model.addAttribute("codes",codes);

        return "user/header";
    }

    /**
     *个人详情
     * @return
     */
    @RequestMapping("/personal/info.do")
    public String info()
    {
        return "user/info";
    }

    /**
     *个人详情
     * @return
     */
    @RequestMapping("/comment.do")
    public String comment()
    {
        return "user/comment_list";
    }


    @RequestMapping("/myorder.do")
    public String myorder()
    {
        return "user/myorder";
    }



    @RequestMapping("/view_hourse.do")
    public String view_hourse(String order_no, Model model)
    {
        model.addAttribute("order_no",order_no);
        return "user/view_hourse";
    }


    @RequestMapping("/detailHourse.do")
    public String detailHourse(Hourse hourse,HttpSession session, Model model)
    {
        String result = hourseService.findByAll(hourse);
        JSONObject jsonObject = JSONObject.fromObject(JSONArray.fromObject(JSONObject.fromObject(result).get("data")).get(0));
        model.addAttribute("hourse",jsonObject);

        Store store = storeService.selectById(hourse.getUser_code());
        model.addAttribute("store",store);
        return "user/detail";
    }




    //跳转评论页面
    @RequestMapping("/comment_add.do")
    public String comment_add(String order_no, Model model)
    {
        model.addAttribute("order_no",order_no);
        return "user/comment_add";
    }

    @RequestMapping("/editUserUI.do")
    public String editUserUI()
    {
        return "user/editUserUI";
    }




    @RequestMapping("/comment_list.do")
    @ResponseBody
    public String comment_list(Comment comment, HttpSession session)
    {
        User loginUser=(User)session.getAttribute("loginUser");
        comment.setUser_code(loginUser.getRelationId());
        return commentService.selectListBypage(comment);
    }

    @RequestMapping("/order_list.do")
    @ResponseBody
    public String order_list(Order order, HttpSession session)
    {
        User loginUser=(User)session.getAttribute("loginUser");
        order.setUser_code(loginUser.getRelationId());
        return orderService.selectListBypage(order);
    }


    /**
     * 列表List
     * @return
     */
    @RequestMapping("/hourse_all_list.do")
    @ResponseBody
    public String hourse_all_list(Hourse hourse,HttpSession session)
    {
        return hourseService.findByAllOrderNo(hourse);
    }



    /**
     * 删除订单
     */
    @RequestMapping("/del_order.do")
    @ResponseBody
    public BussinessMsg del_order(Integer id)
    {
        try
        {
            return orderService.deleteById(id);
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

    //删除评论
    @RequestMapping("/del_comment.do")
    @ResponseBody
    public BussinessMsg del_comment(Integer id)
    {
        try
        {
            return commentService.deleteById(id);
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }



    /**
     * 删除订单
     */
    @RequestMapping("/update_order_status.do")
    @ResponseBody
    public BussinessMsg update_order_status(Integer id,String status,String order_no)
    {
        try
        {
            Map<String,Object> queryMap=new HashMap<>();
            queryMap.put("id",id);
            queryMap.put("status",status);

            Order order=new Order();
            order.setPage(1);
            order.setLimit(10000);
            order.setOrder_no(order_no);
            String listPage = orderService.selectOrderDetailListBypage(order);
            JSONArray jsonArray = JSONArray.fromObject(JSONObject.fromObject(listPage).get("data"));
            for(int i = 0; i <jsonArray.size() ; i++)
            {
                Map<String,Object> query=new HashMap<>();
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                query.put("id",jsonObject.getString("other_id"));
                query.put("num",jsonObject.getString("num"));
                orderService.updateNumPlus(query);
            }

            return orderService.updateOrderStatus(queryMap);
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
        }
    }


    //添加评论
    @RequestMapping("/save_comment.do")
    @ResponseBody
    public BussinessMsg save_comment(Comment comment,HttpSession session)
    {
        try
        {
            User loginUser=(User)session.getAttribute("loginUser");
            comment.setUser_code(loginUser.getRelationId());
            Map<String,Object> queryMap=new HashMap<>();
            queryMap.put("user_code",comment.getUser_code());
            queryMap.put("order_no",comment.getOrder_no());

            Comment bean=commentService.findByMap(queryMap);
            if(bean!=null){
                return BussinessMsgUtil.returnCodeMessage(BussinessCode.COMMENT_ADD_STATUS_ERROR);
            }
            return commentService.saveInfo(comment);
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
        }
    }


    //更新个人信息
    @RequestMapping("/update_user.do")
    @ResponseBody
    public BussinessMsg update_user(User user,HttpSession session)
    {
        User sesionUser=(User) session.getAttribute("loginUser");
        try
        {   user.setUserId(sesionUser.getUserId());
            BussinessMsg result = userService.saveOrUpdateUser(user, "user");
            if("0000".equals(result.getReturnCode()))
            {
                sesionUser.setUserName(user.getUserName());
                sesionUser.setUserPassword(user.getUserPassword());
                session.setAttribute("loginUser",sesionUser);
            }

            return result;
        }
        catch(Exception e)
        {
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
        }
    }


}
