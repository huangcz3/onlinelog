package com.asiainfo.onlineLog.service.impl;

import com.asiainfo.onlineLog.dao.IOnlineLogDao;
import com.asiainfo.onlineLog.model.ConcreteUse;
import com.asiainfo.onlineLog.model.OverviewUse;
import com.asiainfo.onlineLog.model.TasApproveExp;
import com.asiainfo.onlineLog.service.IOnlineLogService;
import com.asiainfo.onlineLog.util.TabOnloadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by admin on 2017/11/17.
 */
@Service
public class OnlineLogServiceImpl implements IOnlineLogService {


    @Autowired
    IOnlineLogDao onlineLogDao;


    @Override
    public Map queryReasonInfo() {
        return TabOnloadUtil.tasApproveExpMap;
    }

    /**
     * 保存不认可原因信息
     *
     * @param concreteUse
     * @param tasApproveExp
     * @param overviewUse
     * @param nowMonth
     * @param now
     */
    @Override
    public void saveReansonInfo(ConcreteUse concreteUse, TasApproveExp tasApproveExp, OverviewUse overviewUse, String nowMonth, String now) {

        onlineLogDao.saveReansonInfo(concreteUse, tasApproveExp, overviewUse, nowMonth, now);

    }

    /**
     * 判断是否重复查询
     *
     * @param overviewUse
     * @return
     */
    @Override
    public boolean queryIsReQuery(OverviewUse overviewUse) {
        return onlineLogDao.queryIsReQuery(overviewUse);
    }


    /**
     * 操作记录入库
     *
     * @param overviewUse
     * @param ipAddr
     * @param now
     * @param usedTime
     */
    @Override
    public void replaceIntoTasQueryLog(OverviewUse overviewUse, String ipAddr, String now, long usedTime) {
        onlineLogDao.replaceIntoTasQueryLog(overviewUse, ipAddr, now, usedTime);
    }
}
