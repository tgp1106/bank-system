package com.tgp.bank.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tgp.bank.mapper.AnnouncementsMapper;
import com.tgp.bank.mapper.ScheduledAnnouncementsMapper;
import com.tgp.bank.service.AnnouncementsService;
import dto.AnnouncementsDTO;
import entity.Announcements;
import entity.ScheduledAnnouncements;
import enums.SendOptionEnum;
import lombok.extern.slf4j.Slf4j;
import model.AnnouncementsVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author 关于废人张
 * @date 2024/3/23 0:32
 * @Description
 */
@Service
@Slf4j
public class AnnouncementsServiceImpl implements AnnouncementsService {

    @Resource
    private AnnouncementsMapper announcementsMapper;
    @Resource
    private ScheduledAnnouncementsMapper scheduledAnnouncementsMapper;

    @Override
    public List<AnnouncementsVO> getList() {
        List<Announcements> announcementsList = announcementsMapper.selectList(new LambdaQueryWrapper<>());
        if (CollectionUtil.isEmpty(announcementsList)) {
            return null;
        }
        return announcementsList.stream()
                .map(AnnouncementsVO::convertToVO)
                .collect(Collectors.toList());
    }

    /**
     * 发布分为定时发布和立即发布
     * 定时发布，通过定时任务执行
     */
    @Override
    public void publishAnnouncement(AnnouncementsDTO announcementsDTO) {
        int sendOption = announcementsDTO.getSendOption();
        // 0-表示立即发送
        if (sendOption == SendOptionEnum.NOW.getOption()) {
            Announcements announcements = new Announcements()
                    .setAuthor(announcementsDTO.getAuthor())
                    .setPublishedAt(new Date())
                    .setContent(announcementsDTO.getContent());
            announcementsMapper.insert(announcements);
        } else {
            ScheduledAnnouncements scheduledAnnouncement = new ScheduledAnnouncements()
                    .setAuthor(announcementsDTO.getAuthor())
                    .setPublishedAt(announcementsDTO.getPublishedAt())
                    .setContent(announcementsDTO.getContent());
            scheduledAnnouncementsMapper.insert(scheduledAnnouncement);
        }
    }
}
