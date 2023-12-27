package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Comment;
import com.yxb.cms.service.CommentService;
import com.yxb.cms.util.TokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("comment")
public class CommentController extends BasicController
{

    @Autowired
    private CommentService commentService;

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/comment_list.do")
    public String toListPage()
    {
        return "system/comment/comment_list";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/ajax_comment_list.do")
    @ResponseBody
    public String ajaxList(Comment comment)
    {
        if(!"20210410161112".equals(TokenUtil.getCurrentUser().getRelationId())){
            comment.setDianpu_code(TokenUtil.getCurrentUser().getRelationId());
        }

        return commentService.selectListBypage(comment);
    }

    /**
     *跳转到新增页面
     * @return
     */
    @RequestMapping("/comment_add.do")
    public String toAddPage()
    {
        return "system/comment/comment_add";
    }

    /**
     * 保存信息
     * @return
     */
    @RequestMapping("/ajax_save_comment.do")
    @ResponseBody
    public BussinessMsg ajaxSaveComment(Comment comment)
    {
        try
        {
            return commentService.saveInfo(comment);
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
    @RequestMapping("/ajax_del_comment.do")
    @ResponseBody
    public BussinessMsg deleteById(Integer id)
    {
        try
        {
            return commentService.deleteById(id);
        }
        catch(Exception e)
        {
            log.error("删除信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }


}
