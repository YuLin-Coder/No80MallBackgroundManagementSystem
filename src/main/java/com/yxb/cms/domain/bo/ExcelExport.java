
package com.yxb.cms.domain.bo;


import com.yxb.cms.architect.view.ExcelView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * excel sheet导出条件封装类
 */
public class ExcelExport {
	/**
	 * excel导出的表头(必填)
	 */
	private List<String> titles = new ArrayList<String>();
	
	/**
	 * excel导出的列名(必填)
	 */
	private List<String> columns = new ArrayList<String>();
	/**
	 * excel导出的列的类型，目前支持String, Date, SysParameter, User<br>
	 * 例如列表的每一项可以是:<br>
	 * String(原始值)<br>
	 * Date或者Date_yyyy-MM(默认yyyy-MM-dd，可以自定义，下划线带上即可)<br>
	 * SysParameter_COMMON_STATUS(返回参数对应的参数descr)<br>
	 * User(返回id对应的用户名)<br>
	 * 如果不写，默认全部为String
	 */
	private List<String> columnTypes = new ArrayList<String>();
	
	/**
	 * 查询sql，这里禁用hql(必填)
	 */
	private String sql;
	
	/**
	 * 查询sql的参数，对象数组形式
	 */
	private Object[] paramsObj;
	
	/**
	 * 查询sql的参数，map形式
	 */
	private Map<String, Object> paramsMap;
	
	/**
	 * 数据列表（有数据，就不需要设置sql了）
	 */
	private List<?> dataList;
	
	/**
	 * 默认为"Export"，完整格式为："Export_N"，N为sheet下标，从1开始，每5w条记录换一个sheet
	 */
	private String sheetName;
	
	/**
	 * 添加列信息
	 * 
	 * @param title
	 * @param column
	 * @param columnType
	 */
	public void addColumnInfo(String title, String column, String columnType){
		titles.add(title);
		columns.add(column);
		columnTypes.add(columnType);
	}
	
	/**
	 * 添加列信息
	 * @param title
	 * @param column
	 */
	public void addColumnInfo(String title, String column){
		addColumnInfo(title, column, ExcelView.COLUMN_TYPE_STRING);
	}

	/**
	 * @return Returns the titles.
	 */
	public List<String> getTitles() {
		return titles;
	}

	/**
	 * @return Returns the columns.
	 */
	public List<String> getColumns() {
		return columns;
	}

	/**
	 * @return Returns the columnTypes.
	 */
	public List<String> getColumnTypes() {
		return columnTypes;
	}

	/**
	 * @return Returns the sql.
	 */
	public String getSql() {
		return sql;
	}

	/**
	 * @param sql The sql to set.
	 */
	public void setSql(String sql) {
		this.sql = sql;
	}

	/**
	 * @return Returns the paramsObj.
	 */
	public Object[] getParamsObj() {
		return paramsObj;
	}

	/**
	 * @param paramsObj The paramsObj to set.
	 */
	public void setParamsObj(Object[] paramsObj) {
		this.paramsObj = paramsObj;
	}

	/**
	 * @return Returns the paramsMap.
	 */
	public Map<String, Object> getParamsMap() {
		return paramsMap;
	}

	/**
	 * @param paramsMap The paramsMap to set.
	 */
	public void setParamsMap(Map<String, Object> paramsMap) {
		this.paramsMap = paramsMap;
	}

	/**
	 * @return Returns the sheetName.
	 */
	public String getSheetName() {
		return sheetName;
	}

	/**
	 * @param sheetName The sheetName to set.
	 */
	public void setSheetName(String sheetName) {
		this.sheetName = sheetName;
	}

	/**
	 * @return Returns the dataList.
	 */
	public List<?> getDataList() {
		return dataList;
	}

	/**
	 * @param dataList The dataList to set.
	 */
	public void setDataList(List<?> dataList) {
		this.dataList = dataList;
	}
}
