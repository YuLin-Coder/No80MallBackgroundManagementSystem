
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.dao.AnnouncementInfoMapper;
import com.yxb.cms.dao.AnnouncementInfoUserMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.AnnouncementInfo;
import com.yxb.cms.domain.vo.AnnouncementInfoUser;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;


/**
 * 站内公告信息服务
 */

@Service
public class AnnouncementInfoService {

    private Logger log = LogManager.getLogger(AnnouncementInfoService.class);


    @Autowired
    private AnnouncementInfoMapper announcementInfoMapper;
    @Autowired
    private AnnouncementInfoUserMapper announcementInfoUserMapper;


    /**
     * 公告信息分页显示
     *
     * @param annInfo 公告实体
     * @return
     */
    public String selectAnnInfoResultPageList(AnnouncementInfo annInfo) {

        List<AnnouncementInfo> annList = announcementInfoMapper.selectAnnouncementInfoListByPage(annInfo);
        Long count = announcementInfoMapper.selectCountAnnouncementInfo(annInfo);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", annList);

        return Json.toJson(map);
    }

    /**
     * 根据ID查询公告信息
     * @param announcementId  公共Id
     * @return
     */
    public AnnouncementInfo selectAnnouncementInfoById(Integer announcementId){
        return announcementInfoMapper.selectByPrimaryKey(announcementId);
    }

    /**
     * 保存公告信息
     * @param announcementType  公告类型
     * @param announcementTitle 公告标题
     * @param announcementContent 公告内容
     * @param loginName 当前登陆用户
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveAnnouncementInfo(Integer announcementType, String announcementTitle,String announcementContent,String loginName) throws Exception{
        log.info("保存公告信息开始");
        long start = System.currentTimeMillis();
        try {

            AnnouncementInfo anInfo = new AnnouncementInfo();
            anInfo.setAnnouncementType(announcementType);
            anInfo.setAnnouncementTitle(announcementTitle);
            anInfo.setAnnouncementContent(announcementContent);
            anInfo.setAnnouncementAuthor(loginName);
            anInfo.setAnnouncementTime(new Date());
            announcementInfoMapper.insertSelective(anInfo);

        } catch (Exception e) {
            log.error("保存公告信息方法内部错误", e);
            throw e;
        } finally {
            log.info("保存公告信息结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }


    /**
     * 删除公告信息
     * @param announcementId 公告Id
     * @return
     */
    @Transactional
    public BussinessMsg deleteAnnouncementInfo(Integer announcementId){

        log.info("删除公告信息开始,公告Id:"+announcementId);
        long start = System.currentTimeMillis();

        try {
            //删除公告用户关联信息
            announcementInfoUserMapper.deleteAnnInfoUserByAnnouncementId(announcementId);
            //删除公告信息
            announcementInfoMapper.deleteByPrimaryKey(announcementId);
        } catch (Exception e) {
            log.error("删除公告信息方法内部错误", e);
            throw e;
        } finally {

            log.info("删除公告信息结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    /**
     * 查询未读公告列表
     * @param currentLoginId 用户Id
     * @return
     */
    public String selectUnreadAnnInfoListByUserId(Integer currentLoginId) {

        List<AnnouncementInfo> annList = announcementInfoMapper.selectUnreadAnnInfoListByUserId(currentLoginId);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", 0);
        map.put("data", annList);

        return Json.toJson(map);
    }

    /**
     * 查询已读公告列表
     * @param currentLoginId 用户Id
     * @return
     */
    public String selectReadAnnInfoListByUserId(Integer currentLoginId) {

        List<AnnouncementInfo> annList = announcementInfoMapper.selectReadAnnInfoListByUserId(currentLoginId);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", 0);
        map.put("data", annList);

        return Json.toJson(map);
    }

    /**
     * 查询全部公告列表
     * @return
     */
    public String selectAllReadAnnInfoListByUserId() {
        List<AnnouncementInfo> annList = announcementInfoMapper.selectAllReadAnnInfoListByUserId();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", 0);
        map.put("data", annList);

        return Json.toJson(map);
    }


    /**
     * 将当前用户公告信息标记为已读
     * @param announcementId    公告Id
     * @param currentLoginId    当前用户Id
     * @return
     */
    @Transactional
    public BussinessMsg insertReadAnnUserInfo(Integer announcementId,Integer currentLoginId) throws Exception{

        log.info("公告信息标记为已读处理开始,公告Id:"+announcementId);
        long start = System.currentTimeMillis();

        try {
            AnnouncementInfoUser annInfoUser = new AnnouncementInfoUser();
            annInfoUser.setAnnouncementId(announcementId);
            annInfoUser.setUserId(currentLoginId);
            announcementInfoUserMapper.insertSelective(annInfoUser);
        } catch (Exception e) {
            log.error("公告信息标记为已读处理方法内部错误", e);
            throw e;
        } finally {

            log.info("公告信息标记为已读处理结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    /**
     * 将当前用户全部公告信息标记为已读
     * @param announcementId    公告Id
     * @param currentLoginId    当前用户Id
     * @return
     */
    @Transactional
    public BussinessMsg insertAllReadAnnUserInfo(Integer[] announcementIds,Integer currentLoginId)  throws Exception{

        log.info("公告信息全部标记为已读处理开始,公告Id:"+ Arrays.toString(announcementIds));
        long start = System.currentTimeMillis();

        try {
            if(null != announcementIds && announcementIds.length > 0){
                for (Integer announcementId : announcementIds) {
                    AnnouncementInfoUser annInfoUser = new AnnouncementInfoUser();
                    annInfoUser.setAnnouncementId(announcementId);
                    annInfoUser.setUserId(currentLoginId);
                    announcementInfoUserMapper.insertSelective(annInfoUser);
                }
            }

        } catch (Exception e) {
            log.error("公告信息全部标记为已读处理方法内部错误", e);
            throw e;
        } finally {

            log.info("公告信息全部标记为已读处理结束,用时" + (System.currentTimeMillis() - start) + "毫秒");
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

}
