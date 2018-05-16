package com.asiainfo.onlineLog.dao;

import com.asiainfo.onlineLog.model.ConcreteUse;
import com.asiainfo.onlineLog.model.OverviewUse;
import com.asiainfo.onlineLog.model.TasApplication;
import com.asiainfo.onlineLog.model.TasApproveExp;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by admin on 2017/11/17.
 */
@Repository
public interface IOnlineLogDao {


    List<TasApplication> queryTasApplictionList();

    List<TasApproveExp> queryTasApproveExpList();


    /**
     * 保存不认可原因信息
     *
     * @param concreteUse
     * @param tasApproveExp
     * @param overviewUse
     * @param nowMonth
     * @param now
     */
    void saveReansonInfo(@Param("concreteUse") ConcreteUse concreteUse, @Param("tasApproveExp") TasApproveExp tasApproveExp,
                         @Param("overviewUse") OverviewUse overviewUse, @Param("nowMonth") String nowMonth, @Param("now") String now);

    /**
     * 判断是否重复查询
     *
     * @param overviewUse
     * @return
     */
    boolean queryIsReQuery(@Param("overviewUse") OverviewUse overviewUse);

    /**
     * 操作记录入库
     *
     * @param overviewUse
     * @param ipAddr
     * @param now
     * @param usedTime
     */
    void replaceIntoTasQueryLog(@Param("overviewUse") OverviewUse overviewUse, @Param("ipAddr") String ipAddr,
                                @Param("now") String now, @Param("usedTime") long usedTime);
}
