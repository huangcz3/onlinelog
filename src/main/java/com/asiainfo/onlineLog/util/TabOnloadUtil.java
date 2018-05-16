package com.asiainfo.onlineLog.util;

import com.asiainfo.onlineLog.dao.IOnlineLogDao;
import com.asiainfo.onlineLog.model.TasApplication;
import com.asiainfo.onlineLog.model.TasApproveExp;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 2017/11/20.
 */
@Component
public class TabOnloadUtil implements CommandLineRunner {

    private static Logger logger = LoggerFactory.getLogger(TabOnloadUtil.class);


    @Autowired
    private IOnlineLogDao onlineLogDao;

    private List<TasApplication> tasApplicationList;

    private List<TasApproveExp> tasApproveExpList;

    public static Map tasApplicationMap;

    public static Map tasApproveExpMap;


    @Override
    public void run(String... strings) throws Exception {

        tasApplicationMap = new HashMap();

        tasApproveExpMap = new HashMap();

        long begin = System.currentTimeMillis();

        logger.info("Query tasApplication/tasApproveExp from Mysql,start");

        tasApplicationList = onlineLogDao.queryTasApplictionList();

        tasApproveExpList = onlineLogDao.queryTasApproveExpList();

        logger.info("Loop puting List-item into Map...");

        for (TasApplication tasApplication : tasApplicationList) {

            tasApplicationMap.put(tasApplication.getBusiId(),
                    tasApplication.getBusiName() + "&"
                            + tasApplication.getAppType() + "&"
                            + tasApplication.getExplain());
        }
//        logger.info(String.valueOf(tasApplicationMap));

        for (TasApproveExp tasApproveExp : tasApproveExpList) {

            tasApproveExpMap.put(tasApproveExp.getId(), tasApproveExp);
        }
//        logger.info(String.valueOf(tasApproveExpMap));

        long end = System.currentTimeMillis();

        logger.info("time-Use:{}ms == Query tasApplication/tasApproveExp from Mysql,end", end - begin);
    }
}
