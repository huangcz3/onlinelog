package com.asiainfo.onlineLog.Asynchronize;

import com.asiainfo.onlineLog.model.ConcreteUse;
import com.asiainfo.onlineLog.model.OverviewUse;
import com.asiainfo.onlineLog.model.TasApproveExp;
import com.asiainfo.onlineLog.service.IOnlineLogService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.concurrent.Future;

/**
 * Created by admin on 2017/12/5.
 */
@Component
public class SaveRsTask {

    private static final Logger logger = LoggerFactory.getLogger(SaveRsTask.class);

    @Autowired
    private IOnlineLogService onlineLogService;

    @Async
    public Future<String> saveRsInfo(List<ConcreteUse> concreteUseList, TasApproveExp tasApproveExp, OverviewUse overviewUse, String nowMonth, String now) {

        logger.info("phoneNo:{}  < (Asynchronize)saveReasonInfo,start >", overviewUse.getPhoneNo());

        long begin = System.currentTimeMillis();

        try {

            for (ConcreteUse concreteUse : concreteUseList) {

                onlineLogService.saveReansonInfo(concreteUse, tasApproveExp, overviewUse, nowMonth, now);

            }

            logger.info("phoneNo:{}  < (Asynchronize)saveReasonInfo,end  usedTime:{}ms >", overviewUse.getPhoneNo(), System.currentTimeMillis() - begin);

            return new AsyncResult<>("原因异步存储完成!!!");

        } catch (Exception e) {

            e.printStackTrace();

            logger.error("原因异步存储失败!!!");

            return new AsyncResult<>("原因异步存储失败!!!");

        }

    }

}
