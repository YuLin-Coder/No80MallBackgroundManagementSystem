
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.dao.CommonCodeMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.CommonCode;
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
public class CommonCodeService
{

    private Logger log = LogManager.getLogger(CommonCodeService.class);

    @Autowired
    private CommonCodeMapper commonCodeMapper;

    /**
     * 分页展示
     * @param commonCode
     * @return
     */
    public String selectListBypage(CommonCode commonCode) {
        List<CommonCode> list = commonCodeMapper.selectCommonCodeByCondition(commonCode);
        Long count = commonCodeMapper.selectCommonCodeCountByCondition(commonCode);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    /**
     * 保存
     * @param commonCode
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveInfo(CommonCode commonCode){
        try {
            commonCodeMapper.insert(commonCode);
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
            commonCodeMapper.deleteCommonCodeById(id);
        } catch (Exception e) {
            log.error("删除方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);

    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public CommonCode selectById(Integer id) {
        return commonCodeMapper.selectCommonCodeById(id);
    }

    /**
     * 修改
     * @param commonCode
     * @return
     */
    @Transactional
    public BussinessMsg update(CommonCode commonCode)
    {
        try {
            commonCodeMapper.update(commonCode);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }
    /**
     * 根据code查询
     * @param query
     * @return
     */
    public List<CommonCode> findByMap(Map<String, Object> query)
    {
        return commonCodeMapper.findByMap(query);
    }
}
