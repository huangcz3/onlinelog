package com.asiainfo.onlineLog.aspect;

import com.asiainfo.onlineLog.model.OverviewUse;
import com.asiainfo.onlineLog.model.Result;
import com.asiainfo.onlineLog.service.IOnlineLogService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;

@Aspect
@Component
public class InterviewRecordAspect {

    private final static Logger logger = LoggerFactory.getLogger(InterviewRecordAspect.class);

    @Autowired
    IOnlineLogService onlineLogService;

    /**
     * 声明切面表示式
     */
    @Pointcut("execution(* com.asiainfo.onlineLog.controller.OnlineLogController.queryCompGprsBillInfo(..))")
    /**
     * 签名
     */
    public void record() {

    }

    @Before("record()")
    public void doBefore(JoinPoint joinPoint) {
        System.out.println("This is a AOP-test!");
    }

    @After("record()")
    public void doAfter() {
        System.out.println("This is the end of AOP-test!");
    }

    @AfterReturning(returning = "object", pointcut = "record()")
    public void doAfterReturning(Object object) {

        Result resultSuc = (Result) object;

        HashMap result = (HashMap) resultSuc.getData();

        OverviewUse overviewUse = (OverviewUse) result.get("overviewUse");

        String now = (String) result.get("now");

        String ipAddr = (String) result.get("ipAddr");

        long usedTime = (long) result.get("usedTime");


//        boolean isReQuery = onlineLogService.queryIsReQuery(overviewUse);

        try {

            onlineLogService.replaceIntoTasQueryLog(overviewUse, ipAddr, now, usedTime);

            logger.info("phoneNo:{}  < 操作记录入库完成!!! >", overviewUse.getPhoneNo());

        } catch (Exception e) {

            logger.error("phoneNO:{}  < 入库失败,请检查数据... >", overviewUse.getPhoneNo());
        }

    }
}
