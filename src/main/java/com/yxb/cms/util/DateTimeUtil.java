package com.yxb.cms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

public class DateTimeUtil
{
    //时间格式化
    final static SimpleDateFormat sdfDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //日期格式化
    final static SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");

    final static String sdfDatePattern="yyyyMMddHHmmss";

    /**
     * 时间转字符串
     *
     * @return
     */
    public static String dateTimeToLocalString(Date fromDateTime) {
        String toDateTime = sdfDateTime.format(fromDateTime);
        return toDateTime;
    }

    /**
     * 日期转字符串
     *
     * @return
     */
    public static String dateToLocalString(Date fromDateTime) {
        String toDateTime = sdfDate.format(fromDateTime);
        return toDateTime;
    }

    /**
     * 字符串转日期&时间
     *
     * @param fromDateTime
     * @return
     */
    public static Date localStringToDateOrTime(String fromDateTime) {
        Date date = null;
        try {
            if (fromDateTime.length() <= 10) {
                //日期字符串转日期
                date = sdfDate.parse(fromDateTime);
            }else if (fromDateTime.length() >= 10) {
                //时间字符串转时间
                date = sdfDateTime.parse(fromDateTime);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 获取时间差(H)
     *
     * @param oDate
     * @param nDate
     * @return
     */
    public static long diffH(Date oDate, Date nDate) {
        long oDateTime = oDate.getTime();
        long nDateTime = nDate.getTime();
        long diffH = (nDateTime - oDateTime) / (1000 * 60 * 60);
        return diffH;
    }

    public static void main(String[] args) {
        Date date1 = localStringToDateOrTime("2017-08-30 11:11:11");
        long l = diffH(date1, new Date());
        System.out.println(l);
        System.out.println(dateToLocalString(new Date()));
        System.out.println(dateTimeToLocalString(new Date()));
        System.out.println(localStringToDateOrTime("2017-08-30 11:11:11"));
        LocalDate date=LocalDate.now();
        LocalTime time=LocalTime.now();
        System.out.println(date+" "+time);
    }

    public static String getUserCode(){
        String usercode = new SimpleDateFormat(sdfDatePattern).format(new Date());
        return usercode;
    }
}
