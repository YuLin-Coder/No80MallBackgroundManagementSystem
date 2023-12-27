
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BusinessConstants;
import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.architect.utils.ParseObjectUtils;
import com.yxb.cms.dao.ResourceMapper;
import com.yxb.cms.dao.RoleMapper;
import com.yxb.cms.dao.RoleResourceMapper;
import com.yxb.cms.dao.UserRoleMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.bo.ExcelExport;
import com.yxb.cms.domain.vo.Resource;
import com.yxb.cms.domain.vo.Role;
import com.yxb.cms.domain.vo.RoleResource;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 角色信息服务类
 */

@Service
public class RoleService {

    private Logger log = LogManager.getLogger(RoleService.class);


    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleResourceMapper roleResourceMapper;
    @Autowired
    private ResourceMapper resourceMapper;
    @Autowired
    private ShiroService shiroService;
    /**
     * 根据角色Id查询角色信息
     *
     * @param roleId 角色Id
     * @return
     */
    public Role selectRoleById(Integer roleId) {
        return roleMapper.selectByPrimaryKey(roleId);
    }

    /**
     * 角色信息分页显示
     *
     * @param role 角色实体
     * @return
     */
    public String selectRoleResultPageList(Role role) {

        List<Role> roleList = roleMapper.selectRoleListByPage(role);
        if(null != roleList && !roleList.isEmpty()){
            for (Role r : roleList) {
                Role rr = selectRoleResourcesByRoleId(r.getRoleId());
                r.setResourceIds(rr.getResourceIds());
                r.setResourceNames(rr.getResourceNames());
            }

        }
        Long count = roleMapper.selectCountRole(role);

        Map<String, Object> map = new HashMap<String, Object>();

        map.put("code",0);
        map.put("msg","");
        map.put("count",count);
        map.put("data", roleList);

        return Json.toJson(map);
    }

    /**
     * 角色列表EXCEL导出
     * @param role 角色实体
     * @return
     */
    public ExcelExport excelExportRoleList(Role role){
        ExcelExport excelExport = new ExcelExport();
        List<Role> roleList = this.selectRoleList(role);
        excelExport.addColumnInfo("角色名称","roleName");
        excelExport.addColumnInfo("角色状态","roleStatus_Lable");
        excelExport.addColumnInfo("菜单资源","resourceNames");
        excelExport.addColumnInfo("角色说明","roleRemark");
        excelExport.addColumnInfo("创建人","creator");
        excelExport.addColumnInfo("创建时间","createTime_Lable");
        excelExport.addColumnInfo("修改人","modifier");
        excelExport.addColumnInfo("修改时间","updateTime_Lable");

        excelExport.setDataList(roleList);
        return excelExport;
    }

    /**
     * 角色列表信息List
     * @param role 角色实体
     * @return
     */
    public List<Role> selectRoleList(Role role){

        List<Role> roleList = roleMapper.selectRoleList(role);
        if (null != roleList && !roleList.isEmpty()){
            for (Role r : roleList) {
                Role rr = selectRoleResourcesByRoleId(r.getRoleId());
                r.setResourceIds(rr.getResourceIds());
                r.setResourceNames(rr.getResourceNames());
            }
        }
        return roleList;
    }

    /**
     * 角色状态失效
     * @param roleId	角色Id
     * @param loginName 当前登录用户名
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg updateRoleStatus(Integer roleId,String loginName) throws Exception{
        log.info("角色失效开始，当前角色Id:"+roleId);
        long start = System.currentTimeMillis();
        try {

            //解除用户与角色绑定关系
            userRoleMapper.deleteUserRoleByRoleId(roleId);
            //解除角色与菜单绑定关系
            roleResourceMapper.deleteRoleResourceByRoleId(roleId);

            //更改角色状态为1-失效
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("roleStatus", BusinessConstants.SYS_ROLE_STATUS_1.getCode());
            params.put("modifier", loginName);
            params.put("modifierTime", new Date());
            params.put("roleId", roleId);
            roleMapper.updateRoleByStatus(params);


            // 清空用户权限缓存信息
            shiroService.clearAllCacheAuth();


        } catch (Exception e) {
            log.error("角色失效方法内部错误",e);
            throw e;
        }finally {
            log.info("角色失效结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /**
     * 批量角色状态失效
     * @param roleIds	角色Id
     * @param loginName 当前登录用户名
     * @return
     * @throws Exception
     */
    public BussinessMsg updateRoleBatchStatus(Integer[] roleIds,String loginName) throws Exception{
        log.info("批量失效角色开始，当前角色Id:"+Arrays.toString(roleIds));
        long start = System.currentTimeMillis();
        try {
            if(null != roleIds && roleIds.length > 0){
                for (Integer roleId : roleIds) {
                    //解除用户与角色绑定关系
                    userRoleMapper.deleteUserRoleByRoleId(roleId);
                    //解除角色与菜单绑定关系
                    roleResourceMapper.deleteRoleResourceByRoleId(roleId);

                    //更改角色状态为1-失效
                    Map<String, Object> params = new HashMap<String, Object>();
                    params.put("roleStatus", BusinessConstants.SYS_ROLE_STATUS_1.getCode());
                    params.put("modifier", loginName);
                    params.put("modifierTime", new Date());
                    params.put("roleId", roleId);
                    roleMapper.updateRoleByStatus(params);
                }

                // 清空用户权限缓存信息
                shiroService.clearAllCacheAuth();
            }

        } catch (Exception e) {
            log.error("批量失效角色方法内部错误",e);
            throw e;
        }finally {
            log.info("批量失效角色结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }




    /**
     * 保存角色信息
     *
     * @param role      角色对象
     * @param loginName 当前登录用户
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveOrUpdateRole(Role role, String loginName) throws Exception {
        log.info("保存用户角色开始");
        long start = System.currentTimeMillis();
        try {
            //验证角色名称唯一性
            Long checkRoleName = roleMapper.selectRoleNameCheck(role.getRoleName(),role.getRoleId());
            if(checkRoleName.intValue() > 0){
                return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_NAME_EXIST);
            }

            //保存角色信息
            if (null == role.getRoleId()) {
                role.setCreator(loginName);
                role.setCreateTime(new Date());
                roleMapper.insertSelective(role);
            } else {
                //更新角色
                role.setModifier(loginName);
                role.setModifierTime(new Date());
                roleMapper.updateByPrimaryKeySelective(role);
            }
        } catch (Exception e) {
            log.error("保存角色方法内部错误", e);
            throw e;
        } finally {
            log.info("保存角色信息结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }


    /**
     * 查询状态为有效,待分配的角色信息(用以用户分配角色时显示)
     * @param roleIds 已分配角色Id,以逗号分割
     */
    public String selectUserRoleByRoleIdList(String roleIds){
        Map<String, Object> map = new HashMap<String, Object>();
        //如果已给用户分配角色,则待分配用户显示栏中去除已分配的角色信息
        if(StringUtils.isNotEmpty(roleIds)){
            Integer[] roleIdInt = ParseObjectUtils.strArrayToIntArray(roleIds);
            List<Role> lists = roleMapper.selectUserRoleByRoleIdList(roleIdInt);
            map.put("rows", lists);
            return Json.toJson(map);
        }
        map.put("rows", roleMapper.selectRoleListByStatus());
        //没有给用户分配角色,待分配显示栏中显示所有角色信息
        return Json.toJson(map);
    }
    /**
     * 查询状态为有效,已分配的角色信息(用已用户分配角色显示)
     * @param roleIds 角色Id
     * @return
     */
    public String selectDeceasedUserRoleByRoleIdList(String roleIds){
        Map<String, Object> map = new HashMap<String, Object>();
        //没有给用户分配角色，则已分配角色列表为空
        if(StringUtils.isNotEmpty(roleIds)){
            Integer[] roleIdInt = ParseObjectUtils.strArrayToIntArray(roleIds);
            List<Role> lists = roleMapper.selectDeceasedUserRoleByRoleIdList(roleIdInt);
            map.put("rows", lists);
            return Json.toJson(map);
        }
        return null;
    }


    /**
     * 根据roleId查询角色资源信息
     * @param roleId 角色Id
     * @return
     */
    public Role selectRoleResourcesByRoleId(Integer roleId){

        StringBuilder sb = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();

        if(null != roleId){
            Role role = roleMapper.selectByPrimaryKey(roleId);
            List<RoleResource> roleRes =  roleResourceMapper.selectRoleResourceByRoleId(roleId);
            if(null != roleRes && !roleRes.isEmpty()){
                for (RoleResource r : roleRes) {
                    Resource res = resourceMapper.selectByPrimaryKey(r.getResourceId());
                    if(res != null){
                        //取得当前角色所属资源的ID以逗号拼接
                        sb.append(res.getResId()).append(",");
                        //取得当前角色所属资源的名称以逗号拼接
                        sb2.append(res.getResName()).append(",");
                    }
                }
                //将拼接后的资源信息的最后一个逗号删除
                if(sb.length()>0){
                    sb.deleteCharAt(sb.length()-1);
                }
                if(sb2.length()>0){
                    sb2.deleteCharAt(sb2.length()-1);
                }
            }

            //赋给角色实体,方便页面显示
            role.setResourceNames(sb2.toString());
            role.setResourceIds(sb.toString());
            return role;
        }
        return null;
    }


    /**
     * 保存角色信息授权信息
     * @param roleId        角色Id
     * @param resourceIds    资源Id数组
     * @param loginName     当前登陆用户名
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveOrUpdateRoleResource(Integer roleId, Integer[] resourceIds,String loginName) throws Exception {
        log.info("保存角色信息授权信息开始,参数,roleId:"+roleId+",resourceIds:"+ Arrays.toString(resourceIds));
        long start = System.currentTimeMillis();
        try {
            if(null != resourceIds && resourceIds.length > 0){

                List<RoleResource> roleNotRes  = roleResourceMapper.selectRoleResourceByRoleId(roleId);
                if(null!= roleNotRes && !roleNotRes.isEmpty()){
                    for (RoleResource roleNotRe : roleNotRes) {
                        roleResourceMapper.deleteByPrimaryKey(roleNotRe.getRoleResId());
                    }
                }
                for (Integer resourceId : resourceIds) {


                    //保存角色资源信息
                    RoleResource roleResource = new RoleResource();
                    roleResource.setRoleId(roleId);
                    roleResource.setResourceId(resourceId);
                    roleResource.setCreator(loginName);
                    roleResource.setCreateTime(new Date());
                    roleResourceMapper.insertSelective(roleResource);
                }

            }else{   //如果资源Id为空，则清空当前角色所有的菜单资源信息
                roleResourceMapper.deleteRoleResourceByRoleId(roleId);
            }
            // 清空用户权限缓存信息
            shiroService.clearAllCacheAuth();



        } catch (Exception e) {
            log.error("保存角色信息授权信息方法内部错误", e);
            throw e;
        } finally {
            log.info("保存角色信息授权信息结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }
}
