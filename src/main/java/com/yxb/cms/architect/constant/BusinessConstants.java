
package com.yxb.cms.architect.constant;


/**
 * 系统管理平台业务常量定义
 */
public enum BusinessConstants {

	/**用户状态*/
	SYS_USER_STATUS_0(0,"0-有效"),
	SYS_USER_STATUS_1(1,"1-失效"),



	/**角色状态*/
	SYS_ROLE_STATUS_0(0,"0-有效"),
	SYS_ROLE_STATUS_1(1,"1-失效"),
	
	
	/**菜单资源类型*/
	SYS_RES_TYPE_0(0,"0-菜单"),
	SYS_RES_TYPE_1(1,"1-按钮"),
	
	/**菜单资源状态*/
	SYS_RES_STATUS_0(0,"0-有效"),
	SYS_RES_STATUS_1(1,"1-失效"),
    /**菜单级别*/
    SYS_RES_LEVEL_1(1,"一级菜单"),
    SYS_RES_LEVEL_2(2,"二级菜单"),
    SYS_RES_LEVEL_3(3,"三级菜单"),

    /**公告类型*/
    ANNOUNCEMENT_TYPE_1(1,"系统公告"),
    ANNOUNCEMENT_TYPE_2(2,"活动公告"),

    /**数据清洗类型*/
    CLEAN_DATA_TYPE_1(1,"用户登陆"),

    ;
	

	 BusinessConstants(Integer code, String msg) {
		this.code = code;
		this.msg = msg;
	}

	private Integer code;

	private String msg;
	

	
	
	public String toJson(){

	return "{\"code\":\"" + code + "\",\"msg\":\"" + msg + "!\"}";
		
	}
	
	
	
	
	public BusinessConstants getByCode(Integer code){
		for(BusinessConstants mc : values()){
			if(mc.getCode().equals(code)){
				return mc;
			}
		}
		return null;
	}
	
	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	public static void main(String[] args){
		for (BusinessConstants msg : values()) {
			System.out.println(msg.getCode()+"\t"+msg.getMsg());
		}
	}
}
