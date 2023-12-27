
package com.yxb.cms.architect.realm;

import com.yxb.cms.domain.vo.Resource;
import com.yxb.cms.domain.vo.User;
import com.yxb.cms.service.ResourceService;
import com.yxb.cms.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import java.util.List;


/**
 * 自定义Realm 实现Shiro权限验证
 */
@Component
public class ShiroDbRealm extends AuthorizingRealm {

    private Logger log = LogManager.getLogger(ShiroDbRealm.class);

    @Autowired
    @Lazy
    private UserService userService;
    @Autowired
    @Lazy
    private ResourceService resourceService;

    /**
     * 获取认证信息
     *
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken userToken = (UsernamePasswordToken) token;
        String username = userToken.getUsername();
        if (StringUtils.isEmpty(username)) {
            log.error("获取认证信息失败，原因:用户名为空");
            throw new AccountException("用户名为空");
        }
        // 根据登陆用户名查询用户信息
        User user = userService.selectUserByloginName(username);
        if (user == null) {
            throw new AccountException("用户信息为空");
        }

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, user.getUserPassword(), getName());
        if (null != info) {
            log.info("用户认证通过:登陆用户名:" + user.getUserLoginName());
            return info;
        }
        return null;
    }


    /**
     * 获取授权信息
     *
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        if (principals == null) {
            throw new AuthorizationException("Principal对象不能为空");
        }

        User user = (User) getAvailablePrincipal(principals);
        log.info("加载用户权限信息，当前登陆用户名:" + user.getUserLoginName());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        //如果登陆用户是admin,拥有所有权限
        if(user.getUserLoginName().equals("admin")){
            List<Resource> resList = resourceService.selectResUrlAllList();
            for (Resource resource : resList) {
                info.addStringPermission(resource.getResModelCode());

            }
        }else{
            List<Resource> resUserList = resourceService.selectResListByUserId(user.getUserId());
            for (Resource resUser : resUserList) {
                info.addStringPermission(resUser.getResModelCode());
            }
        }
        return  info;
    }



    /**
     * 清除所有用户授权信息缓存.
     */
    public void clearAllCachedAuthorizationInfo(){
        log.info("清除所有账号缓存");
        Cache<Object, AuthorizationInfo> cache = getAuthorizationCache();
        if (cache != null){
            for (Object key : cache.keys()) {
                cache.remove(key);
            }
        }
    }
}
