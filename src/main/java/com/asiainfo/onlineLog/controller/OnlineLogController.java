package com.asiainfo.onlineLog.controller;

import com.asiainfo.biframe.utils.string.DES;
import com.asiainfo.onlineLog.Asynchronize.SaveRsTask;
import com.asiainfo.onlineLog.model.*;
import com.asiainfo.onlineLog.service.IHBaseService;
import com.asiainfo.onlineLog.service.IOnlineLogService;
import com.asiainfo.onlineLog.util.FlowComparatorUtil;
import com.asiainfo.onlineLog.util.IpUtil;
import com.asiainfo.onlineLog.util.ResultUtil;
import com.asiainfo.onlineLog.util.TabOnloadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ExecutionException;

/**
 * Created by admin on 2017/11/16.
 */
@Controller
@RequestMapping("/onlineLog")
public class OnlineLogController {

    private static Logger logger = LoggerFactory.getLogger(OnlineLogController.class);

    @Autowired
    private IOnlineLogService onlineLogService;

    @Autowired
    private IHBaseService hBaseService;

    @Autowired
    private SaveRsTask saveRsTask;

    @ResponseBody
    @RequestMapping("/compGprsBill")
    public Result compGprsBill(@RequestBody @Valid OverviewUse overviewUse, BindingResult bindingResult) {

        DecimalFormat df = new DecimalFormat("0.000");

        if (bindingResult.hasErrors()) {
            return ResultUtil.error(bindingResult.getFieldError().getDefaultMessage());
        }

        String loginUserId1 = null;
        String phoneNo1 = null;
        String startTime1 = null;
        String endTime1 = null;
        String billNo1 = null;
        String chargeId1 = null;
        String flow1 = null;

        try {

            phoneNo1 = DES.decrypt(overviewUse.getPhoneNo());
            if (phoneNo1.length() != 11) {
                logger.error("phoneNo:{} < 手机号解析长度异常 > {}位", phoneNo1, phoneNo1.length());
                return ResultUtil.error("手机号解析长度异常 >");
            }
            loginUserId1 = DES.decrypt(overviewUse.getLoginUserId());


            startTime1 = DES.decrypt(overviewUse.getStartTime());

            endTime1 = DES.decrypt(overviewUse.getEndTime());

            logger.info("startTime:{}   ,endTime:{}", startTime1, endTime1);

            billNo1 = DES.decrypt(overviewUse.getBillNo());
            chargeId1 = DES.decrypt(overviewUse.getChargeId());
            flow1 = String.valueOf(df.format(Float.parseFloat(DES.decrypt(overviewUse.getFlow())) / 1024));

        } catch (Exception e) {

            logger.error("phoneNo:{} < 参数格式解析错误,请检查! > ", phoneNo1);

        }

        HashMap map = new HashMap();

        OverviewUse overviewUse1 = new OverviewUse(phoneNo1, loginUserId1, startTime1, endTime1, billNo1, chargeId1, flow1);

        map.put("overviewUse1", overviewUse1);

        return ResultUtil.success(map);

    }

    @ResponseBody
    @GetMapping("/compGprsBillInfo")
    public Result queryCompGprsBillInfo(HttpServletRequest request,
                                        @RequestParam(value = "phoneNo") String phoneNo,
                                        @RequestParam(value = "startTime") String startTime,
                                        @RequestParam(value = "endTime") String endTime,
                                        @RequestParam(value = "flow") String flow,
                                        @RequestParam(value = "loginUserId") String loginUserId,
                                        @RequestParam(value = "chargeId") String chargeId,
                                        @RequestParam(value = "billNo") String billNo) {

        HashMap result;

        ConcreteUse concreteUse;


        String startTime1 = startTime.replaceAll("[^\\d]", "");
        String endTime1 = endTime.replaceAll("[^\\d]", "");

        long begin1 = System.currentTimeMillis();

        logger.info("phoneNo:{} < QueryCompGprsBillInfo, Begin > ", phoneNo);

        Map map = hBaseService.queryCompGprsBillInfo(phoneNo, startTime1, endTime1);

        Map<String, ConcreteUse> concreteUseMap = (Map<String, ConcreteUse>) map.get("concreteUseMap");

        long usedTime = (long) map.get("usedTime");

        logger.info("phoneNo:{} < time-Use:{}ms == QueryCompGprsBillInfo, end > ", phoneNo, System.currentTimeMillis() - begin1);

        Set set = concreteUseMap.keySet();

        Iterator iterator = set.iterator();

        long begin2 = System.currentTimeMillis();

        logger.info("phoneNo:{} < Calculate percent of aliasFlow, Begin >", phoneNo);

        while (iterator.hasNext()) {

            concreteUse = concreteUseMap.get(iterator.next());

            if (Float.parseFloat(flow) == 0) {

                concreteUse.setPercent("0");

            } else {

                DecimalFormat df = new DecimalFormat("0.00");

                float percent = (concreteUse.getAliasFlow() / Float.valueOf(flow).floatValue()) * 100;

                concreteUse.setPercent(df.format(percent));
            }

        }

        logger.info("phoneNo:{} < time-Use:{}ms == Calculate percent of aliasFlow, end > ", phoneNo, System.currentTimeMillis() - begin2);


        long begin = System.currentTimeMillis();

        logger.info("phoneNo:{} < Order by concreteUse.aliasFlow, Begin > ", phoneNo);

        List<ConcreteUse> concreteUseList = new ArrayList<ConcreteUse>();

        int groupCount = concreteUseMap.size();

        FlowComparatorUtil flowComparatorUtil = new FlowComparatorUtil();

        List<Map.Entry<String, ConcreteUse>> list = new ArrayList<Map.Entry<String, ConcreteUse>>();

        list.addAll(concreteUseMap.entrySet());

        Collections.sort(list, flowComparatorUtil);

        for (Map.Entry<String, ConcreteUse> entry : list) {

            concreteUseList.add(entry.getValue());

        }

        long end = System.currentTimeMillis();

        logger.info("phoneNo:{} < time-Use:{}ms == Order by concreteUse.aliasFlow, End > ", phoneNo, end - begin);

        LocalDateTime localDateTime = LocalDateTime.now();

        String now = localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        OverviewUse overviewUse = new OverviewUse(phoneNo, loginUserId, startTime, endTime, billNo, chargeId, flow);

        String ipAddr = IpUtil.getIpAddr(request);

        result = new HashMap();

        result.put("ipAddr", ipAddr);

        result.put("now", now);

        result.put("overviewUse", overviewUse);

        result.put("usedTime", usedTime);

        result.put("groupCount", groupCount);

        result.put("concreteUseList", concreteUseList);

        return ResultUtil.success(result);
    }

    @ResponseBody
    @GetMapping("/queryReasonInfo")
    public Result queryReasonInfo() {

        Map tasApproveExpMap = onlineLogService.queryReasonInfo();

        return ResultUtil.success(tasApproveExpMap);
    }

    @ResponseBody
    @PostMapping("/saveReansonInfo")
    public Result saveReansonInfo(@RequestBody @Valid ReasonSaved reasonSaved, BindingResult bindingResult) throws ExecutionException, InterruptedException {

        if (bindingResult.hasErrors()) {

            return ResultUtil.error(bindingResult.getFieldError().getDefaultMessage());

        }

        String id = reasonSaved.getId();

        OverviewUse overviewUse = reasonSaved.getOverviewUse();

        List<ConcreteUse> concreteUseList = reasonSaved.getConcreteUseList();

        String nowMonth = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));

        TasApproveExp tasApproveExp = (TasApproveExp) TabOnloadUtil.tasApproveExpMap.get(id);

        LocalDateTime localDateTime = LocalDateTime.now();

        String now = localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        long begin = System.currentTimeMillis();

        logger.info("phoneNo:{}  < saveReasonInfo,start >", overviewUse.getPhoneNo());

        saveRsTask.saveRsInfo(concreteUseList, tasApproveExp, overviewUse, nowMonth, now);

        /*Future<String> saveRsResult = saveRsTask.saveRsInfo(concreteUseList, tasApproveExp, overviewUse, nowMonth, now);

        while (true) {

            if (saveRsResult.isDone()) {

                logger.info("saveReasonInfo -> result:{}", saveRsResult.get());

                break;

            }

            Thread.sleep(1000);

        }*/

        logger.info("phoneNo:{}  < saveReasonInfo,end  usedTime:{}ms >", overviewUse.getPhoneNo(), System.currentTimeMillis() - begin);

        return ResultUtil.success();
    }
}
