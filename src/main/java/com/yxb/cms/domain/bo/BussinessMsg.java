
package com.yxb.cms.domain.bo;

import java.io.Serializable;

/**
 * 后台管理系统业务返回Message通用类
 */


public class BussinessMsg implements Serializable {
    //返回Code
    private String returnCode;
    //返回描述
    private String returnMessage;
    //返回数据
    private Object returnData;


    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getReturnMessage() {
        return returnMessage;
    }

    public void setReturnMessage(String returnMessage) {
        this.returnMessage = returnMessage;
    }

    public Object getReturnData() {
        return returnData;
    }

    public void setReturnData(Object returnData) {
        this.returnData = returnData;
    }
}
