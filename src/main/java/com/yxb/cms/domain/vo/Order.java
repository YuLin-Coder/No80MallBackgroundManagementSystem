package com.yxb.cms.domain.vo;

import com.yxb.cms.domain.dto.PageDto;
import java.io.Serializable;

//订单管理
public class Order extends PageDto implements Serializable
{

    private static final long serialVersionUID = 1469038466789622627L;

    private String id;

    private String order_no;// 订单号

    private String other_id;//  房间或服务id

    private String create_time;//  创建时间

    private String user_code;//  用户编码

    private String status;//   状态

    private String type_name;//   订单类型

    private String num;//  数量

    private String total_amount;//   金额

    private String price;

    private String name;

    private String photo;

    private String dianpu_code;

    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id = id;
    }
    public String getOrder_no()
    {
        return order_no;
    }
    public void setOrder_no(String order_no)
    {
        this.order_no = order_no;
    }
    public String getOther_id()
    {
        return other_id;
    }
    public void setOther_id(String other_id)
    {
        this.other_id = other_id;
    }
    public String getCreate_time()
    {
        return create_time;
    }
    public void setCreate_time(String create_time)
    {
        this.create_time = create_time;
    }
    public String getUser_code()
    {
        return user_code;
    }
    public void setUser_code(String user_code)
    {
        this.user_code = user_code;
    }
    public String getStatus()
    {
        return status;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }
    public String getType_name()
    {
        return type_name;
    }
    public void setType_name(String type_name)
    {
        this.type_name = type_name;
    }
    public String getNum()
    {
        return num;
    }
    public void setNum(String num)
    {
        this.num = num;
    }
    public String getTotal_amount()
    {
        return total_amount;
    }
    public void setTotal_amount(String total_amount)
    {
        this.total_amount = total_amount;
    }

    public String getPrice()
    {
        return price;
    }
    public void setPrice(String price)
    {
        this.price = price;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public String getPhoto()
    {
        return photo;
    }
    public void setPhoto(String photo)
    {
        this.photo = photo;
    }

    public String getDianpu_code()
    {
        return dianpu_code;
    }
    public void setDianpu_code(String dianpu_code)
    {
        this.dianpu_code = dianpu_code;
    }
}