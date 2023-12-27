
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.dao.OrderMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Order;
import com.yxb.cms.util.TokenUtil;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService
{

    private Logger log = LogManager.getLogger(OrderService.class);

    @Autowired
    private OrderMapper orderMapper;

    /**
     * 分页展示
     * @param order
     * @return
     */
    public String selectListBypage(Order order) {

        List<Order> list = orderMapper.selectOrderByCondition(order);
        Long count = orderMapper.selectOrderCountByCondition(order);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    //销售
    public String selectSaleListBypage(Order order) {
        if(order.getType_name()==null) order.setType_name("1");
        order.setDianpu_code(TokenUtil.getCurrentUser().getRelationId());
        List<Order> list = orderMapper.selectSaleByCondition(order);
        Long count = orderMapper.selectSaleCountByCondition(order);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    //订单详情
    public String selectOrderDetailListBypage(Order order) {
        List<Order> list = orderMapper.selectOrderDetailByCondition(order);
        Long count = orderMapper.selectOrderDetailCountByCondition(order);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    /**
     * 保存
     * @param order
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveInfo(Order order){
        try {
            orderMapper.insert(order);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /**
     * 根据id删除
     * @param id
     * @return
     */
    @Transactional
    public BussinessMsg deleteById(Integer id){

        try {
            orderMapper.deleteOrderById(id);
        } catch (Exception e) {
            log.error("删除方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public Order selectById(Integer id) {
        return orderMapper.selectOrderById(id);
    }

    /**
     * 修改
     * @param order
     * @return
     */
    @Transactional
    public BussinessMsg update(Order order)
    {
        try {
            orderMapper.update(order);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /**
     * 更新状态
     * @param queryMap
     * @return
     */
    @Transactional
    public BussinessMsg updateOrderStatus(Map<String,Object> queryMap)
    {
        try {
            orderMapper.updateOrderStatus(queryMap);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    //保存明细
    public void saveOrderDetail(List<Map<String, String>> orderDetailList)
    {
        try {
            orderMapper.saveOrderDetail(orderDetailList);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
    }
    //换房
    public BussinessMsg set_hourse(Order order)
    {
        Order getorder=orderMapper.findByOrderNo(order.getOrder_no());
        Order orderDetail=orderMapper.getOrderDetail(order);
        String totalAmount=getorder.getTotal_amount();
        String amountOne=orderDetail.getTotal_amount();
        totalAmount=new BigDecimal(totalAmount).add(new BigDecimal(order.getTotal_amount())).subtract(new BigDecimal(amountOne)).toPlainString();
        amountOne=order.getTotal_amount();
        order.setTotal_amount(totalAmount);
        orderMapper.updateTotalAmount(order);
        order.setTotal_amount(amountOne);
        orderMapper.updateOrderDetailAmount(order);
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }
    public void updateNum(Map<String, Object> query)
    {
        orderMapper.updateNum(query);
    }
    public void updateNumPlus(Map<String, Object> query)
    {
        orderMapper.updateNumPlus(query);
    }
}
