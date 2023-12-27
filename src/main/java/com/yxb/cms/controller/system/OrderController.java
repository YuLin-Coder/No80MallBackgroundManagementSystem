package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Order;
import com.yxb.cms.service.OrderService;
import com.yxb.cms.util.TokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("order")
public class OrderController extends BasicController
{

    @Autowired
    private OrderService orderService;

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/order_list.do")
    public String toListPage()
    {
        return "system/order/order_list";
    }

    //换房列表
    @RequestMapping("/select_hourse.do")
    public String select_hourse(String order_no,String other_id,Model model)
    {
        model.addAttribute("order_no",order_no);
        model.addAttribute("other_id",other_id);
        return "system/hourse/select_hourse";
    }

    //换房列表
    @RequestMapping("/order_detail.do")
    public String order_detail(String order_no,Model model)
    {
        model.addAttribute("order_no",order_no);
        return "system/order/order_detail";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/order_detail_list.do")
    @ResponseBody
    public String order_detail_list(Order order)
    {
        return orderService.selectOrderDetailListBypage(order);
    }


    /**
     * 列表List
     * @return
     */
    @RequestMapping("/ajax_order_list.do")
    @ResponseBody
    public String ajaxList(Order order)
    {
        order.setDianpu_code(TokenUtil.getCurrentUser().getRelationId());
        return orderService.selectListBypage(order);
    }

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/sale_list.do")
    public String sale_list()
    {
        return "system/order/sale_list";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/order_sale_list.do")
    @ResponseBody
    public String order_sale_list(Order order)
    {
        return orderService.selectSaleListBypage(order);
    }


    /**
     * 删除
     */
    @RequestMapping("/ajax_del_order.do")
    @ResponseBody
    public BussinessMsg deleteById(Integer id)
    {
        try
        {
            return orderService.deleteById(id);
        }
        catch(Exception e)
        {
            log.error("删除信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

    @RequestMapping("/set_hourse.do")
    @ResponseBody
    public BussinessMsg set_hourse(Order order)
    {
        try
        {
            return orderService.set_hourse(order);
        }
        catch(Exception e)
        {
            log.error("删除信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

}
