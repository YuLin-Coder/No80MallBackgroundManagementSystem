
package com.yxb.cms.architect.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * 对象转换解析工具类
 */
public class ParseObjectUtils {
	
	
	/**
	 * 将以逗号分割的字符串数组转换为Int型数组
	 * @param strs 逗号分割字符
	 * @return
	 */
	public static Integer[] strArrayToIntArray(String strs){
		if(StringUtils.isNotEmpty(strs)){
			String[] str=strs.split(",");
			
			Integer[] intArray = new Integer[str.length];
			for (int i = 0; i < str.length; i++) {
				intArray[i] = Integer.parseInt(str[i]);
			}
			return intArray;
		}
		return new Integer[0];
	}
		
	

}
