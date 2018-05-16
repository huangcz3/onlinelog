package com.asiainfo;

import java.util.Comparator;
import java.util.Map;

/**
 * Created by admin on 2017/11/23.
 */
public class MapComparator implements Comparator<Map.Entry<Integer, String>> {

    @Override
    public int compare(Map.Entry<Integer, String> o1, Map.Entry<Integer, String> o2) {
        return o2.getKey().compareTo(o1.getKey());
    }
}
