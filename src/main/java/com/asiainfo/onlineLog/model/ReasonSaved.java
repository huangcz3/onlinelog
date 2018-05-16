package com.asiainfo.onlineLog.model;

import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * Created by admin on 2017/12/4.
 */
public class ReasonSaved {

    @NotBlank(message = "id不能为空...")
    private String id;

    @NotNull(message = "overviewUse不能为空")
    private OverviewUse overviewUse;

    @NotNull(message = "concreteUseList不能为空")
    //@Valid    对泛型中的属性进行验证 如这里的:ConcreteUse
    private List<ConcreteUse> concreteUseList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public OverviewUse getOverviewUse() {
        return overviewUse;
    }

    public void setOverviewUse(OverviewUse overviewUse) {
        this.overviewUse = overviewUse;
    }

    public List<ConcreteUse> getConcreteUseList() {
        return concreteUseList;
    }

    public void setConcreteUseList(List<ConcreteUse> concreteUseList) {
        this.concreteUseList = concreteUseList;
    }
}
