
package com.yxb.cms.architect.utils;

import com.yxb.cms.architect.view.ExcelView;
import com.yxb.cms.domain.bo.ExcelExport;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;



/**
 * 公共帮助类
 */
public class CommonHelper{
	
	
	/**
	 * 获得excel model and view
	 * 
	 * @param excelExportBean
	 * @return excel model and view
	 */
	public static ModelAndView getExcelModelAndView(Object excelExportBean){
		return getExcelModelAndView(excelExportBean, null);
	}
	
	/**
	 * 获得excel model and view
	 * 
	 * @param excelExportBean
	 * @return excel model and view
	 */
	public static ModelAndView getExcelModelAndView(Object excelExportBean, String excelName){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put(ExcelView.EXCEL_EXPORT_BEAN, excelExportBean);
		map.put(ExcelView.EXCEL_EXPORT_NAME, excelName);
		if(excelExportBean instanceof ExcelExport){
			map.put(ExcelView.EXCEL_EXPORT_TYPE, ExcelView.EXCEL_EXPORT_TYPE_SINGLE_SHEET);
		}else{
			map.put(ExcelView.EXCEL_EXPORT_TYPE, ExcelView.EXCEL_EXPORT_TYPE_MULTIPLE_SHEET);
		}
		return new ModelAndView(new ExcelView(), map);
	}

}
