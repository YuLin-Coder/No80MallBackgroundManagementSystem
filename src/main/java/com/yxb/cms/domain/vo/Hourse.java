package com.yxb.cms.domain.vo;

import com.yxb.cms.domain.dto.PageDto;
import java.io.Serializable;

//房间实体（房间服务）
public class Hourse extends PageDto implements Serializable
{

    private static final long serialVersionUID = -6802463599400716049L;

    private String id;

    private String name;//房间名称

    private String type_id;// 类型

    private String photo;// 图片

    private String price;//价格

    private String the_size;//  大小

    private String info;// 信息

    private String welfare;//(空调 电视  无限 热水器)   附带

    private String type_name;// 房间或房间服务

    private String num;

    private String total_amount;

    private String user_code;

    private String create_time;

    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id = id;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public String getType_id()
    {
        return type_id;
    }
    public void setType_id(String type_id)
    {
        this.type_id = type_id;
    }
    public String getPhoto()
    {
        return photo;
    }
    public void setPhoto(String photo)
    {
        this.photo = photo;
    }
    public String getPrice()
    {
        return price;
    }
    public void setPrice(String price)
    {
        this.price = price;
    }
    public String getThe_size()
    {
        return the_size;
    }
    public void setThe_size(String the_size)
    {
        this.the_size = the_size;
    }
    public String getInfo()
    {
        return info;
    }
    public void setInfo(String info)
    {
        this.info = info;
    }
    public String getWelfare()
    {
        return welfare;
    }
    public void setWelfare(String welfare)
    {
        this.welfare = welfare;
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
    public String getUser_code()
    {
        return user_code;
    }
    public void setUser_code(String user_code)
    {
        this.user_code = user_code;
    }
    public String getCreate_time()
    {
        return create_time;
    }
    public void setCreate_time(String create_time)
    {
        this.create_time = create_time;
    }
}