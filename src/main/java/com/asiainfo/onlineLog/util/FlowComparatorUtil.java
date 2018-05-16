package com.asiainfo.onlineLog.util;

import com.asiainfo.onlineLog.model.ConcreteUse;

import java.util.Comparator;
import java.util.Map;

/**
 * Created by admin on 2017/11/23.
 */
public class FlowComparatorUtil implements Comparator<Map.Entry<String, ConcreteUse>> {
    @Override
    public int compare(Map.Entry<String, ConcreteUse> o1, Map.Entry<String, ConcreteUse> o2) {

        if (o1.getValue().getAliasFlow() < o2.getValue().getAliasFlow()) {
            return 1;
        } else if (o1.getValue().getAliasFlow() == o2.getValue().getAliasFlow()) {
            return 0;
        } else {
            return -1;
        }

        //return String.valueOf(o2.getValue().getAliasFlow()).compareTo(String.valueOf(o1.getValue().getAliasFlow()));
    }
}
