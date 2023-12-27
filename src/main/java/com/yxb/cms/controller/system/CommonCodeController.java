package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.CommonCode;
import com.yxb.cms.service.CommonCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("commonCode")
public class CommonCodeController extends BasicController
{

    @Autowired
    private CommonCodeService commonCodeService;

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/commonCode_list.do")
    public String toListPage()
    {
        return "system/commonCode/commonCode_list";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/ajax_commonCode_list.do")
    @ResponseBody
    public String ajaxList(CommonCode commonCode)
    {
        return commonCodeService.selectListBypage(commonCode);
    }

    /**
     *跳转到新增页面
     * @return
     */
    @RequestMapping("/commonCode_add.do")
    public String toAddPage()
    {
        return "system/commonCode/commonCode_add";
    }

    /**
     * 保存信息
     * @return
     */
    @RequestMapping("/ajax_save_commonCode.do")
    @ResponseBody
    public BussinessMsg ajaxSaveCommonCode(CommonCode commonCode)
    {
        try
        {
            return commonCodeService.saveInfo(commonCode);
        }
        catch(Exception e)
        {
            log.error("保存信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_SAVE_ERROR);
        }
    }

    /**
     * 详情页面
     */
    @RequestMapping("/commonCode_detail.do")
    public String toCommonCodeDetailPage(Model model, Integer id)
    {
        CommonCode commonCode = commonCodeService.selectById(id);
        model.addAttribute("commonCode", commonCode);
        return "system/commonCode/commonCode_update";
    }


    /**
     * 保存信息
     * @return
     */
    @RequestMapping("/ajax_update_commonCode.do")
    @ResponseBody
    public BussinessMsg update(CommonCode commonCode)
    {
        try
        {
            return commonCodeService.update(commonCode);
        }
        catch(Exception e)
        {
            log.error("保存信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_SAVE_ERROR);
        }
    }


    /**
     * 删除
     */
    @RequestMapping("/ajax_del_commonCode.do")
    @ResponseBody
    public BussinessMsg deleteById(Integer id)
    {
        try
        {
            return commonCodeService.deleteById(id);
        }
        catch(Exception e)
        {
            log.error("删除信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

}
