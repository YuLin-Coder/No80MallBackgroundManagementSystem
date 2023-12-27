package com.yxb.cms.controller.system;

import com.yxb.cms.architect.constant.BussinessCode;
import com.yxb.cms.architect.utils.BussinessMsgUtil;
import com.yxb.cms.controller.BasicController;
import com.yxb.cms.domain.bo.BussinessMsg;
import com.yxb.cms.domain.vo.Hourse;
import com.yxb.cms.service.HourseService;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("room_server")
public class RoomServerController extends BasicController
{

    @Autowired
    private HourseService hourseService;

    /**
     *跳转到列表页面
     * @return
     */
    @RequestMapping("/room_server_list.do")
    public String toListPage()
    {
        return "system/room_server/room_server_list";
    }

    /**
     * 列表List
     * @return
     */
    @RequestMapping("/ajax_room_server_list.do")
    @ResponseBody
    public String ajaxList(Hourse room_server)
    {
        return hourseService.selectRoomServerListBypage(room_server);
    }

    /**
     *跳转到新增页面
     * @return
     */
    @RequestMapping("/room_server_add.do")
    public String toAddPage(Model model)
    {
        model.addAttribute("type_name","房间服务");
        return "system/room_server/room_server_add";
    }

    /**
     * 保存信息
     * @return
     */
    @RequestMapping("/ajax_save_room_server.do")
    @ResponseBody
    public BussinessMsg ajaxSaveHourse(Hourse room_server)
    {
        try
        {
            return hourseService.saveInfo(room_server);
        }
        catch(Exception e)
        {
            log.error("保存信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_SAVE_ERROR);
        }
    }

    /**
     * 详情页面
     */
    @RequestMapping("/room_server_detail.do")
    public String toHourseDetailPage(Model model, Integer id)
    {
        Hourse room_server = hourseService.selectById(id);
        model.addAttribute("room_server", room_server);
        return "system/room_server/room_server_update";
    }


    /**
     * 保存信息
     * @return
     */
    @RequestMapping("/ajax_update_room_server.do")
    @ResponseBody
    public BussinessMsg update(Hourse room_server)
    {
        try
        {
            return hourseService.update(room_server);
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
    @RequestMapping("/ajax_del_room_server.do")
    @ResponseBody
    public BussinessMsg deleteById(Integer id)
    {
        try
        {
            return hourseService.deleteById(id);
        }
        catch(Exception e)
        {
            log.error("删除信息方法内部错误", e);
            return BussinessMsgUtil.returnCodeMessage(BussinessCode.ANNOUNCEMENT_DEL_ERROR);
        }
    }

    @RequestMapping(value = "/uploadHeadImage", method = { RequestMethod.POST })
    @ResponseBody
    public JSONObject uploadHeadImage(@RequestParam("file") MultipartFile file, HttpServletRequest req, ServletRequest servletRequest)
    {
        JSONObject result = new JSONObject();
        result.put("code", "200");
        try
        {
            MultipartHttpServletRequest shiroRequest = (MultipartHttpServletRequest) req;
            String path = shiroRequest.getSession().getServletContext().getRealPath("/upload");
            File realPath = new File(path);
            if(!realPath.exists())
            {
                realPath.mkdir();
            }
            //获取文件名
            String uploadFileName = file.getOriginalFilename();
            //获取上传文件名的后缀
            String[] splitStr = uploadFileName.split("\\.");
            String suffix = splitStr[splitStr.length - 1];
            String fileName = System.currentTimeMillis() + "." + suffix;
            result.put("data", fileName);
            InputStream is = file.getInputStream();
            OutputStream os = new FileOutputStream(new File(realPath, fileName));
            //读取写出
            int len = 0;
            byte[] buffer = new byte[1024];
            while((len = is.read(buffer)) != -1)
            {
                os.write(buffer, 0, len);
                os.flush();
            }
            os.close();
            is.close();
        }
        catch(Exception e)
        {
            result.put("code", "0");
            return result;
        }
        return result;
    }

}
