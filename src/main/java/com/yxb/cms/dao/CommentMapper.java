
package com.yxb.cms.dao;

import com.yxb.cms.domain.vo.Comment;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentMapper
{
    List<Comment> selectCommentByCondition(Comment comment);

    Long selectCommentCountByCondition(Comment comment);

    int insert(Comment comment);
    
    int deleteCommentById(Integer id);

    Comment findByMap(Map<String, Object> queryMap);
}