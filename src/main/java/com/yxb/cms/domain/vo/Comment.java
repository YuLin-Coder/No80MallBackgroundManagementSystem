package com.yxb.cms.domain.vo;

import com.yxb.cms.domain.dto.PageDto;
import java.io.Serializable;

public class Comment extends PageDto implements Serializable
{

    private static final long serialVersionUID = -986260112110736644L;

    private String id;

    //评论用户的标识
    private String user_code;

    //订单
    private String order_no;

    //星级
    private String star;

    //内容
    private String content;

    //创建时间
    private String create_time;

    private String dianpu_code;

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
    public String getOrder_no()
    {
        return order_no;
    }
    public void setOrder_no(String order_no)
    {
        this.order_no = order_no;
    }
    public String getStar()
    {
        return star;
    }
    public void setStar(String star)
    {
        this.star = star;
    }
    public String getContent()
    {
        return content;
    }
    public void setContent(String content)
    {
        this.content = content;
    }
    public String getCreate_time()
    {
        return create_time;
    }
    public void setCreate_time(String create_time)
    {
        this.create_time = create_time;
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