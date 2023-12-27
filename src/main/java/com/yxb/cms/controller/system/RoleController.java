
package com.yxb.cms.controller.system;

import com.yxb.cms.architect.annotation.SystemControllerLog;
import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.architect.utils.CommonHelper;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.bo.ExcelExport;
import com.yxb.cms.domain.bo.Tree;
import com.yxb.cms.domain.vo.Role;
import com.yxb.cms.service.ResourceService;
import com.yxb.cms.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * 角色管理Controller
 */
@Controller
@RequestMapping("role")
public class RoleController extends BasicController {


    @Autowired
    private RoleService roleService;
    @Autowired
    private ResourceService resourceService;


    /**
     *跳转到角色列表页面
     * @return
     */
    @RequestMapping("/role_list.do")
    public String toRoleListPage() {
        return "system/role_list";
    }
    /**
     * 加载角色列表List
     * @param role 角色实体
     * @return
     */
    @RequestMapping("/ajax_role_list.do")
    @ResponseBody
    public String ajaxRoleList(Role role){
        return roleService.selectRoleResultPageList(role);
    }

    /**
     * 导出角色列表信息
     * @param role 角色实体
     * @return
     */
    @RequestMapping("/excel_role_export.do")
    public ModelAndView excelRolesExport(Role role){
        ExcelExport excelExport = roleService.excelExportRoleList(role);
        return CommonHelper.getExcelModelAndView(excelExport);
    }



    /**
     * 跳转到角色新增页面
     * @return
     */
    @RequestMapping("/role_add.do")
    public String toRoleAddPage(Model model) {
        //新增页面标识
        model.addAttribute("pageFlag", "addPage");
        return "system/role_edit";
    }

    /**
     * 跳转到角色修改页面
     * @param roleId 角色Id
     * @return
     */
    @RequestMapping("/role_update.do")
    public String roleUpdatePage(Model model,Integer roleId){
        Role role = roleService.selectRoleById(roleId);
        //修改页面标识
        model.addAttribute("pageFlag", "updatePage");
        model.addAttribute("role", role);
        return "system/role_edit";
    }

    /**
     * 保存角色信息
     * @param role 角色实体
     * @return
     */
    @RequestMapping("/ajax_save_role.do")
    @ResponseBody
    @SystemControllerLog(description="保存角色信息")
    public BussinessMsg ajaxSaveRole(Role role){
        try {
            return roleService.saveOrUpdateRole(role, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("保存角色信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_SAVE_ERROR);
        }
    }

    /**
     * 失效角色
     * @param roleId 角色Id
     * @return
     */
    @RequestMapping("/ajax_role_fail.do")
    @ResponseBody
    @SystemControllerLog(description="失效角色")
    public BussinessMsg ajaxRoleFail(Integer roleId){
        try {
            return roleService.updateRoleStatus(roleId, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("失效角色方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_FAILK_ERROR);
        }
    }

    /**
     * 批量失效角色
     * @param roleIds 角色Id
     * @return
     */
    @RequestMapping("/ajax_role_batch_fail.do")
    @ResponseBody
    @SystemControllerLog(description="批销失效角色")
    public BussinessMsg ajaxRoleBatchFail(@RequestParam(value = "roleIds[]") Integer[] roleIds){
        try {
            return roleService.updateRoleBatchStatus(roleIds, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("批量失效角色方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_FAILK_ERROR);
        }
    }

    /**
     * 角色授权页面
     * @param model
     * @param roleId 角色Id
     * @return
     */
    @RequestMapping("/role_grant.do")
    public String roleGrantPage(Model model,Integer roleId){
        Role role = roleService.selectRoleResourcesByRoleId(roleId);
        model.addAttribute("role",role);
        return "system/role_grant";
    }

    /**
     * 获取当前用户所属菜单资源Tree菜单展示
     */
    @RequestMapping("/ajax_resource_tree_list")
    @ResponseBody
    public List<Tree> ajaxResourceTreeList(){
        return resourceService.selectResourceAllTree();
    }


    /**
     * 保存角色资源信息
     * @param roleId        角色Id
     * @param resourceIds   资源菜单Ids
     * @return
     */
    @RequestMapping("/ajax_save_role_res.do")
    @ResponseBody
    @SystemControllerLog(description="角色赋权")
    public BussinessMsg ajaxSaveOrUpdateRoleResource(Integer roleId, @RequestParam(value = "resourceIds[]",required = false) Integer[] resourceIds ){
        try {
            return roleService.saveOrUpdateRoleResource(roleId,resourceIds, this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("保存角色信息授权信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_RES_SAVE_ERROR);
        }
    }


}
