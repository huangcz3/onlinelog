package com.asiainfo.onlineLog.service;

import com.asiainfo.onlineLog.model.ConcreteUse;
import com.asiainfo.onlineLog.model.OverviewUse;
import com.asiainfo.onlineLog.model.TasApproveExp;

import java.util.Map;

/**
 * Created by admin on 2017/11/17.
 */
public interface IOnlineLogService {

    Map queryReasonInfo();


    /**
     * 保存不认可原因信息
     * @param concreteUse
     * @param tasApproveExp
     * @param overviewUse
     * @param nowMonth
     * @param now
     */
    void saveReansonInfo(ConcreteUse concreteUse, TasApproveExp tasApproveExp, OverviewUse overviewUse, String nowMonth, String now);


    /**
     * 判断是否重复查询
     *
     * @param overviewUse
     * @return
     */
    boolean queryIsReQuery(OverviewUse overviewUse);

    /**
     * 操作记录入库
     *
     * @param overviewUse
     * @param ipAddr
     * @param now
     * @param usedTime
     */
    void replaceIntoTasQueryLog(OverviewUse overviewUse, String ipAddr, String now, long usedTime);
}
