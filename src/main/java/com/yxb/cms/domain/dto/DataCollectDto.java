
package com.yxb.cms.domain.dto;

import java.io.Serializable;

/**
 * 数据汇总DTO
 */

public class DataCollectDto implements Serializable {

    //汇总时间
    private String dataTime;

    // 汇总数量
    private Integer dataCount;


    public String getDataTime() {
        return dataTime;
    }

    public void setDataTime(String dataTime) {
        this.dataTime = dataTime;
    }

    public Integer getDataCount() {
        return dataCount;
    }

    public void setDataCount(Integer dataCount) {
        this.dataCount = dataCount;
    }
}
