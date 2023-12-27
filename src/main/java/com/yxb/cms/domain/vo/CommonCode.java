
package com.yxb.cms.domain.vo;

import com.yxb.cms.domain.dto.PageDto;
import java.io.Serializable;

//公用
public class CommonCode extends PageDto implements Serializable
{

    private static final long serialVersionUID = -986260112110736644L;

    private String id;

    private String code;

    private String name;

    public String getId()
    {
        return id;
    }
    public void setId(String id)
    {
        this.id = id;
    }
    public String getCode()
    {
        return code;
    }
    public void setCode(String code)
    {
        this.code = code;
    }
    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
}