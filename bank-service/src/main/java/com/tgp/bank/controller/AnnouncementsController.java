package com.tgp.bank.controller;

import com.tgp.bank.service.AnnouncementsService;
import model.AnnouncementsVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import utils.result.Result;
import utils.result.ResultCodeEnum;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author 关于废人张
 * @date 2024/3/23 0:31
 * @Description 管理員公告
 */
@Controller
public class AnnouncementsController {

    @Resource
    private AnnouncementsService announcementsService;

    @ResponseBody
    @GetMapping("/announcements/getNoticeList")
    public Result<List<AnnouncementsVO>> getAnnouncementsList() {
        return Result.build(announcementsService.getList(), ResultCodeEnum.SUCCESS);
    }

}
