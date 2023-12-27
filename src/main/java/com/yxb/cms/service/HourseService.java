
package com.yxb.cms.service;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.dao.HourseMapper;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Hourse;
import com.yxb.cms.util.DateTimeUtil;
import com.yxb.cms.util.TokenUtil;
import java.util.Date;
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
public class HourseService
{

    private Logger log = LogManager.getLogger(HourseService.class);

    @Autowired
    private HourseMapper hourseMapper;

    /**
     * 分页展示
     * @param hourse
     * @return
     */
    public String selectListBypage(Hourse hourse) {
        List<Hourse> list = hourseMapper.selectHourseByCondition(hourse);
        Long count = hourseMapper.selectHourseCountByCondition(hourse);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    /**
     * 分页展示
     * @param hourse
     * @return
     */
    public String selectRoomServerListBypage(Hourse hourse) {
        List<Hourse> list = hourseMapper.selectRoomServerByCondition(hourse);
        Long count = hourseMapper.selectRoomServerCountByCondition(hourse);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", count);
        map.put("data", list);
        return Json.toJson(map);
    }

    /**
     * 保存
     * @param hourse
     * @return
     * @throws Exception
     */
    @Transactional
    public BussinessMsg saveInfo(Hourse hourse){
        try {
            hourse.setCreate_time(DateTimeUtil.dateTimeToLocalString(new Date()));
            hourse.setUser_code(TokenUtil.getCurrentUser().getRelationId());
            hourseMapper.insert(hourse);
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
            hourseMapper.deleteHourseById(id);
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
    public Hourse selectById(Integer id) {
        return hourseMapper.selectHourseById(id);
    }

    /**
     * 修改
     * @param hourse
     * @return
     */
    @Transactional
    public BussinessMsg update(Hourse hourse)
    {
        try {
            hourseMapper.update(hourse);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }

    /**
     * 查询所有的房间
     * @param hourse
     * @return
     */
    public String findByAll(Hourse hourse)
    {
        List<Hourse> list = hourseMapper.findByAll(hourse);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", list.size());
        map.put("data", list);
        return Json.toJson(map);
    }
    public String findByAllOrderNo(Hourse hourse)
    {
        List<Hourse> list = hourseMapper.findByAllOrderNo(hourse);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "");
        map.put("count", list.size());
        map.put("data", list);
        return Json.toJson(map);
    }
    //进货
    public BussinessMsg in_stack(Hourse hourse)
    {
        try {
            hourseMapper.in_stack(hourse);
        } catch (Exception e) {
            log.error("保存信息方法内部错误", e);
            throw e;
        }
        return BussinessMsgUtil.returnCodeMessage(BussinessCode.GLOBAL_SUCCESS);
    }
}
