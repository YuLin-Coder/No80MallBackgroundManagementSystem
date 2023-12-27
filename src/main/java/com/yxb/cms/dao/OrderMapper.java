
package com.yxb.cms.dao;

import com.yxb.cms.domain.vo.Order;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper
{
    List<Order> selectOrderByCondition(Order order);

    Long selectOrderCountByCondition(Order order);

    List<Order> selectSaleByCondition(Order order);

    Long selectSaleCountByCondition(Order order);

    int insert(Order order);

    Order selectOrderById(Integer id);

    int update(Order order);

    int deleteOrderById(Integer id);

    void updateOrderStatus(Map<String, Object> queryMap);

    void saveOrderDetail(List<Map<String, String>> orderDetailList);

    Order findByOrderNo(String order_no);

    Order getOrderDetail(Order order);

    void updateTotalAmount(Order order);

    void updateOrderDetailAmount(Order order);

    List<Order> selectOrderDetailByCondition(Order order);

    Long selectOrderDetailCountByCondition(Order order);

    void updateNum(Map<String, Object> query);
    void updateNumPlus(Map<String, Object> query);
}