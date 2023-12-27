
package com.yxb.cms.dao;

import com.yxb.cms.domain.vo.CommonCode;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonCodeMapper
{
    List<CommonCode> selectCommonCodeByCondition(CommonCode commonCode);

    Long selectCommonCodeCountByCondition(CommonCode commonCode);

    int insert(CommonCode commonCode);

    CommonCode selectCommonCodeById(Integer id);

    int update(CommonCode commonCode);

    int deleteCommonCodeById(Integer id);

    List<CommonCode> findByMap(Map<String, Object> query);
}