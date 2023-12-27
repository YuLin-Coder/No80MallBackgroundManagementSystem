
package com.yxb.cms.dao;

import com.yxb.cms.domain.vo.Hourse;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HourseMapper
{
    List<Hourse> selectHourseByCondition(Hourse hourse);

    Long selectHourseCountByCondition(Hourse hourse);

    int insert(Hourse hourse);

    Hourse selectHourseById(Integer id);

    int update(Hourse hourse);

    int deleteHourseById(Integer id);

    List<Hourse> selectRoomServerByCondition(Hourse hourse);

    Long selectRoomServerCountByCondition(Hourse hourse);

    List<Hourse> findByAll(Hourse hourse);

    List<Hourse> findByAllOrderNo(Hourse hourse);

    void in_stack(Hourse hourse);
}