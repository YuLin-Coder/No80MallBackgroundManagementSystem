
package com.yxb.cms.architect.task;

import com.yxb.cms.architect.constant.Constants;
import com.yxb.cms.handler.RedisClient;
import com.yxb.cms.service.DataCleaningService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 后台管理系统定时任务执行类

 */
@Component
public class SystemScheduledTask {

    private Logger log = LogManager.getLogger(SystemScheduledTask.class);

    @Autowired
    private DataCleaningService dataCleaningService;

    @Autowired
    private RedisClient redisClient;


    /**
     * 定时执行用户访问量，数据清洗，每天凌晨3点执行一次
     */
   // @Scheduled(cron = "0/10 * * * * ?") // 每10秒执行一次
    @Scheduled(cron = "0 0 3 * * ?")   //  每天3点执行
    public void executeDataCleanScheduler() {
        log.info(">>>>>>>>>>>>> 定时执行用户访问量数据清洗... ... ");
        try {
            dataCleaningService.insertDataCleanBatchByLogin();
            log.info(">>>>>>>>>>>>>将清洗数据set到redis");
            redisClient.set(Constants.REDIS_KEY_ECHARTS_USER_PV,dataCleaningService.selectEchartsByLoginInfo());
        } catch (Exception e) {
            log.error("用户访问量数据清洗异常", e);
        }
    }
}
