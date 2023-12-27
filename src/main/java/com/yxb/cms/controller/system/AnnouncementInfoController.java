
package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.dao.AnnouncementInfoMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.AnnouncementInfo;
import com.yxb.cms.service.AnnouncementInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 公告管理Controller

 */
@Controller
@RequestMapping("announcement")
public class AnnouncementInfoController extends BasicController {


    @Autowired
    private AnnouncementInfoService announcementInfoService;

    @Autowired
    private AnnouncementInfoMapper announcementInfoMapper;

    /**
     *跳转到公告列表页面
     * @return
     */
    @RequestMapping("/announcement_list.do")
    public String toAnnouncementListPage() {
        return "system/announcement_list";
    }

    /**
     * 公告列表List
     * @param announcement 公告实体
     * @return
     */
    @RequestMapping("/ajax_announcement_list.do")
    @ResponseBody
    public String ajaxUserList(AnnouncementInfo announcement) {
        return announcementInfoService.selectAnnInfoResultPageList(announcement);
    }

    /**
     *跳转到公告新增页面
     * @return
     */
    @RequestMapping("/announcement_add.do")
    public String toAnnouncementAddPage() {
        return "system/announcement_add";
    }

    /**
     * 保存公告信息
     * @param announcementType      公告类型
     * @param announcementTitle     公告标题
     * @param announcementContent   公告内容
     * @return
     */
    @RequestMapping("/ajax_save_announcement.do")
    @ResponseBody
    public BussinessMsg ajaxSaveAnnouncement(Integer announcementType, String announcementTitle,String announcementContent){
        try {
            return announcementInfoService.saveAnnouncementInfo(announcementType,announcementTitle,announcementContent,this.getCurrentLoginName());
        } catch (Exception e) {
            log.error("保存公告信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_SAVE_ERROR);
        }
    }

    /**
     * 公告详情页面
     * @param model
     * @param announcementId 公告Id
     * @return
     */
    @RequestMapping("/announcement_detail.do")
    public String toAnnouncementDetailPage(Model model, Integer announcementId) {
        AnnouncementInfo announcementInfo = announcementInfoService.selectAnnouncementInfoById(announcementId);
        model.addAttribute("announcementInfo",announcementInfo);
        return "system/announcement_detail";
    }

    /**
     * 删除公告
     * @param announcementId 公告Id
     * @return
     */
    @RequestMapping("/ajax_del_announcement.do")
    @ResponseBody
    public BussinessMsg ajaxDelAnnouncement(Integer announcementId){
        try {
            return announcementInfoService.deleteAnnouncementInfo(announcementId);
        } catch (Exception e) {
            log.error("删除公告信息方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

    /**
     * 查询用户未读公告信息
     * @return
     */
    @RequestMapping("/ajax_unread_anninfo_count.do")
    @ResponseBody
    public  Integer ajaxUnreadAnnInfoCount(){
        if(null != this.getCurrentLoginId()){
            Long unReadCount = announcementInfoMapper.selectUnreadAnnInfoCountByUserId(this.getCurrentLoginId());
            return unReadCount.intValue();
        }
        return 0;

    }
    /**
     * 查询用户已读公告信息
     * @return
     */
    @RequestMapping("/ajax_read_anninfo_count.do")
    @ResponseBody
    public  Integer ajaxReadAnnInfoCount(){
        if(null != this.getCurrentLoginId()){
            Long readCount = announcementInfoMapper.selectReadAnnInfoCountByUserId(this.getCurrentLoginId());
            return readCount.intValue();
        }
        return 0;

    }
    /**
     * 查询全部公告信息
     * @return
     */
    @RequestMapping("/ajax_allread_anninfo_count.do")
    @ResponseBody
    public  Integer ajaxAllReadAnnInfoCount(){
        Long allReadCount = announcementInfoMapper.selectAllReadAnnInfoCount();
        return allReadCount.intValue();

    }


    /**
     *跳转到未读公告列表页面
     * @return
     */
    @RequestMapping("/announcement_unread_list.do")
    public String toAnnouncementUnReadListPage() {
        return "system/announcement_unread_list";
    }

    /**
     * 未读公告列表List
     * @return
     */
    @RequestMapping("/ajax_unread_anninfo_list.do")
    @ResponseBody
    public String ajaxUnReadAnnInfoList() {
        return announcementInfoService.selectUnreadAnnInfoListByUserId(this.getCurrentLoginId());
    }
    /**
     * 已读公告列表List
     * @return
     */
    @RequestMapping("/ajax_read_anninfo_list.do")
    @ResponseBody
    public String ajaxReadAnnInfoList() {
        return announcementInfoService.selectReadAnnInfoListByUserId(this.getCurrentLoginId());
    }
    /**
     * 全部公告列表List
     * @return
     */
    @RequestMapping("/ajax_allread_anninfo_list.do")
    @ResponseBody
    public String ajaxAllReadAnnInfoList() {
        return announcementInfoService.selectAllReadAnnInfoListByUserId();
    }

    /**
     * 公告信息标记为已读
     * @param announcementId 公告Id
     * @return
     */
    @RequestMapping("/ajax_ins_read_anninfo_user.do")
    @ResponseBody
    public BussinessMsg ajaxReadAnnUserInfo(Integer announcementId){
        try {
            return announcementInfoService.insertReadAnnUserInfo(announcementId,this.getCurrentLoginId());
        } catch (Exception e) {
            log.error("公告信息标记为已读处理方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_USER_INSERT_ERROR);
        }
    }

    /**
     * 公告信息全部标记为已读
     * @param announcementIds 公告Ids
     * @return
     */
    @RequestMapping("/ajax_ins_allread_anninfo_user.do")
    @ResponseBody
    public BussinessMsg ajaxAllReadAnnUserInfo(@RequestParam(value = "announcementIds[]") Integer[] announcementIds){
        try {
            return announcementInfoService.insertAllReadAnnUserInfo(announcementIds, this.getCurrentLoginId());
        } catch (Exception e) {
            log.error("公告信息标记为已读处理方法内部错误",e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ROLE_FAILK_ERROR);
        }
    }
}
