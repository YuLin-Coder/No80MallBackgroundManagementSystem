
package com.yxb.cms.architect.utils;

import com.yxb.cms.architect.constant.Constants;
import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

/**
 * 获取客户端IP地址
 */
public class ClientIpUtil {


    /**
     * 获取客户端IP地址
     * @param request 请求
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            if (ip.equals("127.0.0.1")) {
                //根据网卡取本机配置的IP
                InetAddress inet = null;
                try {
                    inet = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                ip = inet.getHostAddress();
            }
        }
        // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ip != null && ip.length() > 15) {
            if (ip.indexOf(",") > 0) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        return ip;
    }

    /**
     * 获取IP返回地理位置
     * @param ipAddr ip地址
     * @return
     */
    public static String getIpAddrSource(String ipAddr){
        if(null != ipAddr){
            String url = Constants.IP_INFO_API_URL;
            Map<String,Object> param = new HashMap<>();
            param.put("ip",ipAddr);
            String result =  HttpUtil.post(url,param);
            if(null != result){
                JSONObject obj = JSONObject.fromObject(result);
                //查询返回结果成功
                if("0".equals(obj.get("code").toString())){
                    JSONObject obj2 =  (JSONObject) obj.get("data");
                    return obj2.get("region")+" " +obj2.get("city");
                }
            }
        }
        return null;
    }
}