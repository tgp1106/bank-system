package com.tgp.bank.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.tgp.bank.mapper.AnnouncementsMapper;
import com.tgp.bank.service.AnnouncementsService;
import entity.Announcements;
import lombok.extern.slf4j.Slf4j;
import model.AnnouncementsVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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

    @Override
    public List<AnnouncementsVO> getList() {
        log.info("正在獲取公告信息");
        List<Announcements> announcementsList = announcementsMapper.selectList(new LambdaQueryWrapper<>());
        if (CollectionUtil.isEmpty(announcementsList)) {
            return null;
        }
        return announcementsList.stream()
                .map(AnnouncementsVO::convertToVO)
                .collect(Collectors.toList());
    }
}
