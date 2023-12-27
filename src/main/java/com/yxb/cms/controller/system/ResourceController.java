
package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.dao.ResourceMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Resource;
import com.yxb.cms.service.ResourceService;
import java.util.List;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 资源Controller
 */
@Controller
@RequestMapping("res")
public class ResourceController extends BasicController {

    @Autowired
    private ResourceService resourceService;

    @Autowired
    private ResourceMapper resourceMapper;

    /**
     *跳转到资源列表页面
     * @return
     */
    @RequestMapping("/res_list.do")
    public String toResListPage() {
        return "system/res_list";
    }


    /**
     * 加载资源列表List
     * @param resource
     * @return
     */
    @RequestMapping("/ajax_res_list.do")
    @ResponseBody
    public String ajaxResourceList(Resource resource){
        return resourceService.selectResourceResultPageList(resource);
    }

    /**
     * 加载资源列表List
     * @param resource
     * @return
     */
    @RequestMapping("/ajax_res_tree_list.do")
    @ResponseBody
    public String ajaxResourceTreeList(Resource resource){
        List<Resource> resourceList = resourceMapper.selectResourceAllList();
        return Json.toJson(resourceList);
    }


    /**
     * 选择图标
     * @return
     */
    @RequestMapping("/res_img.do")
    public String toResImgPage() {
        return "system/res_img";
    }
    /**
     * 资源添加页面
     * @return
     */
    @RequestMapping("/res_edit.do")
    public String toResEditPage(Model model) {
        //新增页面标识
        model.addAttribute("pageFlag", "addPage");
        return "system/res_edit";
    }

    /**
     * 菜单资源修改页面
     * @param resId 菜单Id
     * @return
     */
    @RequestMapping("/res_update.do")
    public String userUpdatePage(Model model, Integer resId){
        Resource res = resourceService.selectByPrimaryKey(resId);
        Long resParentCount = resourceMapper.selectCountResParentByResId(resId);
        //修改页面标识
        model.addAttribute("pageFlag", "updatePage");
        model.addAttribute("res", res);
        model.addAttribute("resParentCount", resParentCount);
        return "system/res_edit";
    }


    /**
     * 根据菜单类型和菜单级别查询菜单信息
     * @param resType   菜单类型
     * @param resLevel  菜单级别
     * @param resId 菜单Id
     * @return
     */
    @RequestMapping("ajax_res_parent_menu.do")
    @ResponseBody
    public List<Resource> ajaxResParentMenu(Integer resType,Integer resLevel,Integer resId){
        return resourceService.selectParentResListByResTypeAndResLevel(resType,resLevel,resId);
    }


    /**
     * 保存角色信息
     * @param res 角色实体
     * @return
     */
    @RequestMapping("/ajax_save_resource.do")
    @ResponseBody
    public BussinessMsg ajaxSaveResource(Resource res){
        try {
            return resourceService.saveOrUpdateResource(res, this.getCurrentLoginName() );
        } catch (Exception e) {
            log.error("保存用户信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.RES_SAVE_ERROR);
        }
    }


    @RequestMapping("/ajax_res_menu_top.do")
    @ResponseBody
    public String ajaxResMenuTop(){
        return resourceService.selectResMenuTop();
    }

    @RequestMapping("/ajax_res_menu_left.do")
    @ResponseBody
    public String ajaxResMenuLeft(Integer resParentid){
        return resourceService.selectResLevelListByParentid(resParentid);
    }




}
