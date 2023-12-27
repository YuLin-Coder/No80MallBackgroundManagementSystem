package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.CommonCode;
import com.yxb.cms.domain.vo.Hourse;
import com.yxb.cms.service.CommonCodeService;
import com.yxb.cms.service.HourseService;
import com.yxb.cms.util.TokenUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("instoack")
public class InStoackController extends BasicController
{

    @Autowired
    private HourseService hourseService;

    @Autowired
    private CommonCodeService commonCodeService;

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/stoack_list.do")
    public String toListPage(Model model)
    {
        Map<String,Object> qeruy=new HashMap<>();
        qeruy.put("code","type");
        List<CommonCode> commonCodes= commonCodeService.findByMap(qeruy);
        model.addAttribute("codes",commonCodes);
        return "system/stoack/stoack_list";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/ajax_stoack_list.do")
    @ResponseBody
    public String ajaxList(Hourse hourse)
    {
        hourse.setUser_code(TokenUtil.getCurrentUser().getRelationId());
        return hourseService.selectListBypage(hourse);
    }



    /**
     * 详情页面
     */
    @RequestMapping("/in_good.do")
    public String in_good(Model model, Integer id)
    {
        model.addAttribute("id",id);
        return "system/stoack/in_stack";
    }


    /**
     * 进货
     * @return
     */
    @RequestMapping("/in_stack.do")
    @ResponseBody
    public BussinessMsg in_stack(Hourse hourse)
    {
        try
        {
            return hourseService.in_stack(hourse);
        }
        catch(Exception e)
        {
            log.error("保存信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_SAVE_ERROR);
        }
    }


}
