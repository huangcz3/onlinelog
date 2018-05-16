package com.asiainfo;

import com.asiainfo.biframe.utils.string.DES;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.DecimalFormat;
import java.util.*;


public class Decrypt {

    private static Logger logger = LoggerFactory.getLogger(Decrypt.class);

    public static void main(String[] args) throws Exception {
//        if (args.length != 3) {
//            System.out.println("���룺");
//            System.out.println("13541001229 \"2017/07/11 00:00:00\" \"2017/07/13 00:00:00\"");
//            //System.exit(0);
//        String phone_no = DES.decrypt("18380801172");
        String start_time = DES.encrypt("18228044046");
        String end_time = DES.encrypt("2017/09/07 00:00:00");
        String test1 = DES.encrypt("0");
        //String phone_no=DES.encrypt(args[0]);
        //String start_time=DES.encrypt(args[1]);
        //String end_time=DES.encrypt(args[2]);
        String url = "http://10.113.251.150:13080/tas/aibi_tas/comp/compGprsBill.jsp?charge_id=DDD214161B86B440&ailk_autoLogin_userId=E8EC8AEE117C0B5A&phoneNo=" + "&startTime=" + start_time + "&endTime=" + end_time + "&flow=&billNo=E964D3C848BAD7BAA446CC48184D6C68";
//        System.out.println(DES.encrypt("0"));
//        System.out.printf(LocalDate.parse("20171001", DateTimeFormatter.ofPattern("yyyyMMdd")).with(TemporalAdjusters.lastDayOfMonth()).format(DateTimeFormatter.ofPattern("yyyyMMdd")));
//        System.out.printf(String.valueOf("123&456&789".split("&")));
//
//        Map map = new HashMap();
//
//        ConcreteUse concreteUse = new ConcreteUse();
//        concreteUse.setAliasFlow("123.321");
//
//        map.put("c", concreteUse);
//
//        concreteUse = (ConcreteUse) map.get("c");
//        concreteUse.setAliasFlow("321.123");
//
//        System.out.println();
//        map.put(2,"a");
//        map.put(1,"b");
//        map.put(3,"c");
//
//        String a = (String) map.get(1);
//
//        a += "b";
//
//
//        map.forEach((k,v) -> {
//            System.out.println("key=" + k + "value=" + v);
//        });
//
//
//        Set set = map.keySet();
//        Iterator iterator = set.iterator();
//        while(iterator.hasNext()){
//            System.out.printf(String.valueOf(map.get(iterator.next())));
//        }
        float a = 0.165f;
        System.out.println(String.format("%.2f", a));
        DecimalFormat df = new DecimalFormat("0.00");
        System.out.println(df.format(a));
//
//        System.out.println(DES.decrypt("FEB4517A7D866BC9FDDF899E8F3880BD125F45020AA23BD4"));
//        System.out.println(DES.encrypt("100"));
//        System.out.println(DES.encrypt("2017/11/15 00:00:00"));
//
//        List<ConcreteUse> list = new ArrayList();
//        for(int i=0;i<5;i++){
//            ConcreteUse as = new ConcreteUse();
//            as.setAliasFlow(String.valueOf(5-i));
//            list.add(as);
//        }
//
//        list.forEach(v -> {
//            System.out.println(v.getAliasFlow());
//        });

        MapComparator mapComparator = new MapComparator();

        HashMap map = new HashMap<>();
        for (int i = 0; i <= 5; i++) {

            map.put(5 - i, i);

        }
//
//        map.put("xt", "xt");
//        map.put("sc", "sc");
//        map.put("zy", "zy");


//        Iterator iterator1 = map.entrySet().iterator();
//
//        while (iterator1.hasNext()) {
//            Map.Entry entry = (Map.Entry) iterator1.next();
//            System.out.println(entry.getKey());
//        }
        long begin = System.currentTimeMillis();
        System.out.println();
        List<Map.Entry<Integer, String>> list = new ArrayList<Map.Entry<Integer, String>>();
        Collections.sort(list, mapComparator);
        for (Map.Entry<Integer, String> entry : list) {
            System.out.println(entry.getKey());
        }
        long end = System.currentTimeMillis();
        logger.info("{}:{},结束:{},耗时:{}", "start", begin, end, end - begin);

        String phoneNo = DES.encrypt("13699422620");
        String phoneNo1 = DES.encrypt("13908090142");
        String phoneNo2 = DES.encrypt("18428352283");
        String phoneNo3 = DES.encrypt("13699422620");

        System.out.println(phoneNo);
        System.out.println(phoneNo1);
        System.out.println(phoneNo2);
        System.out.println(phoneNo3);

        System.out.println(DES.decrypt("17F197DE3F52A96AA86A6F66F15B7F70719C0F453E3ED3E124ED52FA4D9217FC41BFC97B0ED01E8E133A219B919543ED4ED39A2C34906119415055BA186CEACFBC131BAE107007DDE58D93EB45853D5C1916395B98766BED44379B44721F138DB323A4DEBB5F4C67CE5D5E71DDCF60F7"));

    }
}
