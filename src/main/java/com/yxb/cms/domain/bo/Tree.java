
package com.yxb.cms.domain.bo;

import java.util.List;

/**
 * easyui　Tree模型
 */
public class Tree {
    private Integer id;
    private String text;
    private String state = "open";// open,closed
    private boolean checked = false;
    private Object attributes;
    private List<Tree> children;
    private String iconCls;
    private Integer pid;
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public boolean isChecked() {
        return checked;
    }
    public void setChecked(boolean checked) {
        this.checked = checked;
    }
    public Object getAttributes() {
        return attributes;
    }
    public void setAttributes(Object attributes) {
        this.attributes = attributes;
    }
    public List<Tree> getChildren() {
        return children;
    }
    public void setChildren(List<Tree> children) {
        this.children = children;
    }
    public String getIconCls() {
        return iconCls;
    }
    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }
    public Integer getPid() {
        return pid;
    }
    public void setPid(Integer pid) {
        this.pid = pid;
    }
	

}
