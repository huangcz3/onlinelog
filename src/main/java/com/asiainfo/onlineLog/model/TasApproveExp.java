package com.asiainfo.onlineLog.model;

/**
 * Created by admin on 2017/11/20.
 */
public class TasApproveExp {

    private String id;

    private String situation;

    private String reason;

    public TasApproveExp() {
    }

    public TasApproveExp(String id, String situation, String reason) {
        this.id = id;
        this.situation = situation;
        this.reason = reason;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSituation() {
        return situation;
    }

    public void setSituation(String situation) {
        this.situation = situation;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
