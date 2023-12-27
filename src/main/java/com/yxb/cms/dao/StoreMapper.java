
package com.yxb.cms.dao;

import com.yxb.cms.domain.vo.Store;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StoreMapper
{

    int insert(Store store);

    Store selectStoreById(String userCode);


    Store findByStore(Store store);
}