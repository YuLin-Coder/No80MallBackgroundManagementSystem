
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.dao.CommentMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Comment;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.nutz.json.Json;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CommentService
{

    private Logger log = LogManager.getLogger(CommentService.class);

    @Autowired
    private CommentMapper commentMapper;

    /**
     * 分页展示
     * @param comment
     * @return
     */
    public String selectListBypage(Comment comment) {

        List<Comment> list = commentMapper.selectCommentByCondition(comment);
        Long count = commentMapper.selectCommentCountByCondition(comment);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    /**
     * 保存
     * @param comment
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveInfo(Comment comment){
        try {
            commentMapper.insert(comment);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /**
     * 根据id删除
     * @param id
     * @return
     */
    @Transactional
    public BussinessMsg deleteById(Integer id){

        try {
            commentMapper.deleteCommentById(id);
        } catch (Exception e) {
            log.error("删除方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    //查询是否评论过
    public Comment findByMap(Map<String, Object> queryMap)
    {
        return commentMapper.findByMap(queryMap);
    }
}
