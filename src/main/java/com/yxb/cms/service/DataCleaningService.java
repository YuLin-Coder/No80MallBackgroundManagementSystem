
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BusinessConstants;
import com.yxb.cms.dao.DataCleaningMapper;
import com.yxb.cms.dao.SystemLogMapper;
import com.yxb.cms.domain.dto.DataCollectDto;
import com.yxb.cms.domain.vo.DataCleaning;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据清洗Service
 */

@Service
public class DataCleaningService {

    private Logger log = LogManager.getLogger(DataCleaningService.class);

    @Autowired
    private DataCleaningMapper dataCleaningMapper;

    @Autowired
    private SystemLogMapper systemLogMapper;

    /**
     * 批量插入用户访问量清洗数据
     * @throws Exception
     */
    @Transactional
    public void insertDataCleanBatchByLogin() throws Exception {
        long start = System.currentTimeMillis();
        try {
            //查询7天用户登陆数据量
            List<DataCollectDto> listDto = systemLogMapper.selectDataCollectListByLog();
            log.info("用户访问量数据清洗开始,数据量:"+listDto.size());
            if(null != listDto && !listDto.isEmpty()){
                List<DataCleaning> list = new ArrayList<>();
                for (DataCollectDto dataCollectDto : listDto) {
                    DataCleaning clean = new DataCleaning();
                    clean.setDataType(BusinessConstants.CLEAN_DATA_TYPE_1.getCode());
                    clean.setDataTime(dataCollectDto.getDataTime());
                    clean.setDataCount(dataCollectDto.getDataCount());
                    list.add(clean);
                }
                dataCleaningMapper.insertDataCleanBatch(list);
            }

        } catch (Exception e) {
            log.error("用户访问量数据清洗方法内部错误", e);
            throw e;
        } finally {
            log.info("用户访问量数据清洗结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }

    }

    /**
     * 查询用户访问量,echart图表展示
     * @return
     */
    public String selectEchartsByLoginInfo(){
        Map<String,Object> map = new HashMap<>();
        List<DataCleaning> dataCleanings =  dataCleaningMapper.selectDataCleanListByLoginInfo();
        if(null != dataCleanings && !dataCleanings.isEmpty()){
            List xAxisDatas = new ArrayList();
            List seriesDatas = new ArrayList();
            for (DataCleaning dataCleaning : dataCleanings) {
                xAxisDatas.add(dataCleaning.getDataTime());
                seriesDatas.add(dataCleaning.getDataCount());
            }
            map.put("xAxisData",xAxisDatas);
            map.put("seriesData",seriesDatas);
        }
        return Json.toJson(map);
    }

}
