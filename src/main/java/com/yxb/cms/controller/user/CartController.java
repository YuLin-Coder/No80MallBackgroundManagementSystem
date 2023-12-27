package com.yxb.cms.controller.user;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Hourse;
import com.yxb.cms.domain.vo.Order;
import com.yxb.cms.domain.vo.User;
import com.yxb.cms.service.OrderService;
import com.yxb.cms.util.DateTimeUtil;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("cart")
public class CartController
{

    @Autowired
    private OrderService orderService;

    //购物车列表
    @RequestMapping("/cart_list.do")
    public String cart_list(HttpSession session)
    {
        List<Hourse> hourseList = (List<Hourse>) session.getAttribute("hourseList");
        if(hourseList==null) hourseList=new ArrayList<>();
        int count=hourseList.size();
        session.setAttribute("count",count);
        return "user/cart";
    }

    //添加购物车
    @RequestMapping("/addCart.do")
    @ResponseBody
    public BussinessMsg addCart(Hourse hourse, HttpSession session)
    {
        boolean hasHourse = false;
        //房间
        List<Hourse> hourseList = (List<Hourse>) session.getAttribute("hourseList");
        if(hourseList == null||hourseList.size()==0)
        {
            hourseList = new ArrayList<>();
            hourse.setNum("1");
            hourse.setTotal_amount(hourse.getPrice());
            hasHourse = true;
        }
        else
        {
            for(Hourse bean : hourseList)
            {
                hasHourse=true;
                if(hourse.getId().equals(bean.getId()))
                {
                    hasHourse=false;
                    break;
                }else{
                    hourse.setNum("1");
                    hourse.setTotal_amount(hourse.getPrice());
                }
            }
        }

      if(hasHourse){
          hourseList.add(hourse);
          session.setAttribute("hourseList", hourseList);
      }


        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    @RequestMapping("/removeCart.do")
    @ResponseBody
    public BussinessMsg removeCart(HttpSession session)
    {
        session.setAttribute("hourseList", new ArrayList<>());
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    @RequestMapping("/deleteCart.do")
    public String deleteCart(Hourse hourse, HttpSession session)
    {

            List<Hourse> hourseList = (List<Hourse>) session.getAttribute("hourseList");
            for(int i = 0; i <= hourseList.size(); i++)
            {
                if(hourseList.get(i).getId().equals(hourse.getId())){
                    hourseList.remove(i);   break;
                }

            }
            session.setAttribute("hourseList", hourseList);


        return "user/cart";
    }


    @RequestMapping("/generOrder.do")
    @ResponseBody
    public BussinessMsg generOrder(String type,HttpSession session)
    {

        String dianpu_code="";
        boolean not_dianpu=false;
        String goodsName="";
        boolean theSizeFlag=false;
        User user=(User) session.getAttribute("loginUser");
        List<Map<String,String>> orderDetailList=new ArrayList<>();
        StringBuffer ids=new StringBuffer();
        String order_no = DateTimeUtil.getUserCode();
        Order order =new Order();
        order.setOrder_no(order_no);
        order.setCreate_time(DateTimeUtil.dateTimeToLocalString(new Date()));
        order.setStatus("1");
        order.setUser_code(user.getRelationId());//从session取出用户信息

        List<Hourse> list =new ArrayList<>();

        list = (List<Hourse>) session.getAttribute("hourseList");

        BigDecimal num=BigDecimal.ZERO;
        BigDecimal total_amount=BigDecimal.ZERO;
        for(Hourse hourse:list){
            Map<String,String> orderDetail=new HashMap<>();
            orderDetail.put("other_id",hourse.getId());
            orderDetail.put("order_no",order_no);
            orderDetail.put("num",hourse.getNum());
            orderDetail.put("total_amount",hourse.getTotal_amount());
            orderDetailList.add(orderDetail);
            num=num.add(new BigDecimal(hourse.getNum()));
            total_amount=total_amount.add(new BigDecimal(hourse.getTotal_amount()));
            ids.append(","+hourse.getId());
            if(Integer.parseInt(hourse.getNum())>Integer.parseInt(hourse.getThe_size())){
                goodsName=hourse.getName();
                theSizeFlag=true;
                break;
            }
            if(StringUtils.isBlank(dianpu_code)){
                dianpu_code=hourse.getUser_code();
            }else if(!hourse.getUser_code().equals(dianpu_code)){
                not_dianpu=true;
                break;
            }
            Map<String,Object> query=new HashMap<>();
            query.put("id",hourse.getId());
            query.put("num",hourse.getNum());
            orderService.updateNum(query);
            order.setDianpu_code(hourse.getUser_code());
        }
        if(theSizeFlag){
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GOODS_THESIZE_STATUS_ERROR);
        }
        if(not_dianpu){
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.GOODS_ORDER_STATUS_ERROR);
        }

        session.setAttribute("hourseList",new ArrayList<>());
        order.setNum(num.toPlainString());
        order.setTotal_amount(total_amount.toPlainString());
        order.setDianpu_code(list.get(0).getUser_code());
        if(StringUtils.isNotBlank(ids.toString())){
            order.setOther_id(ids.substring(1,ids.length()));
            orderService.saveInfo(order);
            orderService.saveOrderDetail(orderDetailList);
        }
        JSONObject data=new JSONObject();
        data.put("order_no",order_no);
        data.put("num",num);
        data.put("total_amount",total_amount);
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS,data);
    }

    @RequestMapping("/addNum.do")
    @ResponseBody
    public String addNum(String id,String type,HttpSession session){
        String result="1";
        List<Hourse> list = (List<Hourse>) session.getAttribute("hourseList");
        for(Hourse hourse:list){
            if(hourse.getId().equals(id)){
                if("-".equals(type)&&Integer.parseInt(hourse.getNum())>0){
                    hourse.setNum(new BigDecimal(hourse.getNum()).subtract(new BigDecimal("1")).toPlainString());
                    hourse.setTotal_amount(new BigDecimal(hourse.getNum()).multiply(new BigDecimal(hourse.getPrice())).toPlainString());
                }else{
                    hourse.setNum(new BigDecimal(hourse.getNum()).add(new BigDecimal("1")).toPlainString());
                    hourse.setTotal_amount(new BigDecimal(hourse.getNum()).multiply(new BigDecimal(hourse.getPrice())).toPlainString());
                }
            }
        }
        return  result;
    }

}
