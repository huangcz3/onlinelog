package com.asiainfo.onlineLog.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * 日期工具类
 */
public class DateUtil {

    private static final Logger logger = LoggerFactory.getLogger(DateUtil.class);

    public static final DateTimeFormatter monthFormatter = DateTimeFormatter.ofPattern("yyyyMM");

    public static final DateTimeFormatter dayFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");

    private static final DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");

    public static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");


    public static final LocalTime tclShouldTime = LocalTime.of(10, 0, 0);


//    public String twoDaysAgo = DateUtil.getDayDataDate(2);     //两天前
//
//    public String threeDaysAgo = DateUtil.getDayDataDate(3);   //三天前
//
//
//    public String fourDaysAgo = DateUtil.getDayDataDate(4);   //四天前
//
//
//    public String oneMonthAgo = DateUtil.getMonthDataDate(1);  //一个月前
//
//    public String twoMonthAgo = DateUtil.getMonthDataDate(2);  //两个月前

    /**
     * delayValue 时效性参数：1、两天    2、一个月
     */

    public static final int delayValDay = 2;

    public static final int delayValMonth = 1;


    public static String getMonthDataDate(int delayValue) {
        LocalDate localDate = LocalDate.now();
        localDate = localDate.minusMonths(delayValue);
        return localDate.format(monthFormatter);
    }

    public static String getDayDataDate(int delayValue) {
        LocalDate localDate = LocalDate.now();
        localDate = localDate.minusDays(delayValue);
        return localDate.format(dayFormatter);
    }


    public static void main(String[] args) {
        System.out.println(DateUtil.getMonthDataDate(1));
        System.out.println(DateUtil.getDayDataDate(1));
        System.out.println();
    }
}
