
package com.yxb.cms.architect.utils;

import java.util.ArrayList;
import java.util.List;

/**
 * 定义一些code的生成方式,生成随机数，根据每次的随机结果定义
 */
public class KeyConfig {
		
	static char[] seeds={'1','2','3','4','5','6','7','8','9','0','a','b','c','d','e','f','g','h','i',
        'j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E',
        'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
	
	
	/**
	 * 生成八位资源菜单CODE
	 * @return
	 */
	 public static synchronized String randomResourceModeCode(){
			
			StringBuffer seed= new StringBuffer();
			for (int i = 0; i < 8; i++) {
				//生成一个62内的随机数
				Integer random =  (int) (Math.random()*62);			
				seed.append(seeds[random]);			
			}						
			return seed.toString();
	 }
	
	public static void main(String[] args) throws InterruptedException {
		Integer i=0;
		List<String> seeds= new ArrayList<String>();
		while(i<1000){
			seeds.add(randomResourceModeCode());
			i++;
			Thread.sleep(1L);
		}
	    
	      List<String>  result = new ArrayList<String>();
	      
	     
	     for (String string : seeds) {
			if(result.contains(string)){
				
				System.out.println("seed 重复："+string);			
			}else{
				result.add(string);
				System.out.println(string);
			}
	    	 
		}	     	     	     
	   
		}
	
	
	}
