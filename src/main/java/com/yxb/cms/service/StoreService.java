
package com.yxb.cms.service;

import com.yxb.cms.dao.StoreMapper;
import com.yxb.cms.domain.vo.Store;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StoreService
{

    @Autowired
    private StoreMapper storeMapper;

    /**
     * 根据userCode查询
     */
    public Store selectById(String  userCode) {
        return storeMapper.selectStoreById(userCode);
    }

}
