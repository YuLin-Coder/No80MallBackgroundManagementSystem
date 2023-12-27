
package com.yxb.cms.service;

import com.yxb.cms.dao.SystemLogMapper;
import com.yxb.cms.domain.bo.ExcelExport;
import com.yxb.cms.domain.vo.SystemLog;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统日志Servce
 */

@Service
public class SystemLogService {

    private Logger log = LogManager.getLogger(SystemLogService.class);



    @Autowired
    private SystemLogMapper systemLogMapper;


    /**
     * 插入日志记录
     * @param systemLog 日志实体
     */
    @Transactional
    public void insertSelective(SystemLog systemLog){
        systemLogMapper.insertSelective(systemLog);
    }

    /**
     * 更新日志记录
     * @param systemLog 日志实体
     */
    @Transactional
    public void updateByPrimaryKeySelective(SystemLog systemLog){
        systemLogMapper.updateByPrimaryKeySelective(systemLog);
    }


    /**
     * 日志信息分页显示
     * @param systemLog 日志实体
     * @return
     */
    public String selectSystemLogResultPageList(SystemLog systemLog){

        List<SystemLog> systemLogList = systemLogMapper.selectSystemLogListByPage(systemLog);

        Long count = systemLogMapper.selectCountSystemLog(systemLog);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",count);
        map.put("data", systemLogList);

        return Json.toJson(map);
    }

    /**
     * 业务日志EXCEL导出
     * @param systemLog 日志实体
     * @return
     */
    public ExcelExport excelExportSystemLogList(SystemLog systemLog){
        ExcelExport excelExport = new ExcelExport();
        List<SystemLog> systemLogList = systemLogMapper.selectSystemLogList(systemLog);
        excelExport.addColumnInfo("日志标题","logTitle");
        excelExport.addColumnInfo("日志类型","logType_Lable");
        excelExport.addColumnInfo("日志请求URL","logUrl");
        excelExport.addColumnInfo("请求方式","logMethod");
        excelExport.addColumnInfo("请求参数","logParams");
        excelExport.addColumnInfo("请求用户","logUserName");
        excelExport.addColumnInfo("请求IP","logIp");
        excelExport.addColumnInfo("IP归属","logIpAddress");
        excelExport.addColumnInfo("请求时间","logStartTime_Lable");
        excelExport.addColumnInfo("耗时(毫秒)","logElapsedTime");


        excelExport.setDataList(systemLogList);
        return excelExport;
    }


    /**
     * 异常日志EXCEL导出
     * @param systemLog 日志实体
     * @return
     */
    public ExcelExport excelExportSysExceptionLogList(SystemLog systemLog){
        ExcelExport excelExport = new ExcelExport();
        List<SystemLog> systemLogList = systemLogMapper.selectSystemLogList(systemLog);
        excelExport.addColumnInfo("日志标题","logTitle");
        excelExport.addColumnInfo("日志类型","logType_Lable");
        excelExport.addColumnInfo("异常方法","logUrl");
        excelExport.addColumnInfo("请求参数","logParams");
        excelExport.addColumnInfo("异常信息","logException");
        excelExport.addColumnInfo("请求用户","logUserName");
        excelExport.addColumnInfo("请求IP","logIp");
        excelExport.addColumnInfo("IP归属","logIpAddress");
        excelExport.addColumnInfo("请求时间","logStartTime_Lable");
        excelExport.addColumnInfo("耗时(毫秒)","logElapsedTime");


        excelExport.setDataList(systemLogList);
        return excelExport;
    }


}
