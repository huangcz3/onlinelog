package com.asiainfo.onlineLog.service.impl;

import com.asiainfo.onlineLog.model.ConcreteUse;
import com.asiainfo.onlineLog.service.IHBaseService;
import com.asiainfo.onlineLog.util.MD5RowKeyGenerator;
import com.asiainfo.onlineLog.util.TabOnloadUtil;
import org.apache.phoenix.jdbc.PhoenixResultSet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 2017/11/20.
 */
@Service
public class HBaseServiceImpl implements IHBaseService {

    @Autowired
    @Qualifier("connect")
    private Connection connection;

    private final Logger logger = LoggerFactory.getLogger(HBaseServiceImpl.class);


    /**
     * 根据电话号码获取具体信息
     *
     * @param phoneNo, startTime, endTime
     * @return List
     */
    @Override
    public Map<String, ConcreteUse> queryCompGprsBillInfo(String phoneNo, String startTime, String endTime) {

        String sql;
        String month1 = null;
        String month2 = null;
        String md5PhoneNo = null;

        try {

            month1 = startTime.substring(0, 6);
            month2 = endTime.substring(0, 6);

        } catch (Exception e) {

            logger.error("phoneNo:{}  < 时间参数格式异常,请检查: > start,end Time", phoneNo);

        }


        try {

            md5PhoneNo = new MD5RowKeyGenerator().generatePrefix(phoneNo);
        } catch (Exception e) {

            logger.error("phoneNo:{} < 手机号参数格式异常,请检查: > phoneNo", phoneNo);
        }

        StringBuffer str1 = new StringBuffer();
        String idStart = str1.append(md5PhoneNo).append(phoneNo).append(startTime).toString();

        StringBuffer str2 = new StringBuffer();
        String idEnd = str2.append(md5PhoneNo).append(phoneNo).append(endTime).toString();


        if (month1.equals(month2)) {

            sql = "select BUSI_ID, count(BUSI_ID) as GROUPCOUNT, SUM(TO_NUMBER(FLOW)/1024/1024) as ALIASFLOW," +
                    " MAX(APP_EXT_FLAG) as APPEXTFLAG," + "MAX(END_TIME) as MAXTIME, MIN(END_TIME) as MINTIME, " +
                    " MAX(TERM_MODEL_ID) as TERMMODELID, " +
                    " MAX(TERM_MODEL_CODE) as TERMMODELCODE " +
                    " from CD_GPRS_" + month1 + " where  ID>= '" + idStart + "' and ID<= '" + idEnd + "' group by BUSI_ID";
        } else {

            StringBuffer str3 = new StringBuffer();

            String month3 = LocalDate.parse(month1 + "01", DateTimeFormatter.ofPattern("yyyyMMdd")).with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyyMMdd"));

            String idEnd1 = str3.append(md5PhoneNo).append(phoneNo).append(month3 + "235959").toString();

            String month4 = month2 + "01000000";

            String idStart1 = str3.append(md5PhoneNo).append(phoneNo).append(month4).toString();

            sql = "select BUSI_ID, count(BUSI_ID) as GROUPCOUNT, SUM(TO_NUMBER(FLOW)/1024/1024) as ALIASFLOW, MAX(APP_EXT_FLAG) as APPEXTFLAG, " +
                    " MAX(END_TIME) as MAXTIME, MIN(END_TIME) as MINTIME, MAX(TERM_MODEL_ID) as TERMMODELID, " +
                    " MAX(TERM_MODEL_CODE) as TERMMODELCODE from " +
                    "(select * from CD_GPRS_" + month1 + " where  ID>= '" + idStart + "' and ID<= '" + idEnd1 +
                    "' union all " +
                    "select * from CD_GPRS_" + month2 + " where  ID> '" + idStart1 + "' and ID<= '" + idEnd + "' ) a group BY BUSI_ID";
        }
        long begin = System.currentTimeMillis();
        logger.info("phoneNo:{} < Query Hbase,start >", phoneNo);
        logger.info(sql);
        long usedTime = 0;
        PreparedStatement pst;
        PhoenixResultSet phoenixResultSet;
        ConcreteUse concreteUse;
        Map<String, ConcreteUse> concreteUseMap = new HashMap<String, ConcreteUse>();
        DecimalFormat df = new DecimalFormat("0.00");
        String[] busiVal1 = new String[3];
        try {
            long wasteBegin = System.currentTimeMillis();
            pst = connection.prepareStatement(sql);
            phoenixResultSet = (PhoenixResultSet) pst.executeQuery();
            long end = System.currentTimeMillis();
            logger.info("phoneNo:{} < time-Use:{}ms == Query Hbase,end> ", phoneNo, end - begin);

            long begin1 = System.currentTimeMillis();

            logger.info("phoneNo:{} < Evaluation for concreteUse,start >", phoneNo);

            while (phoenixResultSet.next()) {

                concreteUse = new ConcreteUse();

                concreteUse.setBusiId(phoenixResultSet.getString("BUSI_ID"));


                long begin2 = System.currentTimeMillis();

                String[] busiVal = String.valueOf(TabOnloadUtil.tasApplicationMap.getOrDefault(concreteUse.getBusiId(), concreteUse.getBusiId())).split("&");

                long begin3 = System.currentTimeMillis();

                if (busiVal.length == 1) {
                    busiVal1[0] = busiVal[0];
                    busiVal1[1] = "其他类型";
                    busiVal1[2] = "无";
                } else if (busiVal.length == 2) {
                    busiVal1[0] = busiVal[0];
                    busiVal1[1] = busiVal[1];
                    busiVal1[2] = "无";
                } else {
                    busiVal1 = busiVal;
                }

                long begin4 = System.currentTimeMillis();

                if (concreteUseMap.containsKey(busiVal1[0])) {

                    ConcreteUse concreteUse1 = concreteUseMap.get(busiVal1[0]);

                    concreteUse1.setGroupCount(String.valueOf(Integer.parseInt(concreteUse1.getGroupCount()) + Integer.parseInt(phoenixResultSet.getString("GROUPCOUNT"))));

                    concreteUse1.setAliasFlow(Float.valueOf(df.format(concreteUse1.getAliasFlow() + phoenixResultSet.getFloat("ALIASFLOW"))));

                } else {

                    concreteUse.setBusiName(busiVal1[0]);
                    concreteUse.setAppType(busiVal1[1]);
                    concreteUse.setExplain(busiVal1[2]);
                    concreteUse.setGroupCount(phoenixResultSet.getString("GROUPCOUNT"));
                    concreteUse.setAliasFlow(Float.valueOf(df.format(phoenixResultSet.getFloat("ALIASFLOW"))).floatValue());
                    concreteUse.setAppExtFlag(phoenixResultSet.getString("APPEXTFLAG"));
                    concreteUse.setMaxTime(phoenixResultSet.getString("MAXTIME"));
                    concreteUse.setMinTime(phoenixResultSet.getString("MINTIME"));
                    concreteUse.setTermModelId(phoenixResultSet.getString("TERMMODELID"));
                    concreteUse.setTermModelCode(phoenixResultSet.getString("TERMMODELCODE"));
                    concreteUseMap.put(busiVal1[0], concreteUse);
                }
            }

            long end1 = System.currentTimeMillis();

            logger.info("phoneNo;{} < time-Use:{}ms == Evaluation for concreteUse,end >", phoneNo, end1 - begin1);
            usedTime = System.currentTimeMillis() - wasteBegin;
        } catch (SQLException se) {
            se.printStackTrace();
        }
        Map map = new HashMap();

        map.put("concreteUseMap", concreteUseMap);
        map.put("usedTime", usedTime);

        return map;

    }
}
