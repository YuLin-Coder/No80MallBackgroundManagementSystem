
package com.yxb.cms.domain.dto;

import java.io.Serializable;
import java.util.List;

/**
 * 资源菜单Dto
 */

public class ResourceMenuDto implements Serializable {

    //菜单名称
    private String title;

    // 菜单图标
    private String icon;

    //菜单链接
    private String href;


    //父级菜单Id
    private  Integer pid;

    private List<ResourceChildrenMenuDto> children;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }



    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public List<ResourceChildrenMenuDto> getChildren() {
        return children;
    }

    public void setChildren(List<ResourceChildrenMenuDto> children) {
        this.children = children;
    }
}
