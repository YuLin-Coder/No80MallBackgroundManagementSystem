package com.yxb.cms.domain.vo;

import java.io.Serializable;

public class Store extends User implements Serializable
{

    private static final long serialVersionUID = -373964938692247682L;

    private String id;

    private String user_code;//用户标识

    private String store_name;//店铺名称

    private String log_photo;//log

    private String address; //地址

    private String qualification;  //资质图片

    private String name;

    private String phone;

    private String password;

    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id = id;
    }
    public String getUser_code()
    {
        return user_code;
    }
    public void setUser_code(String user_code)
    {
        this.user_code = user_code;
    }
    public String getStore_name()
    {
        return store_name;
    }
    public void setStore_name(String store_name)
    {
        this.store_name = store_name;
    }
    public String getLog_photo()
    {
        return log_photo;
    }
    public void setLog_photo(String log_photo)
    {
        this.log_photo = log_photo;
    }
    public String getAddress()
    {
        return address;
    }
    public void setAddress(String address)
    {
        this.address = address;
    }
    public String getQualification()
    {
        return qualification;
    }
    public void setQualification(String qualification)
    {
        this.qualification = qualification;
    }

    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public String getPhone()
    {
        return phone;
    }
    public void setPhone(String phone)
    {
        this.phone = phone;
    }
    public String getPassword()
    {
        return password;
    }
    public void setPassword(String password)
    {
        this.password = password;
    }
}

